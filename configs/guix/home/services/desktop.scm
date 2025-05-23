(define-module (home services desktop)
  #:use-module (home)
  #:use-module (modules)

  #:use-module (gnu packages audio)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages linux) ; wireplumber

  #:use-module (gnu services)
  #:use-module (gnu home services sound)

  #:export (home/services/pipewire))

(re-export:modules->home-services (modules desktop))

;; ~~ Sound ~~

(define home/services/sound:base
  (bos-home-services 'sound
     #:packages (list alsa-utils)))

;; ~~ Pipewire ~~

(define home/services/pipewire
  (bos-home-services 'pipewire
    #:packages (list qpwgraph
 		     ;pavucontrol
		     pamixer
		     wireplumber)
    #:services (cons (service home-pipewire-service-type)
		     home/services/sound:base)))

