(define-module (home services desktop)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (%bos-desktop-packages
	     home-pipewire-services
	     home-qt-services
	     home-kvantum-services
	     home-wayland-services
	     home-sway@minimal-services
	     home-sway-services))

;; ~~ Base ~~ 

(define %bos-desktop-packages
  (list shared-mime-info
	libnotify ; library for sending notifications to notif daemon
	dunst ; notification daemon
        libxkbcommon
	mesa
	xdg-utils
	xdg-dbus-proxy
	xdg-desktop-portal
	xdg-desktop-portal-gtk
	fontconfig
	(list glib "bin")))

;; ~~ Pipewire ~~

(define home-pipewire-services
  (list (bos-home-service
	  'bos-home-pipewire
	  #:packages (list qpwgraph
			   ;pavucontrol
			   pamixer))
	(service home-pipewire-service-type)))

;; ~~ QT ~~

(define home-qt-services
  (list (bos-home-service
	  'bos-home-qt
	  #:packages (list qt5ct
			   qt6ct
			   qtsvg
			   qtwayland-5)
	  #:env-vars `(("QT_QPA_PLATFORMTHEME" . "qt5ct")
		       ("QT_PLATFORMTHEME" . "qt5ct")
		       ("QT_AUTO_SCREEN_SCALE_FACTOR" . "1")))))

;; ~~ Kvantum ~~

(define kvantum-services
  (list (bos-home-service
	  'bos-home-kvantum
	  #:packages (list kvantum))))

;; ~~ Wayland ~~

(define home-wayland-services
  (list (bos-home-service
	  'bos-home-wayland
	  #:packages (cons* 
		       ;egl-wayland
		       wl-clipboard
		       wl-color-picker
		       tofi
		       ;rofi-wayland
		       ;fuzzel
		       ;mako ; wayland-specific notif daemon
		       xdg-desktop-portal-wlr
		       xorg-server-xwayland
		       %bos-desktop-packages)
	  #:env-vars `(("XDG_SESSION_TYPE" . "wayland")
		       ("GDK_BACKEND" . "wayland")
		       ("GTK_IM_MODULE" . "wayland")
		       ("QT_IM_MODULE" . "wayland")
		       ("QT_QPA_PLATFORM" . "wayland-egl")
		       ("QT_QPT_PLATFORM" . "wayland")
		       ("QT_WAYLAND_DISABLE_WINDOWDECORATION" . "1")
		       ("SDL_VIDEODRIVER" . "wayland")
		       ("CLUTTER_BACKEND" . "wayland")
		       ("ELM_ENGINE" . "wayland-egl")
		       ("ECORE_EVAS_ENGINE" . "wayland-egl")
		       ("XMODIFIERS" . "@im=wayland")
		       ("XCURSOR_SIZE" . "24")))))

;; ~~ Sway ~~

(define home-sway@minimal-services
  (cons (bos-home-service-type
	  'bos-home-sway@minimal
	  #:packages (list swayfx
			   swaylock	
			   swaybg)
	  #:env-vars `(("XDG_CURRENT_DESKTOP" . "sway")))
	home-wayland-services))

(define home-sway-services
  (cons (bos-home-service
	  'bos-home-sway
	  #:packages (list swayfx
			   swayidle
			   swww
			   swaylock-effects
			   gdk-pixbuf ; swaylock-effects dependency
			   cairo ; swaylock-effects dependency
			   grim
			   slurp
			   waybar))
	home-wayland-services))

