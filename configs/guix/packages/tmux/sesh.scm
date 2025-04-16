(define-module (packages tmux sesh)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages golang-check)
  #:use-module ((guix licenses) #:prefix license:))

(define-public tmux-sesh
  (package
    (name "tmux-sesh")
    (version "2.13.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/joshmedeski/sesh")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1gx9amklqnmm8xlyc3i3bapfblz213cwngh6bz6jrgrflxhx8nv0"))))
    (build-system go-build-system)
    (arguments
      (list
        #:import-path "github.com/joshmedeski/sesh"))
    (native-inputs
      (list go-github-com-pelletier-go-toml-v2
            go-github-com-stretchr-testify
            go-github-com-urfave-cli-v2))
    (home-page "https://github.com/joshmedeski/sesh")
    (synopsis "A CLI to help you create and manage tmux sessions")
    (description
      "Sesh is a CLI that helps you create and manage tmux sessions quickly and easily using zoxide.")
      (license license:expat)))
