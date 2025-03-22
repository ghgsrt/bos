(define-module (system extension laptop)
  #:use-module (system)
  #:use-module (gnu system)
  #:use-module (gnu packages linux)
  #:use-module (gnu services pm))

(define-public extension/laptop
  (operating-system
    (inherit system/empty)
    (packages (list tlp

		    ;; keyboard rebinding
		    interception-tools
		    interception-dual-function-keys))
    (services (list (service
		      tlp-service-type
		      (tlp-configuration
			(wifi-pwr-on-bat? #f) ; turn off power save mode for wifi on bat
			(cpu-boost-on-ac? #t)))))))

