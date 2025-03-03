(define-module (bos system wsl empty)
  #:use-module (bos system)
  #:use-module (bos system empty)
  #:use-module (bos system wsl)
  #:use-module (gnu)
  #:export (empty-wsl-system
            empty-wsl-system-free
            empty-wsl-system-nonfree))

(define* (empty-wsl-system #:key (non-free? #f))
  (operating-system
    (inherit (extend-wsl-system (empty-system #:non-free? non-free?)))))

(define empty-wsl-system-free (extend-system (empty-wsl-system)))
(define empty-wsl-system-free (extend-system (empty-wsl-system #:non-free? #t)))

empty-wsl-system-free

