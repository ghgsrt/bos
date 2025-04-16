(define-module (packages guix)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages man)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages texinfo)
  #:export (packages/guix-hacking))

(define packages/guix-hacking
  (list autoconf
        automake
        gettext-minimal
        texinfo
        graphviz
        help2man))

