(define-module (packages browsers)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages chromium)
  #:use-module (gnu packages gnuzilla)
  #:export (packages/browsers
	    packages/browsers:full))

(define packages/browsers
  (list nyxt))

(define packages/browsers:full
  (cons* ungoogled-chromium
	 icecat
	 packages/browsers))

