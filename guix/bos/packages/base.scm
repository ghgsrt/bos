(define-module (bos packages base)
	#:use-module (gnu packages base)
	#:export (glibc-locales-us))

(define glibc-locales-us
  (make-glibc-utf8-locales
   glibc
   #:locales (list "en_US")
   #:name "glibc-us-utf8-locales"))
