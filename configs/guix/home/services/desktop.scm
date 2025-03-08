(define-module (home services desktop)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (%bos-desktop-packages
		%bos-desktop-services
  			qt-services
			kvantum-services
			wayland-services
			sway@minimal-services
;			sway-services
;			sway:fx-services
))

;; ~~ Base ~~ -- NOTE: 'desktop-services' MUST be used directly on the OS, NOT ON A HOME ENV

(define %bos-desktop-packages
		(list shared-mime-info
						 xdg-utils
						 xdg-dbus-proxy
						 xdg-desktop-portal
						 xdg-desktop-portal-gtk
						 fontconfig
						 (list glib "bin")))

(define %bos-desktop-services
	(list
		(service elogind-service-type)
        fontconfig-file-system-service
        polkit-wheel-service
        (service polkit-service-type)
        (service dbus-root-service-type)
  		(service upower-service-type)
		(service x11-socket-directory-service-type)))

;; ~~ QT ~~

(define qt-packages-service-type
	(bos-home-service-type 'bos-qt-packages
		#:packages (list qt5ct
						 qt5ct)
		#:env-vars `(("QT_QPA_PLATFORMTHEME" . "qt5ct")
					 ("QT_PLATFORMTHEME" . "qt5ct")
					 ("QT_AUTO_SCREEN_SCALE_FACTOR" . "1"))))

(define qt-services
	(list (service qt-packages-service-type)))

;; ~~ Kvantum ~~

(define kvantum-packages-service-type
	(bos-home-service-type 'bos-kvantum-packages
		#:packages (list kvantum)))

(define kvantum-services
	(list (service kvantum-packages-service-type)))

;; ~~ Wayland ~~

(define wayland-service-type
	(bos-home-service-type 'bos-wayland
		#:packages (cons* ;qtwayland-5
						;wayland
;						egl-wayland
						 wl-clipboard
						 wl-color-picker
						 rofi-wayland
						 libxkbcommon
						 mesa
						 xdg-desktop-portal-wlr
						 xorg-server-xwayland
						 %bos-desktop-packages)
    	#:env-vars `(
				 	 ("XDG_SESSION_TYPE" . "wayland")
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
					 ("XCURSOR_SIZE" . "24"))))

(define wayland-services
	(list (service wayland-service-type)))

;; ~~ Sway ~~

;; Sway@minimal
(define sway@minimal-service-type
	(bos-home-service-type 'bos-sway@minimal
		#:packages (list swaylock
				swayfx
						 swayidle
						 mako
						 swaybg)
		#:env-vars `(("XDG_CURRENT_DESKTOP" . "sway"))))

(define sway@minimal-services
	(append (list (service sway@minimal-service-type))
		 wayland-services))

;; Sway
(define sway-service-type
	(bos-home-service-type 'bos-sway
		#:packages (list fuzzel
						 grim
						 slurp
						 waybar)))

;(define sway-services
;	(cons (service sway-service-type)
;		  (sway@minimal-services)))

;(display sway-services)

;; Sway:fx
;(define sway:fx-services
;	(modify-services sway-services
;					 (list (home-sway-service-type config =>
;							(sway-configuration
;								(inherit config)
;								(packages (list swayfx)))))))
