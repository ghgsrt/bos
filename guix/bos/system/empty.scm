(define-module (bos system empty)
  #:use-module (bos channels)
  #:use-module (bos system)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:export (empty-system
	    empty-system-free
	    empty-system-non-free))

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
	     (display "Nonguix modules not found. Please call 'guix pull' and reconfigure again.")
	     (newline)))
  (operating-system
    (host-name "guix")
    (timezone "America/New_York") ;; has a default yet forces you to initialize???

    (users (cons (user-account
		   (name "guix")
		   (group "users")
		   (home-directory "/home/guix")
		   (supplementary-groups '("wheel")))
		 %base-user-accounts))

    (services (modify-services %base-services
	        (guix-service-type config => (guix-configuration
	 				       (inherit config)
					       (channels (if non-free? 
							   %non-free-channels
							   %free-channels))))))

    (kernel (if non-free-loaded? linux linux-libre))
    (initrd (if non-free-loaded? microcode-initrd base-initrd))
    (firmware (append (list (when non-free-loaded? linux-firmware))
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

(define empty-system-free (extend-system (empty-system)))
(define empty-system-non-free (extend-system (empty-system #:non-free? #t)))

empty-system-free

