(define-module (packages base)
  #:use-module (packages vim)
  #:use-module (packages tmux)

  #:use-module (gnu packages)
  #:use-module (gnu packages base) ; coreutils, make
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages commencement) ; gcc-toolchain
  #:use-module (gnu packages compression)
  #:use-module (gnu packages admin) ; dstat
  #:use-module (gnu packages linux) ; net-tools
  #:use-module (gnu packages rust-apps) ; watchexec
  #:export (packages:essential
            packages:core))

(define packages:essential
  (append packages/tmux
          (list git-minimal
                openssl
                openssh
                coreutils
                ncurses
                net-tools
                curl
                wget2)))

(define packages:core
  (append packages:essential
          packages/vim
          (list gcc-toolchain
                (specification->package "make")
                watchexec
                lz4
                dstat)))

