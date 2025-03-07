(define-module (bos system wsl image)
               #:use-module (bos system)
               #:use-module (bos system wsl)
               #:use-module (gnu image)
               #:use-module (gnu system image)
               #:use-module (ice-9 rdelim))

(define-public (wsl2-image system boot-user)
               (image
                 (inherit (os->image 
                            (extend-wsl-system system boot-user)
                            #:type wsl2-image-type))
                 (name 'wsl2-image)))


(define system-dir (getenv "SYSTEM_DIR"))
(define target (getenv "TARGET"))
(define user (getenv "USER"))

(when (and target system-dir)
  (let ((base-system (load (string-append system-dir "/" target ".scm"))))
    (when base-system
      (wsl2-image
        (extend-system base-system) 
        (or user "root")))))

