(define-module (home)
	#:use-module (utils)
	#:use-module (guix)
	#:use-module (gnu)
	#:use-module (gnu home)
	#:use-module (gnu home services)
	#:use-module (gnu home services shells)
	#:use-module (guix gexp)     ; For local-file
	#:use-module (ice-9 rdelim)  ; For reading environment variables
	#:export (extend-home))

;; Handles augmenting any arbitrary home environment to be compatible
;; with the bos dotfile setup

(define home-config-dir (getenv "HOME_CONFIG_DIR"))
(define target (getenv "TARGET"))
;(unless target
;  (error "Environment variable 'TARGET' not set! Usage: TARGET=<name> guix home ..."))

(define base-home
	;;TODO make the target home dir (target config) a configurable option
  (load (string-append home-config-dir "/" target ".scm")))

(define bash-profile-service (simple-service 'bash-profile-service-type home-bash-service-type
					(home-bash-extension (bash-profile (list (local-file "/etc/bos/profile")
															 "if [ -d \"$HOME/.bos\" ]; then\n${BOS_DIR}/init.sh -M home\nfi")))))

(define (extend-home base-home)
	(home-environment
		(inherit base-home)
		(services (cons* bash-profile-service
						(simple-service 'bos-home-environment-variables-service home-environment-variables-service-type
							`(("BOS_HOME_PROFILE" . "$HOME/.guix-home/profile")
					 		  ("BOS_HOME_NAME" . ,target)
							  ("BOS_HOME_TYPE" . "guix")))
						(home-environment-services-safe base-home)))))

(define extended-home
	(extend-home base-home))

extended-home
