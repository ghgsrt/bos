(define-module (system thinkpad)
  #:use-module (system base)
  #:use-module (services)
  #:use-module (packages)
  #:use-module (home primary)
  #:use-module (dotfiles guix channels)
  #:use-module (home services desktop)
  #:use-module (gnu packages linux) ;; interception, tlp 
  #:use-module (gnu services pm) ;; tlp 
  #:export (thinkpad-os
	    thinkpad-packages
	    thinkpad-services))

(define thinkpad-packages 
  (list 
    tlp

    ;; keyboard rebinding
    interception-tools
    interception-dual-function-keys))

(define thinkpad-services
  (list 
    (service tlp-service-type
	     (tlp-configuration
	       (cpu-boost-on-ac? #t)
	       (wifi-pwr-on-bat? #f))) ; turn off power save mode for wifi on bat
    (service bluetooth-service-type
	     (bluetooth-configuration
	       (auto-enable? #t)))))

(define thinkpad-os
  (operating-system
    (inherit %bos-base-os)

    (host-name "thinkpad")

    (kernel-arguments (append '("modprobe.blacklist=b43,b43legacy,ssb,bcm43xx,brcm80211,brcmfmac,brcmsmac,bcma")
			      (operating-system-kernel-arguments %bos-base-os "/dev/disk/by-label/root")))
    (kernel-loadable-modules (list (@ (nongnu packages linux) broadcom-sta)))

    (firmware (cons broadcom-bt-firmware
		    (operating-system-firmware %bos-base-os)))

    (packages (append thinkpad-packages
		      (operating-system-packages %bos-base-os)))
    (services (append thinkpad-services
		      %bos-base-desktop-services))

    (swap-devices (list (swap-space
			  (target (uuid
				    "07b04b86-97e2-40d2-a905-c25d25782e1e")))))
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
			 %base-file-systems))))

(display "Loading THINKPAD-OS from module systems/thinkpad")

thinkpad-os
