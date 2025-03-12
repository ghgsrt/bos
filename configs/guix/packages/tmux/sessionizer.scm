(define-module (packages tmux sessionizer)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-crypto)
  #:use-module (gnu packages crates-vcs)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-check)
  #:use-module (gnu packages crates-web)
  #:use-module (gnu packages crates-compression)
  #:use-module ((guix licenses) #:prefix license:))

(define-public rust-octocrab-0.39
               (package
                 (name "rust-octocrab")
                 (version "0.39.0")
                 (source
                   (origin
                     (method url-fetch)
                     (uri (crate-uri "octocrab" version))
                     (file-name (string-append name "-" version ".tar.gz"))
                     (sha256
                       (base32 "00a19h6xpcbpf9dcim9pbvz1awfasvlwjnfn5gsd1v23jp4y81ck"))))
                 (build-system cargo-build-system)
                 (arguments
                   `(#:cargo-inputs (("rust-arc-swap" ,rust-arc-swap-1)
                                     ("rust-async-trait" ,rust-async-trait-0.1)
                                     ("rust-base64" ,rust-base64-0.22)
                                     ("rust-bytes" ,rust-bytes-1)
                                     ("rust-cfg-if" ,rust-cfg-if-1)
                                     ("rust-chrono" ,rust-chrono-0.4)
                                     ("rust-either" ,rust-either-1)
                                     ("rust-futures" ,rust-futures-0.3)
                                     ("rust-futures-core" ,rust-futures-core-0.3)
                                     ("rust-futures-util" ,rust-futures-util-0.3)
                                     ("rust-http" ,rust-http-1)
                                     ("rust-http-body" ,rust-http-body-1)
                                     ("rust-http-body-util" ,rust-http-body-util-0.1)
                                     ("rust-hyper" ,rust-hyper-1)
                                     ("rust-hyper-rustls" ,rust-hyper-rustls-0.26)
                                     ("rust-hyper-timeout" ,rust-hyper-timeout-0.5)
                                     ("rust-hyper-tls" ,rust-hyper-tls-0.6)
                                     ("rust-hyper-util" ,rust-hyper-util-0.1)
                                     ("rust-jsonwebtoken" ,rust-jsonwebtoken-9)
                                     ("rust-once-cell" ,rust-once-cell-1)
                                     ("rust-percent-encoding" ,rust-percent-encoding-2)
                                     ("rust-pin-project" ,rust-pin-project-1)
                                     ("rust-secrecy" ,rust-secrecy-0.8)
                                     ("rust-serde" ,rust-serde-1)
                                     ("rust-serde-json" ,rust-serde-json-1)
                                     ("rust-serde-path-to-error" ,rust-serde-path-to-error-0.1)
                                     ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                                     ("rust-snafu" ,rust-snafu-0.8)
                                     ("rust-tokio" ,rust-tokio-1)
                                     ("rust-tower" ,rust-tower-0.4)
                                     ("rust-tower-http" ,rust-tower-http-0.5)
                                     ("rust-tracing" ,rust-tracing-0.1)
                                     ("rust-url" ,rust-url-2))
                     #:cargo-development-inputs
                     (("rust-base64" ,rust-base64-0.22)
                      ("rust-crypto-box" ,rust-crypto-box-0.8)
                      ("rust-graphql-client" ,rust-graphql-client-0.14)
                      ("rust-pretty-assertions" ,rust-pretty-assertions-1)
                      ("rust-tokio" ,rust-tokio-1)
                      ("rust-tokio-test" ,rust-tokio-test-0.4)
                      ("rust-wiremock" ,rust-wiremock-0.6))))
                 (native-inputs (list nss-certs-for-test))
                 (home-page "https://github.com/XAMPPRocky/octocrab")
                 (synopsis "Extensible GitHub API client")
                 (description
                   "This package provides a modern, extensible @code{GitHub} API client.")
                 (license (list license:expat license:asl2.0))))

(define-public rust-ratatui-0.28
               (package
                 (name "rust-ratatui")
                 (version "0.28.0")
                 (source
                   (origin
                     (method url-fetch)
                     (uri (crate-uri "ratatui" version))
                     (file-name (string-append name "-" version ".tar.gz"))
                     (sha256
                       (base32 "00w3jw6xay3nrqkhwl0226j102wpdd2a5gkmjaciammymxjs79jv"))))
                 (build-system cargo-build-system) 
                 (arguments
                   `(#:cargo-test-flags
                     '("--"
                       "--skip=backend::test::tests::buffer_view_with_overwrites"
                       "--skip=buffer::buffer::tests::renders_emoji::case_2_polarbear"
                       "--skip=buffer::buffer::tests::renders_emoji::case_3_eye_speechbubble"
                       "--skip=text::span::tests::width")
                     #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                                     ("rust-cassowary" ,rust-cassowary-0.3)
                                     ("rust-compact-str" ,rust-compact-str-0.8)
                                     ("rust-crossterm" ,rust-crossterm-0.28)
                                     ("rust-document-features" ,rust-document-features-0.2)
                                     ("rust-instability" ,rust-instability-0.3)
                                     ("rust-itertools" ,rust-itertools-0.13)
                                     ("rust-lru" ,rust-lru-0.12)
                                     ("rust-palette" ,rust-palette-0.7)
                                     ("rust-paste" ,rust-paste-1)
                                     ("rust-serde" ,rust-serde-1)
                                     ("rust-strum" ,rust-strum-0.26)
                                     ("rust-strum-macros" ,rust-strum-macros-0.26)
                                     ("rust-termion" ,rust-termion-4)
                                     ("rust-termwiz" ,rust-termwiz-0.22)
                                     ("rust-time" ,rust-time-0.3)
                                     ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                                     ("rust-unicode-truncate" ,rust-unicode-truncate-1)
                                     ("rust-unicode-width" ,rust-unicode-width-0.1))
                     #:cargo-development-inputs
                     (("rust-argh" ,rust-argh-0.1)
                      ("rust-color-eyre" ,rust-color-eyre-0.6)
                      ("rust-criterion" ,rust-criterion-0.5)
                      ("rust-crossterm" ,rust-crossterm-0.28)
                      ("rust-derive-builder" ,rust-derive-builder-0.20)
                      ("rust-fakeit" ,rust-fakeit-1)
                      ("rust-font8x8" ,rust-font8x8-0.3)
                      ("rust-futures" ,rust-futures-0.3)
                      ("rust-indoc" ,rust-indoc-2)
                      ("rust-octocrab" ,rust-octocrab-0.39)
                      ("rust-pretty-assertions" ,rust-pretty-assertions-1)
                      ("rust-rand" ,rust-rand-0.8)
                      ("rust-rand-chacha" ,rust-rand-chacha-0.3)
                      ("rust-rstest" ,rust-rstest-0.22)
                      ("rust-serde-json" ,rust-serde-json-1)
                      ("rust-tokio" ,rust-tokio-1)
                      ("rust-tracing" ,rust-tracing-0.1)
                      ("rust-tracing-appender" ,rust-tracing-appender-0.2)
                      ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3))))
                 (home-page "https://ratatui.rs")
                 (synopsis "Library for cooking up terminal user interfaces")
                 (description
                   "This package provides a library that's all about cooking up terminal user
                   interfaces.")
                   (license license:expat)))

