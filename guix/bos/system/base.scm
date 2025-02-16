(use-modules (system)
			 (gnu)
			 (gnu system)
			 (guix gexp)
			 (ice-9 rdelim))

(define system-dir (getenv "SYSTEM_DIR"))
(define target (getenv "TARGET"))
;(unless target
;  (error "Environment variable 'TARGET' not set! Usage: TARGET=<name> guix home ..."))

(define base-system
  (if (and target system-dir)
	(load (string-append system-dir "/" target ".scm"))
	#f))

(define extended-system
	(if base-system
		(extend-system base-system)))

extended-system