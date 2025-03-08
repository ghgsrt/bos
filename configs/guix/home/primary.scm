(define-module (home primary)
  #:use-module (home)
  #:use-module (home base)
  #:use-module (home services desktop)
  #:use-module (home services terminals)
  #:use-module (packages)
  #:use-module (services)
  #:export (primary@minimal-home))

(define primary@minimal-home-service-type
	(bos-home-service-type 'bos-primary@minimal-home
		#:packages (list )
		#:env-vars '(("BOS_HOME_NAME" . "primary"))))

(define primary@minimal-home
	(home-environment
		(services (append (list (service primary@minimal-home-service-type))
						  %bos-base-home-services
						  sway@minimal-services
						  foot-services))))
primary@minimal-home
