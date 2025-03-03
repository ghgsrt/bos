(define-module (bos home)
  #:use-module (bos packages base)
  #:use-module (bos utils)
  #:use-module (guix)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (guix gexp)     ; For local-file
  #:use-module (ice-9 rdelim)  ; For reading environment variables
  #:use-module (ice-9 match))

;; Handles augmenting any arbitrary home environment to be compatible
;; with the bos dotfile setup

(define bash-profile-service
  (simple-service 'bash-profile-service-type
		  home-bash-service-type
		  (home-bash-extension 
		    (bash-profile (list (plain-file "bos_pinit.sh"
						    "\nif [ -f /etc/bos/profile ]; then source /etc/bos/profile; fi\n")
					(plain-file "bos_dinit.sh"
						    "\nif [ ! -d \"$HOME/.bos\" ]; then\n\t${BOS_DIR}/init.sh -M home\nfi\n")))
		    (bashrc (list (plain-file "bos_rinit.sh"
					      "\nif [ -f /etc/bos/bashrc ]; then source /etc/bos/bashrc; fi\n"))))))

(define-public (extend-home base-home)
  (home-environment
    (inherit base-home)
    (packages (cons glibc-locales-us (home-environment-packages base-home)))
    (services (cons* bash-profile-service
		     (simple-service 'bos-home-environment-variables-service
				     home-environment-variables-service-type
				     `(("BOS_HOME_PROFILE" . "$HOME/.guix-home/profile")
				       ; ("BOS_HOME_NAME" . ,target)
				       ("BOS_HOME_TYPE" . "guix")))
		     (home-environment-user-services base-home)))))
