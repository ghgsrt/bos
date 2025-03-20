(define-module (packages avi)
  #:use-module (gnu packages video)
  #:use-module (gnu packages inkscape)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages music)
  #:export (packages/avi@editing
	    packages/avi@editing:full
	    packages/avi@viewing
	    packages/avi@viewing:full))

(define packages/avi@editing
  (list shotcut))

(define packages/avi@editing:full
  (cons* inkscape
	 obs
	 packages/avi@editing))

(define packages/avi@viewing
  (list feh
	mpv))

(define packages/avi@viewing:full
  (cons* mpv-mpris
	 playerctl
	 vlc
	 packages/avi@viewing))

