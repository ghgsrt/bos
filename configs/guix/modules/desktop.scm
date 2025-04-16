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

  #:export (packages/desktop

            module/qt
            module/qt:wayland
            module/wayland
            module/sway:light
            module/sway))

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
                 egl-wayland
                 wl-clipboard
                 wl-color-picker
                 wlsunset
                 tofi
                 ;rofi-wayland
                 ;fuzzel
                 ;mako ; wayland-specific notif daemon
                 xdg-desktop-portal-wlr
                 xorg-server-xwayland
                 packages/desktop)
    #:env-vars `(("XDG_SESSION_TYPE" . "wayland")
                 ("GDK_BACKEND" . "wayland")
                 ("MOZ_ENABLE_WAYLAND" . "0")
                 ("MOZ_DBUS_REMOTE" . "1")
                 ("GTK_IM_MODULE" . "wayland")
                 ("SDL_VIDEODRIVER" . "wayland")
                 ("CLUTTER_BACKEND" . "wayland")
                 ("ELM_ENGINE" . "wayland-egl")
                 ("ECORE_EVAS_ENGINE" . "wayland-egl")
                 ("XMODIFIERS" . "@im=wayland")
                 ("XCURSOR_SIZE" . "24"))))

;; ~~ Sway ~~

(define module/sway:light
  (bos-module 'sway:light
    #:includes module/wayland
    #:packages (list
                 sway
                 swayidle
                 swaylock
                 swaybg)
    #:env-vars `(("XDG_CURRENT_DESKTOP" . "sway"))))

(define module/sway
  (bos-module 'sway
    #:includes module/sway:light
    #:packages (list
                 swayfx
                 ;swww
                 swaylock-effects
                 gdk-pixbuf ; swaylock-effects dependency
                 ;cairo ; swaylock-effects dependency
                 ;grim ; grimshot wraps these so don't need, right?
                 ;slurp
                 flameshot
                 grimshot)
    #:excludes (list
                 sway
                 ;swaybg
                 swaylock)))


