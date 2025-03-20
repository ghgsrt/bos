(define-module (home no-x)
  #:use-module (home)
  #:use-module (home base)
  #:use-module (packages emacs)
  #:use-module (packages guix)
  #:use-module (packages misc)
  #:use-module (home services virtualization)
  #:use-module (gnu packages rust-apps) ; spotifyd
  #:use-module (gnu home))

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

