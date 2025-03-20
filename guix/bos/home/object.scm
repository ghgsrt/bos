(define-module (bos home object)
  #:use-module (bos home)
  #:use-module (gnu home)
  #:use-module (ice-9 rdelim))

(define home-dir (getenv "HOME_DIR"))
(define target (getenv "TARGET"))
(define free (getenv "FREE"))

(define base-home
  (when (and target home-dir)
    (load (string-append home-dir "/" target ".scm"))))

(if (home-environment? base-home)
  (begin
    (display (string-append "\nBos-Guix: Using home '" target "'\n"))
    (extend-home base-home))
  (begin
    (display (string-append "\nBos-Guix: Using empty (minimal) home "
			    (if free "[free]" "[nonfree]")
			    "\n"))
    (extend-home (empty-home #:non-free? (not free)))))


