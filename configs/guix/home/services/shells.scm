(define-module (home services shells)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (zsh-services))

;; ~~ ZSH ~~

(define zsh-packages-service-type
  (bos-home-service-type 'bos-zsh-packages
	#:packages (list )))

(define zsh-services
  (list (service zsh-packages-service-type)
		(service home-zsh-service-type)
		))
