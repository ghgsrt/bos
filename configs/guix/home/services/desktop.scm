(define-module (home services desktop)
  #:use-module (home)
  #:use-module (modules)

  #:use-module (gnu packages audio)
  #:use-module (gnu packages pulseaudio)

  #:use-module (gnu services)
  #:use-module (gnu home services sound)

  #:export (home/services/pipewire))

(re-export:modules->home-services (modules desktop))

;; ~~ Pipewire ~~

(define home/services/pipewire
  (bos-home-services 'pipewire
    #:packages (list qpwgraph
 		     ;pavucontrol
		     pamixer)
    #:services (service home-pipewire-service-type)))

