(define-module (system base)
  #:use-module (users)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (packages)
  #:use-module (packages vim)
  #:use-module (packages tmux)
  #:use-module (gnu packages wget)
  #:use-module (services)
  #:use-module (home primary)
  #:use-module (ice-9 rdelim)
  #:export (%bos-base-os
			%bos-base-packages
			%bos-base-desktop-services))

(define %dotfiles-dir (getenv "DOTFILES_DIR"))

(define %bos-channels (load (string-append %dotfiles-dir "/guix/channels.scm")))

(define %bos-base-packages
	(list git
		  tmux
		  tmux-tpm
		  tmux-sesh
		  neovim@0.10.4
		  openssl
		  openssh
		  gnupg
		  pinentry
		  net-tools
		  wget2
		  curl
		  ripgrep
		  fd))

(define %greetd-conf (string-append "/home/bosco/.guixos-sway/"
                                    "files/sway/sway-greetd.conf"))

(define %bos-base-desktop-services
  (cons*
;   (service openssh-service-type (openssh-configuration
;			    (permit-root-login #t)))
    ;; this is the only login/seat service that will actually get sway to work 🤷🏻‍♂️
    (service greetd-service-type
	     (greetd-configuration
	       (greeter-supplementary-groups '("video" "input" "users"))
	       (terminals
		 (list
		   (greetd-terminal-configuration
		     (terminal-vt "1")
		     (terminal-switch #t)
		     (default-session-command
		       ;; https://guix.gnu.org/manual/en/html_node/Base-Services.html
		       ;; issues.guix.gnu.org/65769
		       (greetd-wlgreet-sway-session
			 (sway-configuration
			   (local-file %greetd-conf
				       #:recursive? #t)))))
		   (greetd-terminal-configuration
		     (terminal-vt "2"))
		   (greetd-terminal-configuration
		     (terminal-vt "3"))
		   (greetd-terminal-configuration
		     (terminal-vt "4"))
		   (greetd-terminal-configuration
		     (terminal-vt "5"))
		   (greetd-terminal-configuration
		     (terminal-vt "6"))))))
    (service guix-home-service-type
	     `(("root" ,primary@minimal-home)
	       ("bosco" ,primary@minimal-home)))
    (modify-services %desktop-services
		     (guix-service-type config => (guix-configuration
						    (inherit config)
						    (channels %bos-channels)))
		     (delete gdm-service-type)
		     (delete login-service-type)
		     (delete mingetty-service-type))))

(define %bos-base-os
	(operating-system
		(locale "en_US.utf8")
		(timezone "America/New_York")
		(keyboard-layout (keyboard-layout "us"))
		(host-name "guix")

		(kernel (@ (nongnu packages linux) linux))
		(initrd (@ (nongnu system linux-initrd) microcode-initrd))

		(firmware (append
			    (list sof-firmware
				   (@ (nongnu packages linux) linux-firmware))
			   %base-firmware))
		
		(users (append bos-users %base-user-accounts))
		(packages (append %bos-base-packages %base-packages))
		(services %base-services)

		(groups (cons (user-group (system? #t) (name "seat")) %base-groups))

		(sudoers-file (plain-file "sudoers"
					  (string-join '("root ALL=(ALL) NOPASSWD:ALL"
							 "%wheel ALL=(ALL) NOPASSWD:ALL")
							"\n")))

		;; Allow resolution of '.local' host names with mDNS
		(name-service-switch %mdns-host-lookup-nss)

		(bootloader (bootloader-configuration
						(bootloader grub-efi-bootloader)
						(targets (list "/boot/efi"))))

		(file-systems (cons (file-system
				      (device (file-system-label "root"))
				      (mount-point "/")
				      (type "ext4"))
			      %base-file-systems))))

(newline)
(display "Loading BASE-OS from module system")
(newline)

%bos-base-os

