(define-module (bos home empty)
	#:use-module (gnu home)
	#:use-module (gnu home services)
	#:export (empty-home))

(define empty-home (home-environment))

empty-home
