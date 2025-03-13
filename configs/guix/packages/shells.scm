(define-module (packages shells)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages bash)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (core-packages-cli))

(define core-packages-cli
  (list rust-bat-0.24
	zoxide
	fzf
	ripgrep
	hyperfine ; cli benchmarking
	fd))

(define-public zsh-antigen
  (package
   (name "zsh-antigen")
   (version "2.2.3")
   (home-page "https://github.com/zsh-users/antigen")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/zsh-users/antigen")
		  (commit (string-append "v" version))))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32
	      "1hqnwdskdmaiyi1p63gg66hbxi1igxib6ql8db3w950kjs1cs7rq"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan `(("bin/antigen.zsh" "share/zsh/plugins/zsh-antigen/"))))
   (synopsis "A zsh plugin manager.")
   (description "To make use of this derivation, use
      \"source\" \"/share/zsh/plugins/zsh-antigen/antigen.zsh\"")
   (license license:expat)))

; (define-public zsh-zinit
;   (package
;    (name "zsh-zinit")
;    (version "2.2.3")
;    (home-page "https://github.com/zdharma-continuum/zinit")
;    (source (origin
; 	    (method git-fetch)
; 	    (uri (git-reference
; 		  (url "https://github.com/zdharma-continuum/zinit")
; 		  (commit (string-append "v" version))))
; 	    (file-name (git-file-name name version))
; 	    (sha256
; 	     (base32
; 	      "1hqnwdskdmaiyi1p63gg66hbxi1igxib6ql8db3w950kjs1cs7rq"))))
;    (build-system copy-build-system)
;    (arguments
;     `(#:install-plan `(("bin/antigen.zsh" "share/zsh/plugins/zsh-antigen/"))))
;    (synopsis "A zsh plugin manager.")
;    (description "To make use of this derivation, use
;       \"source\" \"/share/zsh/plugins/zsh-antigen/antigen.zsh\"")
;    (license license:expat)))
