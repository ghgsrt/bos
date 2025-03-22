(define-module (system extension nvidia)
  #:use-module (utils)
  #:use-module (system)
  #:use-module (gnu system)
  #:use-module (gnu services gnome)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu services nvidia)
  #:use-module (nongnu packages linux)
  #:export (extension/nvidia))

;; Should be the very last item in 'modified-by'

(define* (extension/nvidia #:key (no-display? #f) (wayland? #f) (gnome? #f))
  (lambda (base-os) (operating-system
      (inherit system/empty)
      (kernel-arguments (append '("modprobe.blacklist=nouveau")
  			        (if (or no-display? wayland?)
  				  '("nvidia_drm.modeset=1")
  				  '())))
      (packages (map replace-mesa (operating-system-packages base-os)))
      (services (append (cons service nvidia-service-type
			      (modify-services-silently (operating-system-user-services base-os)
				(prefix profile-service-prefix pkgs => (map replace-mesa pkgs))))
			      ;(modify-profile-packages (lambda (pkg-list) (map replace-mesa pkg-list))
			      ;			       (operating-system-user-services base-os)))
  		        (if (not (no-display?))
  			  (append (if (gnome?)
  				    (list (service gnome-desktop-service-type
  						   (gnome-desktop-configuration
  						     (gnome (replace-mesa gnome)))))
  				    '())
  				  (list (set-xorg-configuration
  					  (xorg-configuration
  					    (modules (cons nvda %default-xorg-modules))
  					    (drivers '("nvidia"))))))
  			  '()))))))
  
