(define-module (home base)
  #:use-module (channels)

  #:use-module (home)
  #:use-module (home services shells)
  #:use-module (home services manifest)

  #:use-module (packages dev)
  #:use-module (packages base)
  #:use-module (packages misc)
  #:use-module (packages fonts)
  #:use-module (packages spellcheck)

  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services ssh)
  #:use-module (gnu packages gnupg)

  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim)  ; For reading environment variables
  #:use-module (ice-9 textual-ports)) ; For get-string-all  

(define dotfiles-dir (getenv "DOTFILES_DIR"))

(define-public home/base
  (bos-home-environment 'base
    #:env-vars `(("GUIX_LOCPATH" . "$HOME/.guix-profile/lib/locale")
		 ("PATH" . "$HOME/.local/bin:$HOME/.config/emacs/bin:$PATH")
		 ("BOS_HOME_PROFILE" . "$HOME/.guix-home/profile")
		 ("EDITOR" . "nvim")
		 ("VISUAL" . "nvim")
		 ("PAGER" . "nvim")
		 ("SHELL" . "zsh"))
    #:home (home-environment
      (packages (append packages:core
		        packages/fonts:essential
		        packages/shell
		        packages/guile
			packages/golang
		        packages/http,server
		        packages/pkg))
      (services (append home/services/zsh
		        home/services/manifest
		        (list 
			  (service home-openssh-service-type)
			  (simple-service
			    'bos-channels-service
			    home-channels-service-type
			    %channels)
			  (service
			    home-gpg-agent-service-type 
			    (home-gpg-agent-configuration
			      (ssh-support? #t)
			      (pinentry-program 
				(file-append pinentry "/bin/pinentry-curses"))
			      (extra-content (call-with-input-file
					       (string-append dotfiles-dir "/home/.gnupg/_gpg-agent.conf") 
					       get-string-all))))))))))

home/base

