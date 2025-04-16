(define-module (bos system object)
  #:use-module (bos system)
  #:use-module (gnu system)
  #:use-module (ice-9 rdelim))

(define system-dir (getenv "SYSTEM_DIR"))
(define target (getenv "TARGET"))
(define free (getenv "FREE"))

(define base-system
  (when (and target system-dir)
    (load (string-append system-dir "/" target ".scm"))))

(if (operating-system? base-system)
  (begin
    (display (string-append "\nBos-Guix: Using system '" target "'\n"))
    (extend-system base-system))
  (begin
    (display (string-append "\nBos-Guix: Using empty (minimal) system "
			    (if free "[free]" "[nonfree]")
			    "\n"))
    (extend-system (empty-system #:non-free? (not free)))))

