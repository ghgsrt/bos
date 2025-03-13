(define-module (packages)
               #:export (essential-packages
                          core-packages))

(define essential-packages
  (list 
    git
    nss-certs
    openssl
    openssh
    coreutils
    ncurses
    net-tools
    curl
    wget2
    ripgrep
    fd
    dstat))

(define core-packages
  (cons* 
    git:send-email
    gcc-toolchain
    make
    watchexec
    lz4
    essential-packages))

