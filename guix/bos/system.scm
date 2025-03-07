(define-module (bos system)
  #:use-module (bos utils)
  #:use-module (bos home)
  #:use-module (guix)
  #:use-module (gnu)
  #:use-module (gnu services guix)
  #:use-module (gnu system)
  #:use-module (guix gexp)     ; For local-file
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim))  ; For reading environment variables

;; Handles augmenting any arbitrary operating system to be compatible
;; with the bos dotfile setup

(define-public (extend-system base-system)
  (let ((base-services (operating-system-user-services base-system)))
    (operating-system
      (inherit base-system)
      (services
	(if (find (lambda (svc)
		    (equal? (service-kind svc)
			    guix-home-service-type))
		  base-services) 
	  (modify-services
	    base-services
	    (guix-home-service-type
	      homes =>
	      ;; Ensure any default homes are extended for compatibility with the
	      ;; bos dotfile setup
	      (map (lambda (home)
		     (list (list-ref home 0)
			   (extend-home (list-ref home 1))))
		   homes)))
	  base-services)))))

