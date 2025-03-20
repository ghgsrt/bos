(define-module (home)
  #:use-module (services)
  #:use-module (utils)
  #:use-module (srfi srfi-1)
  #:export (bos-home-services
	    home/empty
	    bos-home-environment

	    home-profile-service-prefix
	    home-profile-service?

	    home-environment-service-prefix
	    home-environment-service?))

(define home-profile-service-prefix 'home-profile-)
(define home-environment-service-prefix 'home-environment-)

(define home-profile-service? (service-has-prefix home-profile-service-prefix))
(define home-environment-service? (service-has-prefix home-environment-service-prefix))

(define* (bos-home-services name #:key (modules #f) (packages #f) (env-vars #f) (services #f))
  (append (if modules
	    (bos-module->home-services modules)
	    '())
	  (if packages
	    `(,(simple-service (symbol-append home-profile-service-prefix name '-bos)
			       home-profile-service-type
			       (ensure-list packages)))
	    '())
	  (if env-vars
	    `(,(simple-service (symbol-append home-environment-service-prefix name '-bos)
			       home-environment-variables-service-type
			       env-vars))
	    '())
	  (if services (ensure-list services) '())))

(define home/empty (home-environment))

(define (merge-homes _b a) ; fold order
  (let ((b (if (procedure? _b) (_b a) _b)))
    (define pick (pick-field a b home/empty))
    (home-environment
      (packages (pick home-environment-packages pkg-eq?))
      (services (pick home-environment-user-services svc-eq?)))))

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

