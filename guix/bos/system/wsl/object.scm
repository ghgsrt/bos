(define-module (bos system wsl oject)
  #:use-module (bos system)
  #:use-module (bos system wsl)
  #:use-module (gnu system)
  #:use-module (ice-9 rdelim))

(define boot-user (getenv "BOOT_USER"))

(define base-system (load "../object.scm"))

(if (operating-system? base-system)
  (extend-wsl-system base-system (or boot-user "root"))
  (display (string-append 
             "\nERROR: operating system definition for target "
             (getenv "TARGET")
             " not found!\n")))

