(define-module (packages emacs)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:export (packages/emacs
            packages/emacs:no-x
            packages/emacs@guile
            packages/emacs:supplementary))

(define packages/emacs@guile
  (list emacs-geiser
        emacs-geiser-guile))

(define packages/emacs:supplementary
  (append packages/emacs@guile))

(define packages/emacs
  (cons emacs-lucid
        packages/emacs:supplementary))

(define packages/emacs:no-x
  (cons emacs-no-x
        packages/emacs:supplementary))

