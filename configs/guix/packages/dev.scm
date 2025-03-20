(define-module (packages dev)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu packages haskell-apps)
  #:export (packages/shell
	    packages/guile))

;; ~~ SHELL ~~

(define packages/shell
  (list shellcheck
	shfmt))

;; ~~ GUILE ~~

(define packages/guile
  (list guile-3.0
	guile-fibers
	guile-colorized
	guile-g-golf
	;guile-uuid
	guile-json-4))

