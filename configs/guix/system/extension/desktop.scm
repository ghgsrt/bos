(define-module (system extension desktop)
  #:use-module (utils)
  #:use-module (system)

  #:use-module (services desktop)

  #:use-module (gnu system)
  #:use-module (gnu services desktop)

  #:use-module (srfi srfi-1)

  #:export (extension/desktop:sway))

;; Should be placed low in 'modified-by'

(define* (extension/desktop:sway #:optional (type 'light))
  (lambda (base-os) (operating-system
    (inherit base-os)
    (services (lset-union
		svc-eq?
		(if (eq? type 'light)
		  services/sway:light
		  services/sway)
		(services/desktop:sway
		  (operating-system-user-services base-os)))))))