(define-public rust-nucleo-0.5
               (package
                 (name "rust-nucleo")
                 (version "0.5.0")
                 (source
                   (origin
                     (method url-fetch)
                     (uri (crate-uri "nucleo" version))
                     (file-name (string-append name "-" version ".tar.gz"))
                     (sha256
                       (base32 "1m1rq0cp02hk31z7jsn2inqcpy9a1j8gfvxcqm32c74jji6ayqjj"))))
                 (build-system cargo-build-system)
                 (arguments
                   `(#:cargo-inputs (("rust-nucleo-matcher" ,rust-nucleo-matcher-0.3)
                                     ("rust-parking-lot" ,rust-parking-lot-0.12)
                                     ("rust-rayon" ,rust-rayon-1))))
                 (home-page "https://github.com/helix-editor/nucleo")
                 (synopsis "Plug and play high performance fuzzy matcher")
                 (description
                   "This package provides plug and play high performance fuzzy matcher.")
                 (license license:mpl2.0)))

(define-public rust-nucleo-matcher-0.3
               (package
                 (name "rust-nucleo-matcher")
                 (version "0.3.1")
                 (source
                   (origin
                     (method url-fetch)
                     (uri (crate-uri "nucleo-matcher" version))
                     (file-name (string-append name "-" version ".tar.gz"))
                     (sha256
                       (base32 "11dc5kfin1n561qdcg0x9aflvw876a8vldmqjhs5l6ixfcwgacxz"))))
                 (build-system cargo-build-system)
                 (arguments
                   `(#:cargo-inputs (("rust-memchr" ,rust-memchr-2)
                                     ("rust-unicode-segmentation" ,rust-unicode-segmentation-1))))
                 (home-page "https://github.com/helix-editor/nucleo")
                 (synopsis "Plug and play high performance fuzzy matcher")
                 (description
                   "This package provides plug and play high performance fuzzy matcher.")
                 (license license:mpl2.0)))

