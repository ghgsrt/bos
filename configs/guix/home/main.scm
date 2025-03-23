(define-module (home main)
  #:use-module (utils)

  #:use-module (home)
  #:use-module (home base)
  #:use-module (home services desktop)
  #:use-module (home services virtualization)

  #:use-module (packages avi)
  #:use-module (packages guix)
  #:use-module (packages misc)
  #:use-module (packages emacs)
  #:use-module (packages fonts)
  #:use-module (packages browsers)
  #:use-module (packages spellcheck)

  #:use-module (gnu home)
  #:use-module (gnu packages rust-apps) ; spotifyd
  #:use-module (gnu packages terminals)

  #:use-module (ice-9 rdelim))


;; ~~ No-X ~~ (terminal only)

(define-public home/no-x:light
  (bos-home-environment 'no-x-light
    #:inherits home/base
    #:home (home-environment
      (packages (append packages/emacs:no-x)))))

(define-public home/no-x:full
  (bos-home-environment 'no-x-full
    #:inherits home/no-x:light
    #:home (home-environment
      (packages (append packages/networking
		        packages/guix-hacking
		        packages/pkg:full
		        (list spotifyd)))
      (services (append home/services/podman)))))


;; ~~ Has-X ~~ (x provided by system)

(define-public home/has-x:light
  (bos-home-environment 'has-x:light
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
      (services (append ;home/services/pipewire
			home/services/podman)))))

(define-public home/has-x:full
  (bos-home-environment 'has-x:full
    #:inherits home/has-x:light
    #:home (home-environment
      (packages (append packages/networking
		        packages/guix-hacking
		        packages/pkg:full
		        packages/avi@editing:full
		        packages/avi@viewing:full
		        packages/browsers:full)))))


;; ~~ X ~~ (x provided by home)

(define-public home/x:light
  (bos-home-environment 'x:light
    #:inherits home/has-x:light
    #:home (home-environment
      (services (append home/services/sway:light)))))

(define-public home/x:full
  (bos-home-environment 'x:full
    #:inherits home/has-x:full
    #:home (home-environment
      (services (append home/services/sway)))))


;; == MAIN =======================================================

(define home (getenv "TARGET"))
(when home
  (symbol->value home))

