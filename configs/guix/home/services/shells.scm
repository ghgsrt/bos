(define-module (home services shells)
  #:use-module (home)
  #:use-module (services)
  #:use-module (packages shells)
  #:export (home/services/zsh))

(define packages/cli-service
  (bos-home-service 'bos-packages-cli
		    #:packages packages/cli))

;; ~~ ZSH ~~

(define home/services/zsh
  (list packages/cli-service 
	(service home-zsh-service-type)))

