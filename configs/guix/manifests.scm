(define-module (manifests)
  #:use-module (guix records)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 format)
  #:export (generate-project-manifest
            feature->manifest))

(define* (feature->manifest feature #:key (versions '()))
  (let ((override-versions
          (lambda (pkg)
            (let ((override (assoc-ref versions (package-name pkg))))
              (if override
                  (specification->package
                    (string-append (package-name pkg) "@" override))
                  pkg)))))
    (packages->manifest
      (map override-versions (feature-packages feature)))))

;; Record type for our manifest entries
(define-record-type* <manifest-entry>
  make-manifest-entry manifest-entry?
  (name manifest-name)                    ; string
  (depends manifest-depends)              ; alist of (tool . version)
  (minimum manifest-minimum)              ; number or list of strings
  (builder manifest-builder)              ; function
  (priority manifest-priority             ; number (default 0)
            (default 0))
  (implicit manifest-implicit?            ; boolean (default #t)
            (default #t)))

(define* (generate-project-manifest found-tools #:key (allow-higher-versions #f))
  (let* ((remaining-tools found-tools)
         (selected-entries '()))

    ;; Helper to update remaining tools after selecting an entry
    (define (update-remaining! entry)
      (set! remaining-tools
            (filter (lambda (tool)
                     (not (assoc (car tool) (manifest-depends entry))))
                   remaining-tools))
      (set! selected-entries (cons entry selected-entries)))

    ;; 1. Look for exact complete matches (no minimum)
    (let ((exact-match
           (find (lambda (entry)
                  (and (not (manifest-minimum entry))
                       (equal? (map car (manifest-depends entry))
                             (map car found-tools))
                       (entry-valid? entry found-tools allow-higher-versions)))
                manifest-registry)))
      (when exact-match
        (update-remaining! exact-match)
        (return-manifests selected-entries)))

    ;; 2. Look for exact subset matches (no minimum)
    (let loop ((size (length remaining-tools)))
      (when (> size 0)
        (let ((subset-match
               (find (lambda (entry)
                      (and (not (manifest-minimum entry))
                           (= size (length (manifest-depends entry)))
                           (every (lambda (dep)
                                  (assoc (car dep) remaining-tools))
                                (manifest-depends entry))
                           (entry-valid? entry found-tools allow-higher-versions)))
                    (sort manifest-registry
                          (lambda (e1 e2)
                            (positive? (compare-entries e1 e2 found-tools)))))))
          (if subset-match
              (begin
                (update-remaining! subset-match)
                (loop size))
              (loop (- size 1))))))

    ;; 3. Look for entries with minimum specifications
    (let minimum-loop ()
      (if (null? remaining-tools)
          (return-manifests selected-entries)
          (let ((best-minimum
                 (find-best-minimum-entry remaining-tools found-tools allow-higher-versions)))
            (if (not best-minimum)
                ;; No valid minimum entries, move to atomics
                (use-atomics-for-remaining)
                ;; Check if best minimum only handles one tool
                (let ((handles-count
                       (length (filter (lambda (dep)
                                      (assoc (car dep) remaining-tools))
                                    (manifest-depends best-minimum)))))
                  (if (<= handles-count 1)
                      ;; Switch to atomics for all remaining
                      (use-atomics-for-remaining)
                      ;; Use this minimum entry and continue
                      (begin
                        (update-remaining! best-minimum)
                        (minimum-loop))))))))

    ;; Helper to use atomic manifests for remaining tools
    (define (use-atomics-for-remaining)
      (for-each (lambda (tool)
                  (let ((atomic (find-atomic-manifest (car tool))))
                    (update-remaining! atomic)))
                remaining-tools)
      (return-manifests selected-entries))

    ;; Helper to find best minimum entry
    (define (find-best-minimum-entry remaining all-tools allow-higher?)
      (let* ((valid-entries
              (filter (lambda (entry)
                       (and (manifest-minimum entry)
                            (entry-valid? entry all-tools allow-higher?)))
                     manifest-registry))
             (sorted-entries
              (sort valid-entries
                    (lambda (e1 e2)
                      (positive? (compare-entries e1 e2 all-tools))))))
        (find (lambda (entry)
                (any (lambda (dep)
                      (assoc (car dep) remaining))
                    (manifest-depends entry)))
              sorted-entries)))

    ;; Helper to find atomic manifest for a tool
    (define (find-atomic-manifest tool-name)
      (or (find (lambda (entry)
                 (and (= 1 (length (manifest-depends entry)))
                      (equal? tool-name (caar (manifest-depends entry)))))
               manifest-registry)
          (error "No atomic manifest found for tool:" tool-name)))

    ;; Helper to combine manifests respecting version precedence
    (define (return-manifests entries)
      (let ((packages
       (fold (lambda (entry acc-packages)
               (let ((new-packages (manifest-packages
                                  ((manifest-builder entry) found-tools))))
                 ;; Only add packages not already in accumulator
                 (append acc-packages
                         (filter (lambda (pkg)
                                 (not (find (lambda (acc-pkg)
                                            (string=? (package-name pkg)
                                                    (package-name acc-pkg)))
                                          acc-packages)))
                                new-packages))))
             '()
             (reverse selected-entries))))
		;; Return serializable manifest form instead of direct manifest object
		`(manifest
		(version 3)
		(packages ,(map (lambda (pkg)
							`(package
							(name ,(package-name pkg))
							(version ,(package-version pkg))
							(output "out")
							(item ,pkg)))
						packages)))))))

;; Version requirement types:
;; 'exact - exact version match (e.g., "1.21")
;; 'ge - greater than or equal (e.g., ">=1.21")
;; 'le - less than or equal (e.g., "<=1.21")
;; 'gt - greater than (e.g., ">1.21")
;; 'lt - less than (e.g., "<1.21")
;; 'range - version range (e.g., "5.0 .. 6.5")
;; 'latest - latest version
;; 'any - any version (empty string)

(define (parse-version-requirement ver-str)
  (cond
   ((string-null? ver-str)
    '(any))
   ((string=? ver-str "latest")
    '(latest))
   ((string-match "^>=(.+)$" ver-str) =>
    (lambda (m) `(ge ,(match:substring m 1))))
   ((string-match "^>(.+)$" ver-str) =>
    (lambda (m) `(gt ,(match:substring m 1))))
   ((string-match "^<=(.+)$" ver-str) =>
    (lambda (m) `(le ,(match:substring m 1))))
   ((string-match "^<(.+)$" ver-str) =>
    (lambda (m) `(lt ,(match:substring m 1))))
   ((string-match "^([0-9.]+)\\s*\\.\\.\\s*([0-9.]+)$" ver-str) =>
    (lambda (m) `(range ,(match:substring m 1) ,(match:substring m 2))))
   (else
    `(exact ,ver-str))))

(define (version->list version-str)
  ;; Convert version string to list of numbers
  ;; e.g., "1.21.3" -> (1 21 3)
  (map string->number
       (string-split version-str #\.)))

(define (version-compare v1 v2)
  ;; Compare two version strings
  ;; Returns -1 if v1 < v2, 0 if equal, 1 if v1 > v2
  (let loop ((parts1 (version->list v1))
            (parts2 (version->list v2)))
    (match (cons parts1 parts2)
      ((() . ()) 0)
      ((() . (_)) -1)
      ((_ . ()) 1)
      (((n1 . rest1) . (n2 . rest2))
       (cond
        ((< n1 n2) -1)
        ((> n1 n2) 1)
        (else (loop rest1 rest2)))))))

(define (version-satisfies? required-spec actual)
  (match required-spec
    (('any) #t)
    (('latest) #t)  ; Placeholder - would need actual latest version info
    (('exact ver)
     (= 0 (version-compare actual ver)))
    (('ge ver)
     (>= (version-compare actual ver) 0))
    (('gt ver)
     (> (version-compare actual ver) 0))
    (('le ver)
     (<= (version-compare actual ver) 0))
    (('lt ver)
     (< (version-compare actual ver) 0))
    (('range v1 v2)
     (and (>= (version-compare actual v1) 0)
          (<= (version-compare actual v2) 0)))))

(define (compare-version-requirements req1 req2 actual)
  (match (cons req1 req2)
    ;; Handle exact matches first - they always win
    ((('exact v1) . _)
     (if (equal? v1 actual) 1 -1))
    ((_ . ('exact v2))
     (if (equal? v2 actual) -1 1))

    ;; Handle ranges
    ((('range v1-min v1-max) . ('range v2-min v2-max))
     (let ((range1-size (version-compare v1-max v1-min))
           (range2-size (version-compare v2-max v2-min)))
       ;; Smaller range wins
       (- range2-size range1-size)))

    ;; Greater than types - closer to actual wins
    ((('ge v1) . ('ge v2))
     (let ((diff1 (version-compare actual v1))
           (diff2 (version-compare actual v2)))
       (if (= diff1 diff2)
           0
           (if (< diff1 diff2) 1 -1))))

    ;; Less than types - closer to actual wins
    ((('le v1) . ('le v2))
     (let ((diff1 (version-compare v1 actual))
           (diff2 (version-compare v2 actual)))
       (if (= diff1 diff2)
           0
           (if (< diff1 diff2) 1 -1))))

    ;; Default comparison
    (_ 0)))

;; Helper to calculate points for subtool version specs
(define (calculate-subtool-points ver-spec)
  (match (parse-version-requirement ver-spec)
    (('any) 0)
    (('ge _) 1)
    (('gt _) 1)
    (('latest) 1)
    (('le _) -1)
    (('lt _) -1)
    (('range _ _) -1)
    (_ 0)))

;; Helper to check if a tool is an important tool
;; This should match each primary case in detect_tools() in generate-manifest.sh
(define (important-tool? tool-name)
  (member tool-name important-tools))

;; Check if minimum requirement is met
(define (minimum-satisfied? entry found-tools)
  (let ((min (manifest-minimum entry))
        (matching-tools
         (filter (lambda (found)
                  (assoc (car found) (manifest-depends entry)))
                found-tools)))
    (cond
     ;; Numeric minimum
     ((number? min)
      (>= (length matching-tools) min))
     ;; List of required tools
     ((list? min)
      (every (lambda (required-tool)
              (and (assoc required-tool found-tools)
                   ;; Also verify version requirements
                   (let ((dep-version (assoc-ref (manifest-depends entry)
                                               required-tool))
                         (found-version (assoc-ref found-tools
                                                 required-tool)))
                     (version-satisfies?
                      (parse-version-requirement dep-version)
                      found-version))))
            min))
     (else #t))))  ; No minimum requirement

;; Check if all version requirements are met
(define (versions-satisfied? entry found-tools allow-higher?)
  (every (lambda (dep)
          (let* ((tool-name (car dep))
                 (found-tool (assoc tool-name found-tools)))
            (if found-tool
                (let ((req-spec (parse-version-requirement (cdr dep)))
                     (actual-version (cdr found-tool)))
                  (if (and allow-higher?
                          (eq? (car req-spec) 'exact))
                      (>= (version-compare actual-version (cadr req-spec)) 0)
                      (version-satisfies? req-spec actual-version)))
                #t)))  ; Tool not found = requirement satisfied
        (manifest-depends entry)))

;; Main entry validation
(define (entry-valid? entry found-tools allow-higher?)
  (and (manifest-implicit? entry)  ; Only consider implicit entries
       (minimum-satisfied? entry found-tools)
       (versions-satisfied? entry found-tools allow-higher?)))

;; Compare same-tool version requirements
(define (compare-tool-versions e1 e2 tool-name found-version)
  (let ((v1 (parse-version-requirement
             (assoc-ref (manifest-depends e1) tool-name)))
        (v2 (parse-version-requirement
             (assoc-ref (manifest-depends e2) tool-name))))
    (compare-version-requirements v1 v2 found-version)))

;; Compare entries by subtool points
(define (compare-subtool-points e1 e2)
  (let* ((e1-subtools (filter (lambda (dep)
                               (not (important-tool? (car dep))))
                             (manifest-depends e1)))
         (e2-subtools (filter (lambda (dep)
                               (not (important-tool? (car dep))))
                             (manifest-depends e2)))
         (e1-points (apply + (map (lambda (dep)
                                  (calculate-subtool-points (cdr dep)))
                                e1-subtools)))
         (e2-points (apply + (map (lambda (dep)
                                  (calculate-subtool-points (cdr dep)))
                                e2-subtools))))
    (- e1-points e2-points)))

;; Main entry comparison
(define (compare-entries e1 e2 found-tools)
  (let ((e1-matches (filter (lambda (found)
                             (assoc (car found) (manifest-depends e1)))
                           found-tools))
        (e2-matches (filter (lambda (found)
                             (assoc (car found) (manifest-depends e2)))
                           found-tools))
        (all-tools (map car found-tools)))

    ;; Compare based on our priority rules
    (cond
     ;; 1. Exact match for all tools
     ((and (= (length e1-matches) (length found-tools))
           (not (= (length e2-matches) (length found-tools))))
      1)
     ((and (not (= (length e1-matches) (length found-tools)))
           (= (length e2-matches) (length found-tools)))
      -1)

     ;; 2 & 3. Compare based on minimum matches
     ((not (= (length e1-matches) (length e2-matches)))
      (- (length e1-matches) (length e2-matches)))

     ;; 4. Compare version requirements for matching tools
     (else
      (let loop ((tools (filter important-tool? all-tools)))
        (if (null? tools)
            ;; If all tool versions match, try other tiebreakers
            (cond
             ;; Compare priorities
             ((not (= (manifest-priority e1) (manifest-priority e2)))
              (- (manifest-priority e1) (manifest-priority e2)))
             ;; Compare subtool points
             ((not (= 0 (compare-subtool-points e1 e2)))
              (compare-subtool-points e1 e2))
             ;; Finally, compare names
             (else
              (string-compare (manifest-name e1) (manifest-name e2))))
            ;; Compare next tool's version requirements
            (let* ((tool (car tools))
                   (found-version (assoc-ref found-tools tool))
                   (ver-compare (compare-tool-versions
                               e1 e2 tool found-version)))
              (if (= 0 ver-compare)
                  (loop (cdr tools))
                  ver-compare))))))))
