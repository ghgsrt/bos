(define-module (home)
  #:use-module (utils)
  #:use-module (gnu services)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (srfi srfi-1)
  #:export (;name->home-environment
	    bos-home-services
	    home/empty
	    bos-home-environment

	    home-profile-service-prefix
	    home-profile-service?

	    home-environment-service-prefix
	    home-environment-service?))


;(define-syntax name->home-environment
;  (syntax-rules ()
;    ((_ name)
;     (or (name->value name)
;	 (call/cc
;	   (lambda (return)
;	     (module-map
;	       (lambda (sym var)
;		 (let ((home-cand (variable-ref var)))
;		 (display sym)
;		 (newline)
;		 (display (home-environment? home-cand))
;		 (newline)
;		 (when (home-environment? home-cand)
;		   (display (home-environment-name home-cand)))
;		 (when (and (home-environment? home-cand)
;			    (eq? (home-environment-name home-cand)
;				 (if (string? name)
;				   (string->symbol name)
;				   name)))
;		   (return var))))
;	       (current-module))
;	     #f))))))
;
;(define-syntax name->home-environment
;  (syntax-rules ()
;    ((_ name)
;     (or (name->value name)
;	 (find (lambda (sym)
;		 (and (bos-home-environment? sym)
;		      (eq? (bos-home-environment-name sym)
;			   (if (symbol? name)
;			     (symbol->string name)
;			     name))))
;	       (module-export (current-module)))))))
;

(define home-profile-service-prefix 'home-profile-)
(define home-environment-service-prefix 'home-environment-)

(define home-profile-service? (service-has-prefix home-profile-service-prefix))
(define home-environment-service? (service-has-prefix home-environment-service-prefix))

(define* (bos-home-services name #:key (modules #f) (packages #f) (env-vars #f) (services #f))
  (append (if packages
	    `(,(simple-service (symbol-append home-profile-service-prefix name '-bos)
			       home-profile-service-type
			       (ensure-list packages)))
	    '())
	  (if env-vars
	    `(,(simple-service (symbol-append home-environment-service-prefix name '-bos)
			       home-environment-variables-service-type
			       env-vars))
	    '())
	  (lset-union svc-eq?
		      (if services (ensure-list services) '())
		      (if modules
			(bos-module->home-services modules)
			'()))))

(define home/empty (home-environment))

(define (merge-homes b a) ; fold order
  (if (procedure? b)
    (b a)
  (let ((pick (pick-field a b home/empty)))
    (home-environment
      (packages (pick home-environment-packages pkg-eq?))
      (services (pick home-environment-user-services svc-eq?))))))

(define* (bos-home-environment name #:key
			      (modules #f)
			      (inherits '())
			      (modified-by '())
			      (env-vars '())
			      (home home/empty))
  (let ((he (fold merge-homes
		  home/empty
		  (append (ensure-list inherits)
			  `(,home)
			  (ensure-list modified-by)))))
  (home-environment
    (inherit he)
    (services (lset-union
		svc-eq?
		(bos-home-services name
		  #:modules modules
		  #:env-vars (cons `("BOS_HOME_NAME" . ,(symbol->string name))
				   env-vars))
		(home-environment-user-services he))))))

