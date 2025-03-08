(define-module (home services ssh)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (ssh-services))

(define ssh-packages-service-type
  (bos-home-service-type 'bos-ssh-packages
	#:packages (list openssh)))

(define ssh-services
  (list (service ssh-packages-service-type)
	 ; (service home-openssh-service-type)
	 ))
