(define-module (system extension desktop)
  #:use-module (utils)
  #:use-module (system)
  #:use-module (services desktop)
  #:use-module (modules desktop) ; this shouldn't be necessary >:(
  #:use-module (gnu system)
  #:use-module (gnu services desktop)
  #:export (extension/desktop:sway))

;; Should be placed low in 'modified-by'

(define* (extension/desktop:sway #:optional (type 'light))
  (lambda (base-os) (operating-system
    (inherit system/empty)
    (services (append (services/desktop:sway
			(operating-system-user-services base-os))
		      (if (eq? type 'light)
			services/sway:light
			services/sway))))))
;		      (modify-services-silently (operating-system-user-services base-os)
;			(delete gdm-service-type)
;			(delete screen-locker-service-type)
;			(delete login-service-type)
;			(delete mingetty-service-type)))))))
;
