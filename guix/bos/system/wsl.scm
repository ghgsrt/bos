(define-module (bos system wsl)
  #:use-module (bos utils)
  #:use-module (bos system)
  #:use-module (guix)
  #:use-module (gnu)
  #:use-module (gnu services guix)
  #:use-module (gnu system)
  #:use-module (guix gexp)     ; For local-file
  #:use-module (ice-9 rdelim))  ; For reading environment variables

;; Handles augmenting any arbitrary operating system to be compatible
;; with a WSL environment, as well as the bos dotfile setup

(define-public (extend-wsl-system base-system)
  (operating-system
    (inherit base-system)
    (kernel hello)
    (initrd (lambda* (. rest) (plain-file "dummyinitrd" "dummyinitrd")))
    (initrd-modules '())
    (firmware '())

    (bootloader
      (bootloader-configuration
	(bootloader
	  (bootloader
	    (name 'dummybootloader)
	    (package hello)
	    (configuration-file "/dev/null")
	    (configuration-file-generator (lambda* (. rest) (computed-file "dummybootloader" #~(mkdir #$output))))
	    (installer #~(const #t))))))

    (services (cons ; (service guix-service-type)
		(service special-files-service-type
			 `(("/usr/bin/env" ,(file-append coreutils "/bin/env"))))
		(operating-system-user-services base-system)))))

