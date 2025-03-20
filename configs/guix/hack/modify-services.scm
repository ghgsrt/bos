(define-module (hack modify-services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:export (modify-services-silently))

;; A variation of 'modify-services' that simply skips clauses which are not found in the service list
;;  so you don't have to guarantee a specific state within service lists you're modifying

(define (service->name-string service)
  (symbol->string (service-type-name (service-kind service))))

(define-syntax clause-alist
  (syntax-rules (=> delete)
    "Build an alist of clauses.  Each element has the form (KIND PROC LOC)
where PROC is the service transformation procedure to apply for KIND, and LOC
is the source location information."
    ((_ (delete kind) rest ...)
     (cons (list kind
                 (lambda (service)
                   #f)
                 (current-source-location)
                 'delete)
           (clause-alist rest ...)))
    ((_ (type kind param => exp ...) rest ...)
     (cons (list kind
                 (lambda (svc)
                   (let ((param (service-value svc)))
                     (service (service-kind svc)
                              (begin exp ...))))
                 (current-source-location)
                 type)
           (clause-alist rest ...)))
    ((_ (kind param => exp ...) rest ...)
     (cons (list kind
                 (lambda (svc)
                   (let ((param (service-value svc)))
                     (service (service-kind svc)
                              (begin exp ...))))
                 (current-source-location)
                 'full)
           (clause-alist rest ...)))
    ((_)
     '())))

(define (apply-clauses clauses service deleted-services)
  "Apply CLAUSES, an alist as returned by 'clause-alist', to SERVICE.  An
  exception is raised if a clause attempts to modify a service
  present in DELETED-SERVICES."
  (define (raise-if-deleted kind properties)
    (match (find (match-lambda
                   ((deleted-kind _)
                    (eq? kind deleted-kind)))
                 deleted-services)
           ((_ deleted-properties)
            (raise (make-compound-condition
                     (condition
                       (&error-location
                         (location (source-properties->location properties))))
                     (formatted-message
                       (G_ "modify-services: service '~a' was deleted here: ~a")
                       (service-type-name kind)
                       (source-properties->location deleted-properties)))))
           (_ #t)))

  (match clauses
         (((kind proc properties type) . rest)
          (raise-if-deleted kind properties)
          (if (match type
                     ('prefix (and service (string-prefix? (symbol->string kind)
                                                           (service->name-string service))))
                     ('suffix (and service (string-suffix? (symbol->string kind)
                                                           (service->name-string service))))
                     (_ (eq? (and service (service-kind service)) kind)))
            (let ((new-service (proc service))
                  (kind (service-kind service)))
              (display kind)
              (apply-clauses rest new-service
                             (if new-service
                               deleted-services
                               (cons (list kind properties)
                                     deleted-services))))
            (apply-clauses rest service deleted-services)))
         (()
          service)))

(define (%modify-services-silently services clauses)
  "Apply CLAUSES, an alist as returned by 'clause-alist', to SERVICES. Clauses
  which do not apply to the specified services list are simply ignored."
 ; (let ((clauses (filter (lambda (clause)
 ;                          (find (lambda (service)
 ;                                  (match (cadddr clause)
 ;                                    ("prefix")
 ;                                    (_ (eq? (car clause) (service-kind service)))
 ;                                services))
 ;                        _clauses)))
    (reverse (filter-map identity
                         (fold (lambda (service services)
                                 (cons (apply-clauses clauses service '())
                                       services))
                               '()
                               services))))

(define-syntax modify-services-silently
  (syntax-rules ()
    ((_ services clauses ...)
     (%modify-services-silently services (clause-alist clauses ...)))))

