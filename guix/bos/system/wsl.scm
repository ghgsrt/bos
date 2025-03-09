(define-module (bos system wsl)
  #:use-module (bos channels)
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

(define (is-root-account user)
  (and=> (user-account-uid user) zero?))

(define (find-service svc lst)
  (find (lambda (s)
	  (equal? (service-kind s)
		  svc))
	lst))

(define-public (extend-wsl-system base-system boot-user)
  (operating-system
    (inherit base-system)
    (host-name (string-append "wsl-" (operating-system-host-name base-system)))
    (bootloader (operating-system-bootloader wsl-os))
    (hurd (operating-system-hurd wsl-os))
    (kernel (operating-system-kernel wsl-os))
    (kernel-arguments %default-kernel-arguments)
    (kernel-loadable-modules (operating-system-kernel-loadable-modules wsl-os))
    (initrd (operating-system-initrd wsl-os))
    (initrd-modules (operating-system-initrd-modules wsl-os))
    (firmware (operating-system-firmware wsl-os))
    (swap-devices (operating-system-swap-devices wsl-os))
    (mapped-devices (operating-system-mapped-devices wsl-os))
    (file-systems (operating-system-file-systems wsl-os))
    (users 
      (let* ((base-users (operating-system-users base-system))
	     (root (or (find is-root-account base-users) %root-account))
	     (non-root (remove is-root-account base-users))
	     (wsl-non-root (remove is-root-account (operating-system-users wsl-os)))
	     (users (if (not (null? non-root))
		      non-root
		      wsl-non-root))
	     (boot-user-name
	       (user-account-name
		 (or (find (lambda (user)
			     (equal? (user-account-name user)
				     boot-user))
			   users)
		     (car users)))))
      (append `(,(user-account
			(inherit root)
			(shell (wsl-boot-program boot-user-name))))
		   users
		   %base-user-accounts)))
    (services
      (let* ((base-services (operating-system-user-services base-system))
	     (guix-home-service (find-service guix-home-service-type
					      base-services))
	     ;; other services which shouldn't be fcky with wsl
	     )
	(append (if guix-home-service (list guix-home-service) '())
		(modify-services (operating-system-user-services wsl-os)
			(guix-service-type config =>
					(guix-configuration
					(inherit config)
					(channels %non-free-channels)))))))))

