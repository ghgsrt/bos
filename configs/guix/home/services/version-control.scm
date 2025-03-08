(define-module (home services version-control)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (git-services))

;; ~~ GIT ~~

(define git-packages-service-type
	(bos-home-service-type 'bos-git-packages
		#:packages (list git)))

(define git-services
	(list (service git-packages-service-type)))
