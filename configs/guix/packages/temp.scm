;(define-public rust-ansi-to-html-0.2
;  (package
;    (name "rust-ansi-to-html")
;    (version "0.2.2")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (crate-uri "ansi-to-html" version))
;       (file-name (string-append name "-" version ".tar.gz"))
;       (sha256
;        (base32 "18kwlgr3vfsij8gvl7vxw11yl628b1s8z2pldh73z4zzq2693gf7"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs (
;                       ("rust-regex" ,rust-regex-1)
;                       )
;       #:cargo-development-inputs (
;                                    ("rust-divan" ,rust-divan-0.1)
;                                    ("rust-flate2" ,rust-flate2-1)
;                                   ("rust-insta" ,rust-insta-1))))
;    (home-page
;     "https://github.com/Aloso/to-html/tree/master/crates/ansi-to-html")
;    (synopsis "ANSI escape codes to HTML converter")
;    (description "This package provides an ANSI escape codes to HTML converter.")
;    (license license:expat)))
;
;(define-public rust-libz-rs-sys-0.4
;  (package
;    (name "rust-libz-rs-sys")
;    (version "0.4.2")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (crate-uri "libz-rs-sys" version))
;       (file-name (string-append name "-" version ".tar.gz"))
;       (sha256
;        (base32 "0vsnvkff9i4qxnid1xl7wrmhz8alvqw9z5lnpimpzzgrxr4r56q0"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs (("rust-zlib-rs" ,rust-zlib-rs-0.4))))
;    (home-page "https://github.com/trifectatechfoundation/zlib-rs")
;    (synopsis "Memory-safe zlib implementation written in Rust")
;    (description
;     "This package provides a memory-safe zlib implementation written in Rust.")
;    (license license:zlib)))
;
;(define-public rust-rand-0.9
;  (package
;    (name "rust-rand")
;    (version "0.9.0")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (crate-uri "rand" version))
;       (file-name (string-append name "-" version ".tar.gz"))
;       (sha256
;        (base32 "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs
;       (
;        ("rust-log" ,rust-log-0.4)
;        ("rust-zerocopy" ,rust-zerocopy-0.8)
;        ("rust-rand-chacha" ,rust-rand-chacha-0.9)
;        ("rust-rand-core" ,rust-rand-core-0.9)
;        ("rust-serde" ,rust-serde-1))
;       #:cargo-development-inputs
;       (
;        ("rust-bincode" ,rust-bincode-1)
;        ("rust-rayon" ,rust-rayon-1)
;        ("rust-rand-pcg" ,rust-rand-pcg-0.9))))
;    (home-page "https://crates.io/crates/rand")
;    (synopsis "Random number generators and other randomness functionality")
;    (description
;     "Rand provides utilities to generate random numbers, to convert them to
;useful types and distributions, and some randomness-related algorithms.")
;    (license (list license:expat license:asl2.0))))
;
;(define-public rust-rand-core-0.9
;  (package
;    (name "rust-rand-core")
;    (version "0.9.0")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (crate-uri "rand_core" version))
;       (file-name (string-append name "-" version ".tar.gz"))
;       (sha256
;        (base32 "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs
;       (("rust-getrandom" ,rust-getrandom-0.3)
;        ("rust-zerocopy" ,rust-zerocopy-0.8)
;        ("rust-serde" ,rust-serde-1))))
;    (home-page "https://rust-random.github.io/book")
;    (synopsis "Core random number generator traits and tools")
;    (description
;     "This package provides core random number generator traits and
;tools for implementation.")
;    (license (list license:expat license:asl2.0))))
;
;(define-public rust-rand-chacha-0.9
;  (package
;    (name "rust-rand-chacha")
;    (version "0.9.0")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (crate-uri "rand_chacha" version))
;       (file-name (string-append name "-" version ".tar.gz"))
;       (sha256
;        (base32 "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs
;       (("rust-ppv-lite86" ,rust-ppv-lite86-0.2)
;        ("rust-rand-core" ,rust-rand-core-0.9)
;        ("rust-serde" ,rust-serde-1))
;       #:cargo-development-inputs
;       (
;        ("rust-rand-core" ,rust-rand-core-0.9)
;        ("rust-serde-json" ,rust-serde-json-1))))
;    (home-page "https://crates.io/crates/rand_chacha")
;    (synopsis "ChaCha random number generator")
;    (description
;     "This package provides the ChaCha random number generator.")
;    (license (list license:expat license:asl2.0))))
;
;(define-public rust-rand-pcg-0.9
;  (package
;    (name "rust-rand-pcg")
;    (version "0.9.0")
;    (source
;      (origin
;        (method url-fetch)
;        (uri (crate-uri "rand_pcg" version))
;        (file-name (string-append name "-" version ".tar.gz"))
;        (sha256
;         (base32
;          "0gn79wzs5b19iivybwa09wv4lhi4kbcqciasiqqynggnr8cd1jjr"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs
;       (("rust-rand-core" ,rust-rand-core-0.9)
;        ("rust-serde" ,rust-serde-1))
;       #:cargo-development-inputs
;       (("rust-rand-core" ,rust-rand-core-0.9)
;        ("rust-bincode" ,rust-bincode-1))))
;    (home-page "https://crates.io/crates/rand_pcg")
;    (synopsis
;     "Selected PCG random number generators")
;    (description
;     "This package implements a selection of PCG random number generators.")
;    (license (list license:asl2.0
;                   license:expat))))
;
;(define-public rust-getrandom-0.3
;  (package
;    (name "rust-getrandom")
;    (version "0.3.1")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (crate-uri "getrandom" version))
;       (file-name (string-append name "-" version ".tar.gz"))
;       (sha256
;        (base32 "1mzlnrb3dgyd1fb84gvw10pyr8wdqdl4ry4sr64i1s8an66pqmn4"))))
;    (build-system cargo-build-system)
;    (arguments
;     `(#:cargo-inputs
;       (("rust-cfg-if" ,rust-cfg-if-1)
;        ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
;        ("rust-js-sys" ,rust-js-sys-0.3)
;        ("rust-libc" ,rust-libc-0.2)
;        ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
;        ("rust-wasi" ,rust-wasi-0.11)
;        ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2))
;       #:cargo-development-inputs
;       (("rust-wasm-bindgen-test" ,rust-wasm-bindgen-test-0.3))))
;    (home-page "https://github.com/rust-random/getrandom")
;    (synopsis "Retrieve random data from system source")
;    (description
;     "This package provides a small cross-platform library for
;retrieving random data from system source.")
;    (license (list license:expat license:asl2.0))))
;
;; TO MAKE
;; ansi-to-html
;; - flate2
;;   - rand
;;       - rand-core
;;           - getrandom-0.3
;;       - rand-chacha
;;       - rand-pcg
