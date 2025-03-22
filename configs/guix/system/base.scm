(define-module (system base)
  #:use-module (channels)
  #:use-module (system)
  #:use-module (users)

  #:use-module (home main)
  #:use-module (home services desktop)

  #:use-module (packages base)
  #:use-module (packages vim)
  #:use-module (packages tmux)
  
  #:use-module (gnu services)
  #:use-module (gnu services desktop) ; bluetooth
  #:use-module (gnu system)
  #:use-module (gnu system shadow) ; user-group
  #:use-module (gnu system keyboard)
  #:use-module (gnu system nss)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu packages firmware)
  
  #:use-module (guix gexp)
  #:use-module (srfi srfi-1))
  
(define-public system/base
  (bos-operating-system 'base
    #:default-home home/no-x:light
    #:system (operating-system
      (inherit system/empty)

      (host-name "guix")

      (locale "en_US.utf8")
      (timezone "America/New_York")
      (keyboard-layout (keyboard-layout "us"))

      (kernel linux)
      (initrd microcode-initrd)

      (firmware (list sof-firmware
		      linux-firmware))

      (groups (list (user-group (name "seat") (system? #t)) 
		    (user-group (name "bitlbee") (system? #t))))
      (users users/bos)

      (packages (append packages:essential
			packages/vim
			packages/tmux))
      (services (cons (service bluetooth-service-type
			       (bluetooth-configuration
				 (auto-enable? #t)))
		      (modify-services
			services/desktop:sway
			(guix-service-type config =>
					   (guix-configuration
					     (inherit config)
					     (channels %channels))))))

      (sudoers-file (plain-file "sudoers"
				(string-join '("root ALL=(ALL) NOPASSWD:ALL"
					       "%wheel ALL=(ALL) NOPASSWD:ALL")
					     "\n")))

      ;; Allow resolution of '.local' host names with mDNS
      (name-service-switch %mdns-host-lookup-nss))))

system/base

