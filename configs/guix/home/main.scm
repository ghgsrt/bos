(define-module (home main)
  #:use-module (home)
  #:use-module (home base)
  #:use-module (packages emacs)
  #:use-module (packages avi)
  #:use-module (packages misc)
  #:use-module (packages browsers)
  #:use-module (packages fonts)
  #:use-module (packages guix)
  #:use-module (packages spellcheck)
  #:use-module (home services virtualization)
  #:use-module (home services desktop)
  #:use-module (gnu packages)
  #:use-module (gnu packages terminals))

(define-public home/main:light
  (bos-home-environment 'light
    #:inherits home/base
    #:home (home-environment
      (packages (append packages/emacs
		        packages/avi@editing
		        packages/avi@viewing
		        packages/sys-info
		        packages/apps
		        packages/browsers
		        packages/fonts
		        packages/spellcheck:full ; temporary while figuring it out
		        (list foot)))
      (services (append home/services/sway:light
		        home/services/pipewire
			home/services/podman)))))

(define-public home/main:full
  (bos-home-environment 'full
    #:inherits home/main:light
    #:home (home-environment
      (packages (append packages/networking
		        packages/guix-hacking
		        packages/pkg:full
		        packages/avi@editing:full
		        packages/avi@viewing:full
		        packages/browsers:full))
      (services (append home/services/sway)))
    #:rm-packages (list swaybg
			swaylock)))

