(define-module (services desktop)
  #:use-module (utils)

  #:use-module (modules)
  #:use-module (modules desktop)

  #:use-module (gnu packages wm)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)

  #:use-module (guix gexp)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-1)

  #:export (services/desktop:sway
            services/sway:light
            services/sway))

(define %dotfiles-dir (getenv "DOTFILES_DIR"))

;; ~~ Sway ~~

(define (services/desktop:sway services)
  (let* ((greetd-dotfile (string-append %dotfiles-dir "/home/.config/sway/greetd.conf"))
	 (greetd-conf (if (file-exists? greetd-dotfile)
			greetd-dotfile
			"files/sway/greetd.conf")))
    (cons*
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
			     (local-file greetd-conf
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
      (modify-services (lset-union svc-eq?
                                   %desktop-services
                                   services)
		       (delete gdm-service-type)
		       (delete login-service-type)
		       (delete mingetty-service-type)))))

(define* (swaylock-service #:optional (use-effects? #f))
  (service
    screen-locker-service-type
    (screen-locker-configuration
      (name "swaylock")
      (program (file-append (if use-effects?
			      swaylock-effects
			      swaylock) "/bin/swaylock"))
      (using-pam? #t)
      (using-setuid? #f))))

(define services/sway:light
  (bos-module->services
    module/sway:light
    (list (swaylock-service))))

(define services/sway
  (bos-module->services
    module/sway
    (list (swaylock-service #t))))

(re-export:modules->services (modules desktop))

