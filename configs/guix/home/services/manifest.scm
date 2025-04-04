(define-module (home services manifest)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells))

(define-public home/services/manifest
  (list (service home-files-service-type
		 `((".local/bin/generate-manifest"
		    ,(local-file "../../scripts/generate-manifests.sh" "generate-manifest"))
		   (".config/bash/manifest-cd.sh"
		    ,(local-file "../../scripts/manifest-cd.sh"))))
	(service home-bash-service-type
		 (home-bash-configuration
		   (bashrc (list (plain-file
				   "manifest-source.sh"
				   "\n# Source manifest cd function source ~/.config/bash/manifest-cd.sh\n")))
		   (aliases '(("regenerate-manifest" . "generate-manifest --force")))))))

