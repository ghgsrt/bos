(define-module (packages misc)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages dns)

  #:use-module (gnu packages python-web) ; httpie
  #:use-module (gnu packages web) ; nginx

  #:use-module (gnu packages linux) ; lm-sensors

  #:use-module (gnu packages messaging) ; bitlbee
  #:use-module (gnu packages rust-apps) ; spotifyd

  #:use-module (gnu packages package-management)
  #:use-module (gnu packages freedesktop) ; flatpak-xdg-utils

  #:export (packages/networking
	    packages/http,server
	    packages/sys-info
	    packages/apps
	    packages/pkg
	    packages/pkg:full))

(define packages/networking
  (list wireshark
	isc-bind
	ldns)) ; make sure this gives us drill

(define packages/http,server
  (list httpie
	;curlie
	nginx))

(define packages/sys-info
  (list lm-sensors))

(define packages/apps
  (list bitlbee ; might need to get a daemon set up somehow
	bitlbee-discord
	spotifyd))

(define packages/pkg
  (list flatpak
	flatpak-xdg-utils))
(define packages/pkg:full
  (cons* nix ; might need to get a daemon set up somehow
	 packages/pkg))

