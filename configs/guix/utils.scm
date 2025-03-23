(define-module (utils)
  #:use-module (hack modify-services)

  #:use-module (guix packages)
  #:use-module (gnu services)

  #:use-module (srfi srfi-1)
  #:use-module (ice-9 ftw)
  #:use-module (ice-9 match)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 rdelim)

  #:re-export (modify-services-silently
	       delete) ; for modify-services clause
  #:export (symbol->value
	    export-list
	    re-export-list
	    re-export-all
	    ensure-list
	    pick-field
	    service->name-string
	    service-has-prefix
	    svc-eq?
	    pkg-eq?
	    define-lazy
	    try-load
	    load-channels
	    load-dir))

(define-syntax symbol->value
  (syntax-rules ()
    ((_ sym)
     (catch #t
	    (lambda _ (module-ref (current-module) (if (string? sym)
				    (string->symbol sym)
				    sym)))
	    (lambda _ *unspecified*)))))

(define-syntax export-list
  (syntax-rules ()
    ((_ lst)
      (macroexpand `(export ,@lst)))))

(define-syntax re-export-list
  (syntax-rules ()
    ((_ lst)
      (macroexpand `(re-export ,@lst)))))

(define-syntax re-export-all
  (syntax-rules ()
    ((_)
     (re-export-list
       (apply append (map (lambda (inter)
			    (module-map (lambda (sym var) sym) inter))
			  (module-uses (current-module))))))))

(define (ensure-list val)
  (cond ((list? val) val)
        ((not val) '())
        (else (list val))))

(define (service->name-string svc)
  (symbol->string (service-type-name (service-kind svc))))

(define (service-has-prefix pref)
  (lambda (svc)
    (string-prefix? (if (symbol? pref)
		      (symbol->string pref)
		      pref)
		    (service->name-string svc))))

(define (svc-eq? a b)
  (equal? (service-kind a)
	  (service-kind b)))

(define (pkg-eq? a b)
  (string=? (package-name a)
	    (package-name b)))

(define (pick-field a b nullish)
  (lambda* (field #:optional (leqp equal?) #:key (replace? #f))
    (let ((a-field (field a))
	  (b-field (field b))
	  (nullish-field (field nullish)))
	 (cond
	   ;((nullish? a) b) ; ensures the nullish values (in the case of lists) will still be included
	   ((equal? b-field nullish-field) a-field)
	   ((and (not replace?) (list? a-field) (list? b-field))
	     (lset-union leqp b-field a-field)) ; give b precedence (same items will use b's)
	   (else b-field)))))

(define-syntax define-lazy
  (lambda (x)
    (syntax-case x ()
      ((_ name computation ...)
        (let* ((name-sym (syntax->datum #'name))
	       (func-name-sym (string->symbol (string-append "<" (symbol->string name-sym) ">")))
	       (func-name (datum->syntax #'name func-name-sym)))
	  (with-syntax ((func-name func-name))
	    #'(begin
		(define func-name (delay (begin computation ...)))
		(define-syntax name
		  (identifier-syntax (force func-name))))))))))

(define dotfiles-dir (getenv "DOTFILES_DIR"))

(define (try-load path)
  (catch #t
	 (lambda _ (load path))
	 (lambda _ #f)))

(define* (load-dir dir
		  #:key
		  (exclude '()) ; List of regex patterns to exclude
		  (verbose #t)
		  (recursive #f))
  "Load all Scheme files recursively from DIR.
  Optional arguments:
  #:exclude - List of regex patterns for files/dirs to exclude
  #:verbose - Whether to print loading messages"
  (let ((scheme-file? (make-regexp ".*\\.scm$"))
	(exclude-patterns (map make-regexp exclude)))
    (define (excluded? path)
      (any (lambda (pattern)
	     (regexp-exec pattern path))
	   exclude-patterns))
    (define (load-file filename statinfo flag)
      (match flag
	     ('regular
	      (when (and (regexp-exec scheme-file? filename)
			 (not (excluded? filename)))
		(when verbose
		  (format #t "Loading ~a...~%" filename))
		(catch #t
		       (lambda ()
			 (load filename))
		       (lambda (key . args)
			 (format (current-error-port)
				 "Error loading ~a: ~a ~a~%"
				 filename key args))))
	      #t)
	     ; ('directory (or recursive 'skip))
	     (_ (not (excluded? filename))))) 

    (if recursive (ftw dir load-file) (ftw dir load-file 1))))

