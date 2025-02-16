(define-module (system)
	#:use-module (utils)
	#:use-module (home)
	#:use-module (guix)
	#:use-module (gnu)
	#:use-module (gnu system)
	#:use-module (guix gexp)     ; For local-file
	#:use-module (ice-9 rdelim)  ; For reading environment variables
	#:export (extend-system))

;; Handles augmenting any arbitrary home environment to be compatible
;; with the bos dotfile setup

(define system-dir (getenv "SYSTEM_DIR"))
(define target (getenv "TARGET"))

(display "SYSTEM_DIR: ")
(display system-dir)
(newline)
(display "TARGET: ")
(display target)
(newline)

;(unless target
;  (error "Environment variable 'TARGET' not set! Usage: TARGET=<name> guix home ..."))

(define base-system
  (load (string-append system-dir "/" target ".scm")))

(define (extend-system base-system)
	(operating-system
		(inherit base-system)
		(services (modify-services (operating-system-services-safe base-home)
						(guix-home-service-type homes =>
						;; Ensure any default homes are extended for compatibility with the
						;; bos dotfile setup
							(map (lambda (home)
									(list (list-ref home 0)
										  (extended-home (list-ref home 1))))
								  homes))))))

(define extended-system
	(extend-system base-system))

extended-system
