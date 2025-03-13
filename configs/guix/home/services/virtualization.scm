(define-module (home services virtualization)
  #:use-module (home)
  #:use-module (gnu packages virtualization)
  #:export (core-packages-virtualization
	    podman-services))

(define core-packages-virtualization
  (list podman
	podman-compose
	passt
	qemu))

;; ~~ PODMAN ~~

(define podman-services
	(list (bos-home-service 'bos-podman
	#:packages core-packages-virtualization
	#:env-vars `(("DOCKER_HOST" . "unix:///tmp/podman.sock")))))

