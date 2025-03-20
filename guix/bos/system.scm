(define-module (bos system)
  #:use-module (bos utils)
  #:use-module (bos channels)
  #:use-module (bos home)
  #:use-module (guix)
  #:use-module (guix gexp)     ; For local-file
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu services guix)
  #:use-module (gnu services base)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages tmux)
  #:use-module (gnu packages version-control)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim) ; For reading environment variables
  #:export (extend-system
	    empty-system
	    empty-system-free
	    empty-system-non-free))

(define %sudoers-file
  (plain-file "sudoers"
	      (string-join '("root ALL=(ALL) NOPASSWD:ALL"
			     "%wheel ALL=(ALL) NOPASSWD:ALL")
			   "\n")))

(define (extend-system base-system)
  (let ((base-services (operating-system-user-services base-system)))
    (operating-system
      (inherit base-system)

      (sudoers-file (if (equal? 
			  (operating-system-sudoers-file base-system)
			  %sudoers-specification)
		      %sudoers-file
		      (operating-system-sudoers-file base-system)))

      (packages (cons* openssh
		       gnupg
		       pinentry
		       (operating-system-packages base-system)))
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

(define* (empty-system #:key (non-free? #f))
  (let* ((non-free-loaded? #f))
    (catch #t
	   (lambda _
	     (if non-free?
	       (begin
		 (use-modules (nongnu system linux-initrd)
			      (nongnu packages linux)
			      (nongnu packages firmware))
		 (set! non-free-loaded? #t))
	       (use-modules (gnu system linux-initrd)
			    (gnu packages linux))))
	   (lambda _
	     (display "Nonguix modules not found, but the nonguix channel will be added after reconfiguring completes. Please call 'guix pull' and reconfigure again.")
	     (newline)))
  (operating-system
    (host-name "guix")
    (timezone "America/New_York") ;; has a default yet forces you to initialize???

    (users (cons (user-account
		   (name "gnu")
		   (group "users")
		   (home-directory "/home/gnu")
		   (supplementary-groups '("wheel")))
		 %base-user-accounts))

    (sudoers-file %sudoers-file)
    (services (modify-services
		%base-services
		(guix-service-type config => 
				   (guix-configuration
				     (inherit config)
				     (channels (if non-free? 
						 %non-free-channels
						 %free-channels))))))

    (kernel (if non-free-loaded? linux linux-libre))
    (initrd (if non-free-loaded? microcode-initrd base-initrd))
    (firmware (append (if non-free-loaded? (list linux-firmware) '())
		      %base-firmware))

    (bootloader (bootloader-configuration
		  (bootloader grub-efi-bootloader)
		  (targets (list "/boot/efi"))))

    (file-systems (cons (file-system
			  (device (file-system-label "root"))
			  (mount-point "/")
			  (type "ext4")
			  (mount? #t))
			%base-file-systems)))))

(define (empty-system-free) (extend-system (empty-system)))
(define (empty-system-non-free) (extend-system (empty-system #:non-free? #t)))

