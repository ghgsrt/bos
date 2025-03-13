(define-module (home services virtualization)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (podman-services))

(define core-packages-virtualization
  (list)

;; ~~ PODMAN ~~

(define podman-service-type
  (bos-home-service-type 'bos-podman
	#:packages (list podman
			 podman-compose)
	#:env-vars `(("DOCKER_HOST" . "unix:///tmp/podman.sock"))))

(define podman-services
	(list (service podman-service-type)))
