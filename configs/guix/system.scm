(define-module (system)
  #:use-module (utils)
  #:use-module (gnu)
  #:use-module (gnu services guix)
  #:use-module (srfi srfi-1)
  #:export (bos-services
	    system/empty
	    bos-operating-system

	    profile-service-prefix
	    environment-service?

	    environment-service-prefix
	    profile-service?))

(define profile-service-prefix 'profile-)
(define environment-service-prefix 'session-environment-)

(define profile-service? (service-has-prefix profile-service-prefix))
(define environment-service? (service-has-prefix environment-service-prefix))

(define* (bos-services name #:key (modules #f) (packages #f) (env-vars #f) (services #f))
  (append (if packages
      `(,(simple-service (symbol-append profile-service-prefix name '-bos)
			 profile-service-type
			 (ensure-list packages)))
      '())
    (if env-vars
      `(,(simple-service (symbol-append environment-service-prefix name '-bos)
			 session-environment-service-type
			 env-vars))
      '())
    (lset-union svc-eq?
		(if services (ensure-list services) '())
		(if modules
		  (bos-module->services modules)
		  '()))))

(define system/empty
  (operating-system
    (host-name "empty")
    (bootloader (bootloader-configuration
		  (bootloader grub-efi-bootloader)
		  (targets (list "/boot/efi"))))
    (file-systems %base-file-systems)))

;(define operating-system-fields (@@ (gnu system) <operating-system>))
;(define operating-system-fields-to-ignore
;  (list "mapped-devices" "file-systems" "swap-devices" "users" "groups" "label" "essential-services"))
;
;(define accessor-overrides
;  '(("services" . "user-services")
;    ("kernel-arguments" . "user-kernel-arguments")))
;
;(define-syntax mo
;  (syntax-rules ()
;    ((mo func)
;     `(operating-system
;	,@(map (lambda (field)
;		 `(,field (,func ,(string-append "operating-system" field)))
;	       operating-system-fields))))))
;
;(define (merge-systems a b)
;  ;(define (pick-field field #:optional (leqp equal?))
;   ; (apply pick (append (map field (list a b default)) `(,leqp))))
;  (mo (lambda (field)
;	(apply pick (append (map field (list a b a))))
;
;)))

;; Merge two operating-system definitions into one
;; a => the current system state
;; b => the modification to be applied
;;
;; Any field in 'b' which does not correlate with a nullish value
;; will either replace or union (lists) with 'a' (in the union
;; case, using 'b's for same service-type)
;; Fields explicitly marked with #:replace? #t will use 'b's value no matter what
;;
;; This means if you want those particular fields to merge, you will have to:
;; Pass 'b' in as a procedure for access to 'a' and
;; for manually overriding the merge process
;;  - in this case the return should be a manually merged system
;;  - e.g., (lambda (base-os)
;;	      (operating-system
;;		(inherit base-os)
;;		(services %base-services)
;;		...))
;;  - passing as a procedure would be the only means for resetting a field to its default/nullish value as shown above
;;
;;
;; ignores the following fields:
;;    essential-services
(define (merge-systems b a) ; fold order
  (if (procedure? b)
    (b a)
    (let ((pick (pick-field a b system/empty)))
      (operating-system
	(inherit a)
	(file-systems (pick operating-system-file-systems #:replace? #t))
	(mapped-devices (pick operating-system-mapped-devices #:replace? #t))
	(swap-devices (pick operating-system-swap-devices #:replace? #t))
	(users (pick operating-system-users #:replace? #t))
	(groups (pick operating-system-groups))
	(kernel (pick operating-system-kernel))
	(hurd (pick operating-system-hurd))
	(kernel-loadable-modules (pick operating-system-kernel-loadable-modules))
	(kernel-arguments (pick operating-system-user-kernel-arguments))
	(bootloader (pick operating-system-bootloader))
	(label (pick operating-system-label))
	(keyboard-layout (pick operating-system-keyboard-layout))
	(initrd (pick operating-system-initrd))
	(firmware (pick operating-system-firmware))
	(host-name (pick operating-system-host-name))
	(hosts-file (pick operating-system-hosts-file))
	(skeletons (pick operating-system-skeletons))
	(issue (pick operating-system-issue))
	(packages (pick operating-system-packages pkg-eq?))
	(timezone (pick operating-system-timezone))
	(locale (pick operating-system-locale))
	(locale-definitions (pick operating-system-locale-definitions))
	(locale-libcs (pick operating-system-locale-libcs))
	(name-service-switch (pick operating-system-name-service-switch))
	(services (pick operating-system-user-services svc-eq?))
	(pam-services (pick operating-system-pam-services svc-eq?))
	(setuid-programs (pick operating-system-setuid-programs))
	(sudoers-file (pick operating-system-sudoers-file))))))

(define (default-home-service os default)
  (service guix-home-service-type 
	   (map (lambda (user)
		  `(,(user-account-name user) ,default))
		(operating-system-users os))))

(define* (bos-operating-system name #:key
			       (modules #f)
			       (inherits '())
			       (modified-by '())
			       (default-home #f)
			       (env-vars '())
			       (system system/empty))
  (let ((os (fold merge-systems
		  system/empty
		  (append (ensure-list inherits)
			  `(,system) 
			  (ensure-list modified-by)))))
    (operating-system
      (inherit os)
      (services
	(let ((user-services (operating-system-user-services os)))
	  ;; realistically, this shouldn't be necessary as modules semantically should consist solely of
	  ;;  simple services. But there may be conflict with extra services provided
	  (lset-union 
	    svc-eq? 
	    (bos-services name
	      #:modules modules
	      #:env-vars (cons `("BOS_SYSTEM_NAME" . ,(symbol->string name))
			       env-vars))
	    (if default-home
	      (cons (default-home-service this-operating-system default-home)
		    (remove (lambda (svc) 
			      (equal? (service-kind svc) guix-home-service-type))
			    user-services))
	      user-services)))))))

