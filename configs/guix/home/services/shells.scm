(define-module (home services shells)
  #:use-module (home)
  #:use-module (packages shells)
  #:use-module (gnu services)
  #:use-module (gnu home services shells)
  #:export (home/services/zsh))

;; ~~ ZSH ~~

(define home/services/zsh
  (bos-home-services 'zsh
    #:packages packages/cli
    #:services (service home-zsh-service-type)))

