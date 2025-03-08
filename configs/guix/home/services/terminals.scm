(define-module (home services terminals)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (foot-services))

;; ~~ FOOT ~~

(define foot-service-type
  (bos-home-service-type 'bos-foot
	#:packages (list foot)))

(define foot-services
	(list (service foot-service-type)))
