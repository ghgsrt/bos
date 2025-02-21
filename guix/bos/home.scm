(define-module (bos home)
	#:use-module (bos utils)
	#:use-module (guix)
	#:use-module (gnu)
	#:use-module (gnu home)
	#:use-module (gnu home services)
	#:use-module (gnu home services shells)
	#:use-module (guix gexp)     ; For local-file
	#:use-module (ice-9 rdelim)  ; For reading environment variables
	#:use-module (ice-9 match)
	#:export (extend-home))

;; Handles augmenting any arbitrary home environment to be compatible
;; with the bos dotfile setup

(define bash-profile-service (simple-service 'bash-profile-service-type home-bash-service-type
					(home-bash-extension (bash-profile (list (plain-file "bos_pinit.sh" "source /etc/bos/profile")
															(plain-file "bos_dinit.sh" "if [ -d \"$HOME/.bos\" ]; then\n${BOS_DIR}/init.sh -M home\nfi"))))))

(define (extend-home base-home)
	(home-environment
		(inherit base-home)
		(services (cons* bash-profile-service
						(simple-service 'bos-home-environment-variables-service home-environment-variables-service-type
							`(("BOS_HOME_PROFILE" . "$HOME/.guix-home/profile")
					 		 ; ("BOS_HOME_NAME" . ,target)
							  ("BOS_HOME_TYPE" . "guix")))
						(home-environment-user-services base-home)))))
