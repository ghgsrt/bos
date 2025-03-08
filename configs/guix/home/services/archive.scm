(define-module (home services archive)
  #:use-module (home)
  #:use-module (packages)
  #:use-module (services)
  #:export (archive@minimal-services archive-services))

(define archive@minimal-packages-service-type
  (bos-home-service-type 'bos-archive@minimal-packages
	#:packages (list (specification->package "zip")
					 unzip)))

(define archive@minimal-services
	(list (service archive@minimal-packages-service-type)))

(define archive-packages-service-type
  (bos-home-service-type 'bos-archive-packages
	#:packages (list gzip
					 bzip2
					 xz
					 tar
					 p7zip)))

(define archive-services
	(cons (service archive-packages-service-type) archive@minimal-services))
