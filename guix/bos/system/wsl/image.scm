(define-module (bos system wsl image)
  #:use-module (bos system wsl)
  #:use-module (gnu image)
  #:use-module (gnu system image)
  #:use-module (ice-9 rdelim))

(define-public (os->image/wsl2 system boot-user)
  (image
    (inherit (os->image 
               (extend-wsl-system system boot-user)
               #:type wsl2-image-type))
    (name 'wsl2-image)))

;; == MAIN =======================================================
(display "\n\nIMAGE\n\n")
(define return (getenv "RETURN"))

(when return
  (image
    (inherit (os->image
               (load "./object.scm")
               #:type wsl2-image-type))
    (name 'wsl2-image)))

