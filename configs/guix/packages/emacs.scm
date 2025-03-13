(define-module (packages emacs)
               #:use-module (gnu packages emacs)
               #:export (core-packages-emacs
                          core-packages-emacs-no-x
                          supplementary-packages-emacs
                          guile-packages-emacs))

(define guile-packages-emacs
  (list emacs-geiser
        emacs-geiser-guile))

(define supplementary-packages-emacs
  (append guile-packages-emacs))

(define core-packages-emacs
  (cons emacs-lucid
        supplementary-packages-emacs))

(define core-packages-emacs-no-x
  (cons emacs-no-x-toolkit
        supplementary-packages-emacs))

