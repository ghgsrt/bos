(define-module (system zenbook)
  #:use-module (utils)

  #:use-module (system)
  #:use-module (system base)
  #:use-module (system extension laptop)
  #:use-module (system extension desktop)

  ;#:use-module (home main)

  #:use-module (gnu image)
  #:use-module (gnu system)
  #:use-module (gnu system image)
  #:use-module (gnu system shadow)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)

  #:use-module (nongnu packages linux)

  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim))

(define-public system/zenbook
  (bos-operating-system 'zenbook
    ;#:default-home home/has-x:full
    #:inherits (list
		  system/base
		  extension/laptop)
    #:modified-by (extension/desktop:sway 'full)
    #:system (operating-system
      (inherit system/empty)

      (host-name "zenbook")

      (firmware (list realtek-firmware))

      (bootloader (bootloader-configuration
		    (bootloader grub-efi-bootloader)
		    (targets '("boot/efi"))))

      (mapped-devices
	(list (mapped-device
		(source (uuid (partition-name->uuid "/dev/nvme0n1p2")))
		(target "root")
		(type luks-device-mapping))))
      (file-systems
	(append (list (file-system
			(mount-point "/boot/efi")
			(device (uuid (partition-name->uuid "/dev/nvme0n1p1")
				      'fat32))
			(type "vfat")))
		(map (lambda (item)
		       (let ((mount-point (car item))
			     (subvol-name (cadr item)))
			 (file-system
			   (device "/dev/mapper/root")
			   (mount-point mount-point)
			   (type "btrfs")
			   (flags '(no-atime))
			   (options (string-append
				      "subvol=" subvol-name
				      ",compress-force=zstd"
				      ",ssd"))
			   (dependencies mapped-devices))))
		     '(("/" "root")
		       ("/swap" "swap")
		       ("/boot" "boot")
		       ("/gnu/store" "gnu-store")
		       ("/home" "home")))
		(map (lambda (user)
		       (let ((name (user-account-name user)))
			 (file-system
			   (device "/dev/mapper/root")
			   (mount-point (string-append "/home/" name "/tmp"))
			   (type "tmpfs")
			   (dependencies mapped-devices))))
		     (remove (lambda (user)
			       (and=> (user-account-uid user) zero?))
			     (operating-system-users system/base)))
		%base-file-systems))
      (swap-devices
	(list (swap-space
		(target "/swap/swapfile")
		(dependencies (filter (file-system-mount-point-predicate "/swap")
				      file-systems))))))))

(if (getenv "IMAGE")
  (image
    (inherit efi-disk-image)
    (operating-system system/zenbook))
  ;  (partitions
  ;    (match (image-partitions efi-disk-image)
  ;      ((esp root)
  ;       (list esp (partition
  ;		   (inherit root)
  ;		   (label "root")))))))
  system/zenbook)

