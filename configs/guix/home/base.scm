(define-module (home base)
  #:use-module (home)
  #:use-module (services)
  #:use-module (channels)

  #:use-module (packages base)
  #:use-module (packages misc)
  #:use-module (packages vim)
  #:use-module (packages tmux)
  #:use-module (packages dev)
  #:use-module (packages spellcheck)
  #:use-module (packages fonts)

  #:use-module (home services manifest)
  #:use-module (home services shells)

  #:use-module (gnu packages gnupg)
  #:use-module (gnu home)

  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim)  ; For reading environment variables
  #:use-module (ice-9 textual-ports)) ; For get-string-all  

(define dotfiles-dir (getenv "DOTFILES_DIR"))

(define-public home/base
  (bos-home-environment 'base
    #:env-vars `(("GUIX_LOCPATH" . "$HOME/.guix-profile/lib/locale")
		 ("PATH" . "$HOME/.local/bin:$HOME/.config/emacs/bin:$PATH")
		 ("EDITOR" . "nvim")
		 ("VISUAL" . "nvim")
		 ("PAGER" . "nvim")
		 ("SHELL" . "zsh"))
    #:home (home-environment
      (packages (append packages:core
		        packages/fonts:essential
		        packages/vim
		        packages/tmux
		        packages/shell
		        packages/guile
		        packages/http,server
		        packages/pkg))
      (services (append home/services/zsh
		        home/services/manifest
		        (list 
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

