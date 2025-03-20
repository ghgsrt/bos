(define-module (system extension nvidia)
  #:use-module (utils)
  #:use-module (system)
  #:use-module (gnu system)
  #:use-module (gnu services gnome)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu services nvidia)
  #:use-module (nongnu packages linux)
  #:export (system/nvidia:ext))

;(define (modify-profile-packages cb services)
;  ;; cb exposes a profile service value (package list), expecting the new service value as result
;  ;; collect all "profile-" prefixed service type names
;  ;; probably need to pull out the main profile sevice independently? (is there even one exposed here??)
;  ;; 
;  (map (lambda (svc)
;	 (if (not (profile-service? svc))
;	   svc
;	   (simple-service (service-type-name (service-kind svc)) profile-service-type
;			   (cb (service-value svc)))))
;       services))


(define* (system/nvidia:ext #:key (no-display? #f) (wayland? #f) (gnome? #f))
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
  
