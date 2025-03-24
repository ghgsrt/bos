(define-module (system base)
  #:use-module (channels)
  #:use-module (system)
  #:use-module (users)

  #:use-module (home main)

  #:use-module (packages base)
  
  #:use-module (gnu packages audio) ; bluez-alsa
  #:use-module (gnu services)
  #:use-module (gnu services base)
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
    #:env-vars '(("SYSTEM_BIN" . "/run/current-system/profile/bin"))
    #:system (operating-system
      (inherit system/empty)

      (host-name "guix")

      (locale "en_US.utf8")
      (timezone "America/New_York")
      (keyboard-layout (keyboard-layout "us"))

      (kernel linux-lts) ; linux-6.13 seems to have introduced a breaking change for broadcom-sta firmware. let's just stick with lts under the assumption any breaking changes will be remedied prior to them bumping the version (and also to reduce how often we have to wait five hours on the thinkpad to rebuild the kernel)
      (initrd microcode-initrd)

      (firmware (list sof-firmware
		      linux-firmware))

      (groups (list (user-group (name "seat") (system? #t)) 
		    (user-group (name "bitlbee") (system? #t))))
      (users users/bos)

      (packages (cons* bluez-alsa
		       packages:essential))
      (services (cons (service bluetooth-service-type
			       (bluetooth-configuration
				 (auto-enable? #t)))
		      (modify-services
			%base-services
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

