(define-module (system thinkpad)
  #:use-module (system)
  #:use-module (system base)
  #:use-module (system extension laptop)
  #:use-module (system extension broadcom)
  #:use-module (system extension desktop)

  #:use-module (home main)

  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub))

(define-public system/thinkpad
  (bos-operating-system 'thinkpad
    #:default-home home/has-x:light
    #:inherits (list
		  system/base
		  extension/laptop
		  extension/broadcom)
    #:modified-by (extension/desktop:sway)
    #:system (operating-system
      (inherit system/empty)

      (host-name "thinkpad")

      (bootloader (bootloader-configuration
		    (bootloader grub-efi-bootloader)
		    (targets '("/boot/efi"))
		    (keyboard-layout keyboard-layout)))

      (file-systems (cons* (file-system
			     (mount-point "/boot/efi")
			     (device (uuid "474C-5E8A"
					   'fat32))
			     (type "vfat"))
			   (file-system
			     (mount-point "/")
			     (device (uuid
				       "f68a484e-ed0b-41b8-8d98-41ad6a88560d"
				       'ext4))
			     (type "ext4"))
			   %base-file-systems))
      (swap-devices (list (swap-space
			    (target (uuid
				      "07b04b86-97e2-40d2-a905-c25d25782e1e"))))))))

system/thinkpad

