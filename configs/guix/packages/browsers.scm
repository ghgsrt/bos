(define-module (packages browsers)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages chromium)
  #:use-module (gnu packages gnuzilla)
  #:use-modue (nongnu packages chrome)
  #:export (packages/browsers
	    packages/browsers:full))

(define packages/browsers
  (list icecat
	nyxt))

(define packages/browsers:full
  (cons* ungoogled-chromium
	 ; necessary for some websites (e.g., adobe media player support for things like inflight entertainment)
	 ; need to verify if firefox will work instead, can't get it to install atm
	 ; if I can somehow get Gnash to work, maybe won't need either
	 google-chrome-stable 
	 packages/browsers))

