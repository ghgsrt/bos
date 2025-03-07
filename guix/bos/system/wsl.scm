(define-module (bos system wsl)
  #:use-module (bos utils)
  #:use-module (guix)
  #:use-module (gnu)
  #:use-module (gnu services)
  #:use-module (gnu services guix)
  #:use-module (gnu system)
  #:use-module (gnu system images wsl2)
  #:use-module (guix gexp)     ; For local-file
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim))  ; For reading environment variables

;; Handles augmenting any arbitrary operating system to be compatible
;; with a WSL environment

(define-public (extend-wsl-system base-system boot-user)
  (operating-system
    (inherit base-system)
    (bootloader (operating-system-bootloader wsl-os))
    (kernel (operating-system-kernel wsl-os))
    (initrd (operating-system-initrd wsl-os))
    (initrd-modules (operating-system-initrd-modules wsl-os))
    (firmware (operating-system-firmware wsl-os))
    (file-systems (operating-system-file-systems wsl-os))
    (users (append `(,(user-account
			(inherit %root-account)
			(shell (wsl-boot-program boot-user))))
		   (remove (lambda (user)
			     (not (and=> (user-account-uid user) zero?)))
			   (operating-system-users base-system))
		   %base-user-accounts))
    (services
      (let* ((find-service (lambda (svc lst)
			     (find (lambda (s)
				     (equal? (service-kind s)
					     svc))
				   lst)))
	     (base-services (operating-system-user-services base-system))
	     (guix-home-service (find-service guix-home-service-type
					      base-services))
	     ;; other services which shouldn't be fcky with wsl
	     )
	(append (if guix-home-service (list guix-home-service) '())
		(modify-services (operating-system-user-services wsl-os)
			(guix-service-type config =>
					(guix-configuration
					(inherit config)
					(environment '(("BOS_WSL" . "true")))))))))))
;	(append (if (not (find-service guix-service-type
;				       base-services))
;		  (list (service guix-service-type))
;		  '())
;		(if (find-service special-files-service-type
;				  base-services)
;		  (modify-services base-services
;				   (special-files-service-type vals => (append vals (service-value wsl-spec-files-svc))))
;		  (cons wsl-spec-files-svc base-services)))))))
;

;(define-public (extend-wsl-system base-system)
;  (operating-system
;    (inherit base-system)
;    (kernel hello)
;    (initrd (lambda* (. rest) (plain-file "dummyinitrd" "dummyinitrd")))
;    (initrd-modules '())
;    (firmware '())
;
;    (bootloader
;      (bootloader-configuration
;	(bootloader
;	  (bootloader
;	    (name 'dummybootloader)
;	    (package hello)
;	    (configuration-file "/dev/null")
;	    (configuration-file-generator (lambda* (. rest) (computed-file "dummybootloader" #~(mkdir #$output))))
;	    (installer #~(const #t))))))
;
;    (services (cons ; (service guix-service-type)
;		(service special-files-service-type
;			 `(("/usr/bin/env" ,(file-append coreutils "/bin/env"))))
;		(operating-system-user-services base-system)))))
;
