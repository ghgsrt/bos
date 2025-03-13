(define-module (packages tmux)
               #:use-module (guix packages)
               #:use-module (guix git-download)
               #:use-module (guix build-system copy)
               #:use-module ((guix licenses) #:prefix license:)
               #:use-module (gnu packages tmux)
               #:use-module (packages tmux sessionizer)
               #:use-module (packages tmux sesh)
               #:export (core-packages-tmux)
               #:re-export (list tmux-sesh
                                 tmux-sessionizer))

;; current tmux setup
(define core-packages-tmux
  (list tmux
        tmux-tpm
        tmux-sesh))

(define-public tmux-tpm
  (package
   (name "tmux-tpm")
   (version "3.1.0")
   (home-page "https://github.com/tmux-plugins/tpm")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/tmux-plugins/tpm")
		  (commit (string-append "v" version))))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32
	      "18i499hhxly1r2bnqp9wssh0p1v391cxf10aydxaa7mdmrd3vqh9"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan `(("." "share/.tmux/plugins/tpm"))))
   (synopsis "A tmux plugin manager.")
   (description "To make use of this derivation, use")
   (license license:expat)))

