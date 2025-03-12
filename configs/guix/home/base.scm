(define-module (home base)
;	       #:use-module (dotfiles guix channels)
	       #:use-module (home)
	       #:use-module (services)
	       #:use-module (packages)
	       #:use-module (packages vim)
	       #:use-module (packages tmux)
	       #:use-module (packages fonts)
	       #:use-module (gnu packages crates-vcs)
	       #:use-module (gnu packages crates-io)
	       #:use-module (gnu packages rust-apps)
	       #:use-module (gnu packages emacs)


	       ;; guix hacking related modules
	       #:use-module (gnu packages autotools)
	       #:use-module (gnu packages graphviz)
	       #:use-module (gnu packages man)
	       #:use-module (gnu packages gettext)

	       #:use-module (home services manifest)
	       #:use-module (home services dev)
	       #:use-module (home services ssh)
	       #:use-module (home services shells)
	       #:use-module (home services archive)
	       #:use-module (ice-9 rdelim)  ; For reading environment variables
	       #:use-module (ice-9 textual-ports) ; For get-string-all  
	       #:export (%bos-base-home
			  %bos-base-home-services
			  %bos-base-home-service-type))

(define dotfiles-dir (getenv "DOTFILES_DIR"))

(define channels (load (string-append dotfiles-dir "/guix/channels.scm")))

(define %bos-base-home-service-type
  (bos-home-service-type 'bos-base-home
			 #:packages (list git
					  rust-bat-0.24
					  zoxide
					  nss-certs
					  gcc-toolchain
					  podman
					  neovim@0.10.4
					  tmux
					  tmux-tpm
					  ;tmux-sessionizer
					  tmux-sesh
					  hyperfine
					  shellcheck
					  shfmt
					  fzf
					  openssl
					  net-tools
					  font-fira-code
					  font-ghgsrt
					  curl
					  ripgrep
					  fd
					  tree
					  dstat
					  ncurses
					  dconf-editor
					  coreutils

					  ;; EMACS
					  emacs-lucid ; blazingly fast
					  emacs-geiser
					  emacs-geiser-guile

					  ;; GUIX hacking
					  autoconf
					  automake
					  gettext-minimal
					  texinfo
					  graphviz
					  help2man
					  )
			 #:env-vars `(("GUIX_LOCPATH" . "$HOME/.guix-profile/lib/locale")
				      ("PATH" . "$HOME/.local/bin:$HOME/.config/emacs/bin:$PATH")
				      ("EDITOR" . "nvim")
				      ("VISUAL" . "nvim")
				      ("PAGER" . "nvim")
				      ("SHELL" . "zsh")
				      ("BOS_HOME_NAME" . "base"))))

(define %bos-base-home-services
  (append manifest-services
	  guile-services
	  ssh-services
	  zsh-services
	  archive@minimal-services
	  (list 
	    (service home-gpg-agent-service-type 
		     (home-gpg-agent-configuration
		       (ssh-support? #t)
		       (pinentry-program 
			 (file-append pinentry "/bin/pinentry-curses"))
		       (extra-content (call-with-input-file
					(string-append dotfiles-dir "/home/.gnupg/_gpg-agent.conf") 
					get-string-all))))
	    (service %bos-base-home-service-type)
	    (simple-service 'bos-channels-service home-channels-service-type
			    channels)
	    )))


(define %bos-base-home
  (home-environment
    (services %bos-base-home-services)))

%bos-base-home
