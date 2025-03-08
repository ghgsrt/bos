(define-module (system)
      #:use-module (gnu)
      #:use-module (srfi srfi-1))

;(define default)

(define* (pick a b nullish leqp)
  (define (nullish? arg)
    (equal? arg nullish))
  (cond
    ((nullish? a) b)
    ((nullish? b) a)
    ((and (list? a) (list? b))
     (lset-union leqp a b))
    (else arg2)))

(define (svc-eq a b)
  (apply string=?
	 (map (lambda (s)
		(symbol->string
		  (service-type-name
		    (service-kind s))))
	      (list a b))))


(define operating-system-fields (@@ (gnu system) <operating-system>))
(define operating-system-fields-to-ignore
  (list "mapped-devices" "file-systems" "swap-devices" "users" "groups" "label" "essential-services"))

(define accessor-overrides
  (list '("services" . "user-services")))

(define-syntax mo
  (syntax-rules ()
    ((mo func)
     `(operating-system
	,@(map (lambda (field)
		 `(,field (,func ,(string-append "operating-system" field)))
	       operating-system-fields))))))

(define (merge-systems a b)
  ;(define (pick-field field #:optional (leqp equal?))
   ; (apply pick (append (map field (list a b default)) `(,leqp))))
  (mo (lambda (field)
	(apply pick (append (map field (list a b a))))

)))

;; ignores the following fields:
;;    mapped-devices
;;    file-systems
;;    swap-devices
;;    users
;;    groups
;;    essential-services
;(define (merge-systems a b)
;  (define (pick-field field #:optional (leqp equal?))
;    (apply pick (append (map field (list a b default)) `(,leqp))))
;  (operating-system
;    (inherit b) ; give last in list precedence and ensures no uninitialized errors
;    (kernel (pick-field operating-system-kernel))
;    (hurd (pick-field operating-system-hurd))
;    (kernel-loadable-modules (pick-field operating-system-kernel-loadable-modules))
;    (kernel-arguments (pick-field operating-system-kernel-arguments))
;    (bootloader (pick-field operating-system-bootloader))
;    (label (pick-field operating-system-label))
;    (keyboard-layout (pick-field operating-system-keyboard-layout))
;    (initrd (pick-field operating-system-initrd))
;    (firmware (pick-field operating-system-firmware))
;    (host-name (pick-field operating-system-host-name))
;    (hosts-file (pick-field operating-system-hosts-file))
;    (skeletons (pick-field operating-system-skeletons))
;    (issue (pick-field operating-system-issue))
;    (packages (pick-field operating-system-packages))
;    (timezone (pick-field operating-system-timezone))
;    (locale (pick-field operating-system-locale))
;    (locale-definitions (pick-field operating-system-locale-definitions))
;    (locale-libcs (pick-field operating-system-locale-libcs))
;    (name-service-switch (pick-field operating-system-name-service-switch))
;    (services (pick-field operating-system-services svc-eq))
;    (pam-services (pick-field operating-system-pam-services svc-eq))
;    (setuid-programs (pick-field operating-system-setuid-programs))
;    (sudoers-file (pick-field operating-system-sudoers-file))))
;
;
;
;(define* (compose-system base . extensions #:key (exclude #f))
;	       (let ((last (car (reverse extensions)))
;		     (os (fold merge-systems base extensions))
;	       (operating-system
;
;		 ))))
