(define-module (bos system)
	#:use-module (bos utils)
	#:use-module (bos home)
	#:use-module (guix)
	#:use-module (gnu)
	#:use-module (gnu services guix)
	#:use-module (gnu system)
	#:use-module (guix gexp)     ; For local-file
	#:use-module (ice-9 rdelim)  ; For reading environment variables
	#:export (extend-system))

;; Handles augmenting any arbitrary home environment to be compatible
;; with the bos dotfile setup

(define (extend-system base-system)
	(operating-system
		(inherit base-system)
(services (modify-services (operating-system-user-services base-system)
						(guix-home-service-type homes =>
						;; Ensure any default homes are extended for compatibility with the
						;; bos dotfile setup
							(map (lambda (home)
									(list (list-ref home 0)
										  (extend-home (list-ref home 1))))
								  homes))))))
