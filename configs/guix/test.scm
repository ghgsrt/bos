(define-module (test)
               #:use-module (ice-9 rdelim)
               #:use-module (utils))

(define big-balls '(1 2 3))

(define sym (getenv "PICK"))

;(module-ref (current-module) (string->symbol sym))
(symbol->value sym)

