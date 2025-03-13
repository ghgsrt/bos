(define-module (home services shells)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:use-module (packages shells)
  #:export (zsh-services))

(define core-packages-cli-service-type
  (bos-home-service-type 'bos-core-packages-cli
			 #:packages core-packages-cli))

;; ~~ ZSH ~~

(define zsh-services
  (list (service core-packages-cli-service-type) 
	(service home-zsh-service-type)))

