(define-module (packages fonts)
  #:use-module (gnu packages fonts)
  #:use-module (guix packages)
  #:use-module (guix download)
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

(define-public font-nerd-fonts-fira-code
  (package
    (name "font-nerd-fonts-fira-code")
    (version "3.3.0")
    (source
     (origin
       (method url-fetch/zipbomb)
       (uri (string-append "https://github.com/ryanoasis/nerd-fonts/releases/"
                           "download/v" version
                           "/FiraCode.zip"))
       (sha256
        (base32 "15xks0619yip4gkgwandn529fmk1v5g1s5irlf34410dhxpqx5w9"))))
    (build-system font-build-system)
    (home-page "https://mozilla.github.io/Fira/")
    (synopsis "Monospaced font with programming ligatures (patched for Nerd Fonts)")
    (description
     "Fira Code is an extension of the Fira Mono font containing a set of ligatures
for common programming multi-character combinations.  This is just a font rendering
feature: underlying code remains ASCII-compatible.  This helps to read and understand
code faster.  For some frequent sequences like .. or //, ligatures allow us to
correct spacing. This version of Fira Code has been patched for Nerd Fonts.")
    (license license:silofl1.1)))

(define packages/fonts:essential
  (list font-ghgsrt))

(define packages/fonts
  (cons* font-nerd-fonts-fira-code
         font-ibm-plex
         font-liberation
         font-iosevka
         font-google-noto-emoji
         packages/fonts:essential))

