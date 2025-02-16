; (define-module (home base)
; 	#:use-module (utils)
; 	#:use-module (guix)
; 	#:use-module (gnu)
; 	#:use-module (gnu home)
; 	#:use-module (gnu home services)
; 	#:use-module (gnu home services shells)
; 	#:use-module (guix gexp)     ; For local-file
; 	#:use-module (ice-9 rdelim))  ; For reading environment variables

(use-modules (bos home)
			 (gnu)
			 (gnu home)
			 (gnu home services)
			 (guix gexp)
			 (ice-9 rdelim))

(define home-config-dir (getenv "HOME_CONFIG_DIR"))
(define target (getenv "TARGET"))
;(unless target
;  (error "Environment variable 'TARGET' not set! Usage: TARGET=<name> guix home ..."))

(define base-home
	;;TODO make the target home dir (target config) a configurable option
  (if (and target home-config-dir)
  		(load (string-append home-config-dir "/" target ".scm"))
	#f))


(define extended-home
	(if base-home
		(extend-home base-home)))

extended-home
