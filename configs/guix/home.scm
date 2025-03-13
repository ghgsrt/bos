(define-module (home)
	       #:use-module (services)
	       #:export (compose-home
			  bos-home-service))

(define (compose-home base . extensions)
  (home-environment
    (packages (append (home-environment-packages base)
		      (apply append (map home-environment-packages extensions))))
    (services (append (home-environment-services base)
		      (apply append (map home-environment-user-services extensions))))))

(define* (bos-home-service type name #:key (packages '()) (env-vars '()))
	 (service (service-type
	   (name name)
	   (description "A convenience service type for associating packages and environment variables for home environments.")
	   (extensions 
	     (append (if (null? packages) 
		       '() 
		       (list (service-extension 
			       home-profile-service-type
			       (lambda (_) packages))))
		     (if (null? env-vars)
		       '()
		       (list (service-extension
			       home-environment-variables-service-type
			       (lambda (_) env-vars))))))
	   (default-value #f))))

