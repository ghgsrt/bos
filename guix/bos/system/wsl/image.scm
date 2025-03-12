(define-module (bos system wsl image)
  #:use-module (bos system wsl)
  #:use-module (gnu image)
  #:use-module (gnu system image))

(define-public (wsl2-image system boot-user)
  (image
    (inherit (os->image 
               (extend-wsl-system system boot-user)
               #:type wsl2-image-type))
    (name 'wsl2-image)))

;; == MAIN =======================================================

(image
  (inherit (os->image
             (load "../wsl.scm")
             #:type wsl2-image-type))
  (name 'wsl2-image))

