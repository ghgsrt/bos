(define-module (bos home empty)
	#:use-module (bos channels)
	#:use-module (gnu home)
	#:use-module (gnu home services)
	#:export (empty-home
		  empty-home-free
		  empty-home-non-free))

(define* (empty-home #:key (non-free? #f)) 
  (home-environment
    (services (modify-services %base-services
	        (guix-service-type config => (guix-configuration
	 				       (inherit config)
					       (channels (if non-free? 
							   %non-free-channels
							   %free-channels))))))))

(define empty-home-free (extend-home (empty-home)))
(define empty-home-non-free (extend-home (empty-home #:non-free? #t)))

empty-home-free