(define-public rust-error-stack-0.5
               (package
                 (name "rust-error-stack")
                 (version "0.5.0")
                 (source
                   (origin
                     (method url-fetch)
                     (uri (crate-uri "error-stack" version))
                     (file-name (string-append name "-" version ".tar.gz"))
                     (sha256
                       (base32 "1lf5zy1fjjqdwjkc445sw80hpmxi63ymcxgjh3q6642x2hck6hgy"))))  
                 (build-system cargo-build-system)
                 (arguments
                   `(#:tests? #f ; tests expect entry point at hash, not at hash/libs/error-stack
                     #:cargo-inputs
                     (("rust-anyhow" ,rust-anyhow-1)
                      ("rust-eyre" ,rust-eyre-0.6)
                      ("rust-futures-core" ,rust-futures-core-0.3)
                      ("rust-serde" ,rust-serde-1)
                      ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                      ("rust-spin" ,rust-spin-0.9)
                      ("rust-tracing" ,rust-tracing-0.1)
                      ("rust-tracing-error" ,rust-tracing-error-0.2))
                     #:cargo-development-inputs
                     (("rust-serde" ,rust-serde-1)
                      ("rust-ansi-to-html" ,rust-ansi-to-html-0.2) ; expects 0.2.2
                      ("rust-expect-test" ,rust-expect-test-1)
                      ("rust-futures" ,rust-futures-0.3)
                      ("rust-futures-util" ,rust-futures-util-0.3)
                      ("rust-insta" ,rust-insta-1) ; expects 1.42.1 (got 1.41.1)
                      ("rust-owo-colors" ,rust-owo-colors-4) ; expects 4.2.0 (got 4.1.0)
                      ("rust-regex" ,rust-regex-1)
                      ("rust-supports-color" ,rust-supports-color-3)
                      ("rust-supports-unicode" ,rust-supports-unicode-3)
                      ("rust-thiserror" ,rust-thiserror-2) ; expects 2.0.11 (got 2.0.9)
                      ("rust-tracing" ,rust-tracing-0.1)
                      ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3)
                      ("rust-trybuild" ,rust-trybuild-1)))) ; expects 1.0.103 (got 1.0.101)
                 (synopsis "A context-aware error-handling library that supports arbitrary attached user data.")
                 (description "error-stack is a context-aware error-handling library that supports arbitrary attached user data.")
                 (home-page "https://github.com/hashintel/hash/tree/main/libs/error-stack")
                 (license license:expat)))


(define-public rust-ansi-to-html-0.2
  (package
    (name "rust-ansi-to-html")
    (version "0.2.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ansi-to-html" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0r07skcd0rp4fwww66hn2sal4f7p4nhq2zjpk7pkamr8zjj87qhj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (
                       ("rust-regex" ,rust-regex-1)
                       )
       #:cargo-development-inputs (
                                    ("rust-divan" ,rust-divan-0.1)
                                    ("rust-flate2" ,rust-flate2-1)
                                   ("rust-insta" ,rust-insta-1))))
    (home-page
     "https://github.com/Aloso/to-html/tree/master/crates/ansi-to-html")
    (synopsis "ANSI escape codes to HTML converter")
    (description "This package provides an ANSI escape codes to HTML converter.")
    (license license:expat)))

(define-public tmux-sessionizer
               (package
                 (name "tmux-sessionizer")
                 (version "0.4.4")
                 (source
                   (origin
                     (method url-fetch)
                     (uri (crate-uri "tmux-sessionizer" version))
                     (file-name (string-append name "-" version ".tar.gz"))
                     (sha256
                       (base32 "0fwdc8jyx9fab442c6zsl3yn8nh1s5h35g97cgqhyp3blxl6h9ix"))
                     (snippet #~(begin (use-modules (guix build utils))
                                   (substitute* "Cargo.toml" (("\"vendored-openssl\"") ""))))
                     )) 
                 (build-system cargo-build-system)
                 (native-inputs (list pkg-config))
                 (inputs (list openssl libgit2-1.8 libssh2))
                 (arguments
                   `(
                ;     #:phases (modify-phases %standard-phases
                ;      (add-before 'configure 'prepare-build-environment
                ;        (lambda _ (setenv "OPENSSL_NO_VENDOR" "1"))))
                     #:cargo-inputs
                     (("rust-git2" ,rust-git2-0.19) ;; expects 0.20
                      ("rust-clap" ,rust-clap-4)
                      ("rust-clap-complete" ,rust-clap-complete-4)
                      ("rust-serde" ,rust-serde-1)
                      ("rust-error-stack" ,rust-error-stack-0.5) ;; not found :(
                      ("rust-serde-derive" ,rust-serde-derive-1)
                      ("rust-shellexpand" ,rust-shellexpand-3)
                      ("rust-aho-corasick" ,rust-aho-corasick-1)
                      ("rust-shell-words" ,rust-shell-words-1)
                      ("rust-config" ,rust-config-0.14) ;; expects 0.15
                      ("rust-toml" ,rust-toml-0.8)
                      ("rust-dirs" ,rust-dirs-5) ;; expects 6.0
                      ("rust-nucleo" ,rust-nucleo-0.5) ;; expects 0.5.0
                      ("rust-ratatui" ,rust-ratatui-0.28)
                      ("rust-crossterm" ,rust-crossterm-0.28))
                     #:cargo-development-inputs
                     (("rust-anyhow" ,rust-anyhow-1)
                      ("rust-assert-cmd" ,rust-assert-cmd-2)
                      ("rust-once-cell" ,rust-once-cell-1)
                      ("rust-predicates" ,rust-predicates-3)
                      ("rust-pretty-assertions" ,rust-pretty-assertions-1)
                      ("rust-tempfile" ,rust-tempfile-3)))) ;; expects 3.16 (got 3.14)
                 (synopsis "A tmux session manager")
                 (description "Tmux Sessionizer is a tool to quickly create and switch between tmux sessions based on directories.")
                 (home-page "https://github.com/jrmoulton/tmux-sessionizer")
                 (license license:expat)))

tmux-sessionizer
