(define-module (home services dev)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages guile-xyz)
  #:export (guile-services))

;; ~~ GUILE ~~

(define guile-packages-service-type
	(bos-home-service-type 'bos-guile-packages
		#:packages (list guile-3.0
				 guile-fibers
						guile-colorized
						 guile-g-golf
						 guile-json-4
						 guile-uuid)))

(define guile-services
	(list (service guile-packages-service-type)))
