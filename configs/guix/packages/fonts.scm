(define-module (packages fonts)
  #:use-module (gnu packages fonts)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system font)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (packages/fonts:essential
            packages/fonts))

(define-public font-ghgsrt
  (let ((commit "2867625612f3ba54609333959e2a853a5848c13e")
        (revision "0"))
    (package
      (name "font-ghgsrt")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/ghgsrt/fonts")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0lvi69iskdrvmy9vwp327c83mf8jxdavs6dh4ssbhw6lbfw01vs1"))))
      (build-system font-build-system)
      (home-page "https://github.com/ghgsrt/fonts")
      (synopsis "My custom font package")
      (description
        "All the fonts Guix doesn't have/that doesn't have a repo suitable for independent packaging.")
      (license license:expat))))

(define packages/fonts:essential
  (list font-ghgsrt))

(define packages/fonts
  (cons* font-fira-code
         packages/fonts:essential))

