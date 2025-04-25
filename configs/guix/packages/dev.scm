(define-module (packages dev)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu packages haskell-apps)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (packages/shell
	    packages/guile
	    packages/golang))

;; ~~ SHELL ~~

(define packages/shell
  (list shellcheck
	shfmt))

;; ~~ GUILE ~~

(define packages/guile
  (list guile-3.0
	guile-fibers
	guile-colorized
	guile-readline
	guile-g-golf
	;guile-uuid
	guile-json-4))

;; ~~ GOLANG ~~

(define-public cobra-cli
  (package
    (name "go-github-com-spf13-cobra-cli")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/spf13/cobra-cli")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0hg944irnjbxl629dk9y8z3ffm9qa1lwr5d1xnpj6viq3hzkyhhk"))))
    (build-system go-build-system)
    (arguments
     (list
      #:tests? #f
      #:import-path "github.com/spf13/cobra-cli"))
    (propagated-inputs (list go-github-com-spf13-viper
                             go-github-com-spf13-cobra))
    (home-page "https://github.com/spf13/cobra-cli")
    (synopsis "Cobra Generator")
    (description
     "Cobra provides its own program that will create your application and add any
commands you want.  It's the easiest way to incorporate Cobra into your
application.")
    (license license:asl2.0)))

(define packages/golang
  (list go
	gopls
	cobra-cli))

