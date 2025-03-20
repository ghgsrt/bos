(define-module (packages virtualization)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages containers)
  #:export (packages/podman))

(define packages/podman
  (list podman
	podman-compose
	passt))

