(define-module (home base)
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

(define %bos-light-packages
  (list httpie ; http cli for stuff
	feh ; image viewer
	parallel ; parallel commands and jobs (across computers?)

	lm-sensors ; hardware sensors stuff

	bluez ; bluetooth stuff

	nyxt ; keyboard browser

	bitlbee
	bitlbee-discord
	spotifyd
	))

(define %bos-full-packages
  (list flatpak ; containerized package manager or something
	nginx ; server stuff or something

	wireshark
	bind ; domain-name-to-ip conversion for dns stuff
	drill ; dns info stuff
	
	flameshot ; screenshot ?

	shotcut ; AVI editing
	inkscape ; svg editor
	vlc
	obs ; or find leaner screen recorder

	ungoogled-chromium
	icecat ; firefox derivative

	;; Spellcheck
	enchant
	ispell
        aspell
        aspell-dict-es
        aspell-dict-en
        aspell-dict-ca
	))

(define %bos-base-home-service-type
  (bos-home-service-type 'bos-base-home
			 #:packages (list git
					  nss-certs
					  ncurses
					  coreutils
					  openssl
					  net-tools
					  curl
					  wget2
					  ripgrep
					  fd
					  dstat
					  lz4

					  git:send-email
					  gcc-toolchain
					  make
					  watchexec
					  
					  shellcheck
					  shfmt
					  font-fira-code
					  font-ghgsrt
					 
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
