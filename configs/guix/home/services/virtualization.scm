(define-module (home services virtualization)
  #:use-module (home)
  #:use-module (packages virtualization)
  #:export (home/services/podman))

;; ~~ PODMAN ~~

(define home/services/podman
  (list (bos-home-service
	  'bos-podman
	  #:packages packages/podman
	  #:env-vars `(("DOCKER_HOST" . "unix:///tmp/podman.sock")))))

;; ~~ QEMU ~~

