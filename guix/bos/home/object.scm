(define-module (bos home object)
  #:use-module (bos utils)
  #:use-module (bos home)
  #:use-module (gnu home)
  #:use-module (ice-9 rdelim))

(define home-dir (getenv "HOME_DIR"))
(define target (getenv "TARGET"))
(define free (getenv "FREE"))
(display target)
(newline)
(define base-home
  (when (and target home-dir)
    (or (try-load (string-append home-dir "/" target ".scm"))
	(try-load (string-append home-dir "/main.scm"))))) ; fallback 

(if (home-environment? base-home)
  (begin
    (display (string-append "\nBos-Guix: Using home '" target "'\n"))
    (extend-home base-home target))
  (begin
    (display (string-append "\nBos-Guix: Using empty (minimal) home "
			    (if free "[free]" "[nonfree]")
			    "\n"))
    (extend-home (empty-home #:non-free? (not free)))))


