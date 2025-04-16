(define-module (system wsl)
  #:use-module (system)
  #:use-module (system base)
  #:use-module (home no-x))

(define-public system/wsl
  (bos-operating-system
    #:inherits (list system/base)
    #:default-home home/no-x:full))

system/wsl

