(define-module (bos utils)
	#:use-module (guix)
	#:use-module (gnu)
	#:use-module (gnu home)
	#:use-module (gnu home services)
	#:use-module (gnu system)
	#:export (home-base-service-types
			  filter-home-base-services
			  home-environment-services-safe

			  %minimal-os
			  os-base-service-types
			  filter-os-base-services
			  operating-system-services-safe))

(define home-base-service-types
	;; Get the home services which are implicitly included in every home-environment.
	(map service-kind (home-environment-services (home-environment))))
(define (filter-home-base-services svcs)
	;; Dedup base home services to facilitate home-environment composition.
	(filter (lambda (svc)
			(not (member (service-kind svc) home-base-service-types)))
		svcs))
(define (home-environment-services-safe home)
	;; Returns the home-environment's services without the implicit base services for safe composition.
	(filter-home-base-services (home-environment-services home)))


(define %minimal-os
	(operating-system
		(host-name "guix")
		(bootloader (bootloader-configuration
						(bootloader grub-efi-bootloader)
						(targets (list "/boot/efi"))))

		(file-systems (cons (file-system
								(device (file-system-label "root"))
								(mount-point "/")
								(type "ext4"))
							%base-file-systems))))


(define os-base-service-types
	;; Get the os services which are implicitly included in every operating-system.
	(map service-kind (operating-system-services %minimal-os)))
(define (filter-os-base-services svcs)
	;; Dedup base os services to facilitate operating-system composition.
	(filter (lambda (svc)
			(and (not (member (service-kind svc) os-base-service-types)))
				 (not (string-prefix? "swap-" (service-kind svc))))
		svcs))
(define (operating-system-services-safe os)
	;; Returns the operating-system's services without the implicit base services for safe composition.
	(filter-os-base-services (operating-system-services os)))
