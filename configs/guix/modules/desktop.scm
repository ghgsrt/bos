(define-module (modules desktop)
  #:use-module (utils)
  #:use-module (modules)

  #:use-module (gnu packages gnome) ; libnotify
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)

  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)

  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 rdelim)

  #:export (packages/desktop
            
            services/desktop:sway

            module/qt
            module/qt:wayland
            module/wayland
            module/sway:light
            module/sway))

(define %dotfiles-dir (getenv "DOTFILES_DIR"))

(define packages/desktop
  (list
    shared-mime-info
    libnotify ; library for sending notifications to notif daemon
    dunst ; notification daemon
    libxkbcommon
    ;mesa ; pretty sure unecessary as anything that would rely on it should receive it as a build input. maybe worth bringing back if we start installing certain programs outside of guix that can use it?
    mesa-utils
    ; pango ; same as mesa
    xdg-utils
    xdg-dbus-proxy
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    fontconfig
    (list glib "bin")))

;; ~~ QT ~~

(define module/qt
  (bos-module 'qt
    #:packages (list
                 qt5ct
                 qt6ct
                 qtsvg)
    #:env-vars `(("QT_QPA_PLATFORMTHEME" . "qt5ct")
                 ("QT_PLATFORMTHEME" . "qt5ct")
                 ("QT_AUTO_SCREEN_SCALE_FACTOR" . "1"))))

(define module/qt:wayland
  (bos-module 'qt:wayland
    #:includes module/qt
    #:packages qtwayland-5
    #:env-vars `(("QT_IM_MODULE" . "wayland")
                 ("QT_QPA_PLATFORM" . "wayland-egl")
                 ("QT_QPT_PLATFORM" . "wayland")
                 ("QT_WAYLAND_DISABLE_WINDOWDECORATION" . "1"))))

;; ~~ Wayland ~~

(define module/wayland
  (bos-module 'wayland
    #:packages (cons* 
                 wl-clipboard
                 wl-color-picker
                 tofi
                 ;rofi-wayland
                 ;fuzzel
                 ;mako ; wayland-specific notif daemon
                 xdg-desktop-portal-wlr
                 xorg-server-xwayland
                 packages/desktop)
    #:env-vars `(("XDG_SESSION_TYPE" . "wayland")
                 ("GDK_BACKEND" . "wayland")
                 ("GTK_IM_MODULE" . "wayland")
                 ("SDL_VIDEODRIVER" . "wayland")
                 ("CLUTTER_BACKEND" . "wayland")
                 ("ELM_ENGINE" . "wayland-egl")
                 ("ECORE_EVAS_ENGINE" . "wayland-egl")
                 ("XMODIFIERS" . "@im=wayland")
                 ("XCURSOR_SIZE" . "24"))))

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
		       (delete screen-locker-service-type)
		       (delete login-service-type)
		       (delete mingetty-service-type)))))
;
;(define-syntax services/desktop:sway
;  (identifier-syntax (_services/desktop:sway)))
;

(define module/sway:light
  (bos-module 'sway:light
    #:includes module/wayland
    #:packages (list
                 swayfx
                 swaylock	
                 swaybg)
    #:env-vars `(("XDG_CURRENT_DESKTOP" . "sway"))))

(define module/sway
  (bos-module 'sway
    #:includes module/sway:light
    #:packages (list
                 swayidle
                 swww
                 swaylock-effects
                 gdk-pixbuf ; swaylock-effects dependency
                 cairo ; swaylock-effects dependency
                 grim
                 slurp
                 waybar)
    #:excludes (list
                 swaylock
                 swaybg)))


