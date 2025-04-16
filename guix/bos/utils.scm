(define-module (bos utils)
  #:export (try-load))

(define (try-load path)
  (catch #t
	 (lambda _ (load path))
	 (lambda _ #f)))

