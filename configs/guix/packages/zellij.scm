(define-module (packages zellij)
  #:use-module (gnu build-system cargo)
  #:use-module (gnu packages crates-io))

(define-public rust-wast-35
  (package
    (name "rust-wast")
    (version "35.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wast" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0s2d43g326dw21bygpalzjnr1fi83lx4afimg1h5hilrnkql1w9f"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-leb128" ,rust-leb128-0.2))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wast")
    (synopsis
     "Customizable Rust parsers for the WebAssembly Text formats WAT and WAST")
    (description
     "This package provides Customizable Rust parsers for the @code{WebAssembly} Text formats WAT and WAST.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-witx-0.9
  (package
    (name "rust-witx")
    (version "0.9.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "witx" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0jzgmayh2jjbv70jzfka38g4bk4g1fj9d0m70qkxpkdbbixg4rp3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wast" ,rust-wast-35))))
    (home-page "https://github.com/WebAssembly/WASI")
    (synopsis "Parse and validate witx file format")
    (description "This package provides Parse and validate witx file format.")
    (license license:asl2.0)))

(define-public rust-wiggle-generate-29
  (package
    (name "rust-wiggle-generate")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wiggle-generate" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "00g12vfj0rfvzbq3c5cxgm057gg6mfn58jwg2g414fb70pfngwic"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-heck" ,rust-heck-0.5)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-shellexpand" ,rust-shellexpand-2)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-witx" ,rust-witx-0.9))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Library crate for wiggle code generator")
    (description
     "This package provides Library crate for wiggle code generator.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wiggle-macro-29
  (package
    (name "rust-wiggle-macro")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wiggle-macro" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0315xqcj3a4rw1d81848mc61237z2gvhjf3z6wnnr3hrsirw9i88"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-wiggle-generate" ,rust-wiggle-generate-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Wiggle code generator")
    (description "This package provides Wiggle code generator.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wiggle-29
  (package
    (name "rust-wiggle")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wiggle" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "07bmwswj7y8wpa01j95l514icnbrl2lj0ls6c7155732r5dz76jb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-wasmtime" ,rust-wasmtime-29)
                       ("rust-wiggle-macro" ,rust-wiggle-macro-29)
                       ("rust-witx" ,rust-witx-0.9))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Runtime components of wiggle code generator")
    (description
     "This package provides Runtime components of wiggle code generator.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-libssh2-sys-0.3
  (package
    (name "rust-libssh2-sys")
    (version "0.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "libssh2-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1f8i31h3666rl6sq7v64ajdq03hmylkh6c1vaf9828aaml2ly3i2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libz-sys" ,rust-libz-sys-1)
                       ("rust-openssl-sys" ,rust-openssl-sys-0.9)
                       ("rust-pkg-config" ,rust-pkg-config-0.3)
                       ("rust-vcpkg" ,rust-vcpkg-0.2))))
    (home-page "https://github.com/alexcrichton/ssh2-rs")
    (synopsis "Native bindings to the libssh2 library")
    (description
     "This package provides Native bindings to the libssh2 library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-ssh2-0.9
  (package
    (name "rust-ssh2")
    (version "0.9.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ssh2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1j38p804b8sbgnfw1x8j2mkvh6yva7li36b2la8lw3ca7cxx311g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libssh2-sys" ,rust-libssh2-sys-0.3)
                       ("rust-parking-lot" ,rust-parking-lot-0.12))))
    (home-page "https://github.com/alexcrichton/ssh2-rs")
    (synopsis
     "Bindings to libssh2 for interacting with SSH servers and executing remote
commands, forwarding local ports, etc.")
    (description
     "This package provides Bindings to libssh2 for interacting with SSH servers and executing remote
commands, forwarding local ports, etc.")
    (license (list license:expat license:asl2.0))))

(define-public rust-char-device-0.16
  (package
    (name "rust-char-device")
    (version "0.16.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "char-device" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0qsmmh886sjxl8izdd1fm4y08yflq0mxvj030sfx70n1bmhixksm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-std" ,rust-async-std-1)
                       ("rust-io-extras" ,rust-io-extras-0.18)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-rustix" ,rust-rustix-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-winx" ,rust-winx-0.36))))
    (home-page "https://github.com/sunfishcode/char-device")
    (synopsis "Character Device I/O")
    (description "This package provides Character Device I/O.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-system-interface-0.27
  (package
    (name "rust-system-interface")
    (version "0.27.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "system-interface" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0ic7qxkgxh8hbphcawcz2xdnb5lmlirkhj4158f5466ffkv94ifc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-std" ,rust-async-std-1)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-cap-async-std" ,rust-cap-async-std-3)
                       ("rust-cap-fs-ext" ,rust-cap-fs-ext-3)
                       ("rust-cap-std" ,rust-cap-std-3)
                       ("rust-char-device" ,rust-char-device-0.16)
                       ("rust-fd-lock" ,rust-fd-lock-4)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-os-pipe" ,rust-os-pipe-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-socketpair" ,rust-socketpair-0.19)
                       ("rust-ssh2" ,rust-ssh2-0.9)
                       ("rust-windows-sys" ,rust-windows-sys-0.59)
                       ("rust-winx" ,rust-winx-0.36))))
    (home-page "https://github.com/bytecodealliance/system-interface")
    (synopsis "Extensions to the Rust standard library")
    (description
     "This package provides Extensions to the Rust standard library.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-time-ext-3
  (package
    (name "rust-cap-time-ext")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-time-ext" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0lzaz7c1gjxld1rrr8dvm91xwili6ky85ywm3555cgq3zhh6nwxx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ambient-authority" ,rust-ambient-authority-0.0.2)
                       ("rust-cap-primitives" ,rust-cap-primitives-3)
                       ("rust-cap-std" ,rust-cap-std-3)
                       ("rust-iana-time-zone" ,rust-iana-time-zone-0.1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-winx" ,rust-winx-0.36))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Extension traits for `SystemClock` and `MonotonicClock`")
    (description
     "This package provides Extension traits for `@code{SystemClock`} and `@code{MonotonicClock`}.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-rand-3
  (package
    (name "rust-cap-rand")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-rand" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0xvr0fj7x1qyj95pjdkbkzyix73r85p5qkk5mv8ndw4xnir378fy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ambient-authority" ,rust-ambient-authority-0.0.2)
                       ("rust-rand" ,rust-rand-0.8))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Capability-based random number generators")
    (description
     "This package provides Capability-based random number generators.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-net-ext-3
  (package
    (name "rust-cap-net-ext")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-net-ext" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1y5s4fgz7hrnbcxcwi1ly0n68cnlmgvdknhsxsyg4ah4lrs8dija"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cap-primitives" ,rust-cap-primitives-3)
                       ("rust-cap-std" ,rust-cap-std-3)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-smallvec" ,rust-smallvec-1))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Extension traits for `TcpListener`, `Pool`, etc")
    (description
     "This package provides Extension traits for `@code{TcpListener`}, `Pool`, etc.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-std-3
  (package
    (name "rust-cap-std")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-std" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "02anyab4z2dja2yl0y9g0gdiqa71d542c4mmnk6dd4yhx3ld7ny3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arf-strings" ,rust-arf-strings-0.7)
                       ("rust-camino" ,rust-camino-1)
                       ("rust-cap-primitives" ,rust-cap-primitives-3)
                       ("rust-io-extras" ,rust-io-extras-0.18)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-rustix" ,rust-rustix-0.38))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Capability-based version of the Rust standard library")
    (description
     "This package provides Capability-based version of the Rust standard library.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-winx-0.36
  (package
    (name "rust-winx")
    (version "0.36.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "winx" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0bgls70sd0lxyhbklbs6ccchx0r2bbz0rcmgwxibhn0ryxvd6grz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/sunfishcode/winx")
    (synopsis "Windows API helper library")
    (description "This package provides Windows API helper library.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-maybe-owned-0.3
  (package
    (name "rust-maybe-owned")
    (version "0.3.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "maybe-owned" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1d3sqiv59i06k73x6p7mf294zgdfb2qkky127ipfnjj9mr9wgb2g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rustonaut/maybe-owned")
    (synopsis
     "provides a `MaybeOwned` (and `MaybeOwnedMut`) type similar to std's `Cow` but it implements `From<T>` and `From<&'a T>` and does not require `ToOwned`")
    (description
     "This package provides provides a `@code{MaybeOwned`} (and `@code{MaybeOwnedMut`}) type similar to
std's `Cow` but it implements `From<T>` and `From<&'a T>` and does not require
`@code{ToOwned`}.")
    (license (list license:expat license:asl2.0))))

(define-public rust-ambient-authority-0.0.2
  (package
    (name "rust-ambient-authority")
    (version "0.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ambient-authority" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0fxsfyhy64jx7zrkb85h1vhr5nfqncja3pwpikid471d8w6yxm79"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/sunfishcode/ambient-authority")
    (synopsis "Ambient Authority")
    (description "This package provides Ambient Authority.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-primitives-3
  (package
    (name "rust-cap-primitives")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-primitives" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0sf3wffaw8mp0v0llg3i0rns0d8rhvsmf66cx2wdh8r2xnp5zhcg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ambient-authority" ,rust-ambient-authority-0.0.2)
                       ("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-fs-set-times" ,rust-fs-set-times-0.20)
                       ("rust-io-extras" ,rust-io-extras-0.18)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-ipnet" ,rust-ipnet-2)
                       ("rust-maybe-owned" ,rust-maybe-owned-0.3)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-windows-sys" ,rust-windows-sys-0.59)
                       ("rust-winx" ,rust-winx-0.36))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Capability-based primitives")
    (description "This package provides Capability-based primitives.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-async-std-3
  (package
    (name "rust-cap-async-std")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-async-std" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1j5v6vlsfhnwv90bb7dywwvm7lb6jmxl6fddipmxd49wv3a8sbrd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arf-strings" ,rust-arf-strings-0.7)
                       ("rust-async-std" ,rust-async-std-1)
                       ("rust-camino" ,rust-camino-1)
                       ("rust-cap-primitives" ,rust-cap-primitives-3)
                       ("rust-io-extras" ,rust-io-extras-0.18)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-rustix" ,rust-rustix-0.38))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Capability-based version of async-std")
    (description
     "This package provides Capability-based version of async-std.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-linux-raw-sys-0.9
  (package
    (name "rust-linux-raw-sys")
    (version "0.9.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "linux-raw-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "04zl7j4k1kgbn7rrl3i7yszaglgxp0c8dbwx8f1cabnjjwhb2zgy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/sunfishcode/linux-raw-sys")
    (synopsis "Generated bindings for Linux's userspace API")
    (description
     "This package provides Generated bindings for Linux's userspace API.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-rustix-1
  (package
    (name "rust-rustix")
    (version "1.0.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rustix" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "15kyccykzx7spxxxx5n39v592bdvzns91cf3xhlqvb4n55aihsp5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-errno" ,rust-errno-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-linux-raw-sys" ,rust-linux-raw-sys-0.9)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/bytecodealliance/rustix")
    (synopsis "Safe Rust bindings to POSIX/Unix/Linux/Winsock-like syscalls")
    (description
     "This package provides Safe Rust bindings to POSIX/Unix/Linux/Winsock-like syscalls.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-arf-strings-0.7
  (package
    (name "rust-arf-strings")
    (version "0.7.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "arf-strings" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1fdqcyss12hyk34wd6v2gsfrwxdclk7ddmyk9f2hb47345mv6f08"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustix" ,rust-rustix-1))))
    (home-page "https://github.com/bytecodealliance/arf-strings")
    (synopsis "Encoding and decoding for ARF strings")
    (description
     "This package provides Encoding and decoding for ARF strings.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-cap-fs-ext-3
  (package
    (name "rust-cap-fs-ext")
    (version "3.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cap-fs-ext" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1qfj0qw9zflg49ggl7zrr79445qra6g52szkq1whv63qfgfyyy3z"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arf-strings" ,rust-arf-strings-0.7)
                       ("rust-async-std" ,rust-async-std-1)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-camino" ,rust-camino-1)
                       ("rust-cap-async-std" ,rust-cap-async-std-3)
                       ("rust-cap-primitives" ,rust-cap-primitives-3)
                       ("rust-cap-std" ,rust-cap-std-3)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/bytecodealliance/cap-std")
    (synopsis "Extension traits for `Dir`, `File`, etc")
    (description
     "This package provides Extension traits for `Dir`, `File`, etc.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-wasmtime-wasi-29
  (package
    (name "rust-wasmtime-wasi")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-wasi" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "190cgq4k8r6nwxhv1f91isf2p6dbjnb1yyma9p3xl6xbzjdyc6wd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-cap-fs-ext" ,rust-cap-fs-ext-3)
                       ("rust-cap-net-ext" ,rust-cap-net-ext-3)
                       ("rust-cap-rand" ,rust-cap-rand-3)
                       ("rust-cap-std" ,rust-cap-std-3)
                       ("rust-cap-time-ext" ,rust-cap-time-ext-3)
                       ("rust-fs-set-times" ,rust-fs-set-times-0.20)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-io-extras" ,rust-io-extras-0.18)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-2)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-system-interface" ,rust-system-interface-0.27)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-trait-variant" ,rust-trait-variant-0.1)
                       ("rust-url" ,rust-url-2)
                       ("rust-wasmtime" ,rust-wasmtime-29)
                       ("rust-wiggle" ,rust-wiggle-29)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "WASI implementation in Rust")
    (description "This package provides WASI implementation in Rust.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-wmemcheck-29
  (package
    (name "rust-wasmtime-wmemcheck")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-wmemcheck" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0xr8c79cvb4hkwpy9pj8vfwmv8y1nb9qfxnqx2ahcg7fbrn8z617"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Memcheck implementation for Wasmtime")
    (description "This package provides Memcheck implementation for Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-winch-codegen-29
  (package
    (name "rust-winch-codegen")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "winch-codegen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1745a92ni167lczz20rc5vjld613m9x4id7l1aib0v7lqpr9x11g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cranelift-codegen" ,rust-cranelift-codegen-0.116)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-regalloc2" ,rust-regalloc2-0.11)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wasmparser" ,rust-wasmparser-0.221)
                       ("rust-wasmtime-cranelift" ,rust-wasmtime-cranelift-29)
                       ("rust-wasmtime-environ" ,rust-wasmtime-environ-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Winch code generation library")
    (description "This package provides Winch code generation library.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-winch-29
  (package
    (name "rust-wasmtime-winch")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-winch" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13yg8dx7nf37fp6syyj8i2cyaak8sgmbk4hhv3hxa0h5yawbzfpx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cranelift-codegen" ,rust-cranelift-codegen-0.116)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-object" ,rust-object-0.36)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13)
                       ("rust-wasmparser" ,rust-wasmparser-0.221)
                       ("rust-wasmtime-cranelift" ,rust-wasmtime-cranelift-29)
                       ("rust-wasmtime-environ" ,rust-wasmtime-environ-29)
                       ("rust-winch-codegen" ,rust-winch-codegen-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Integration between Wasmtime and Winch")
    (description
     "This package provides Integration between Wasmtime and Winch.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-slab-29
  (package
    (name "rust-wasmtime-slab")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-slab" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1kswbqx53kcnsgd78nnvafh2jxydsnrqn5bvphaaq17sjqd85dgw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Uni-typed slab with a free list for use in Wasmtime")
    (description
     "This package provides Uni-typed slab with a free list for use in Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-jit-icache-coherence-29
  (package
    (name "rust-wasmtime-jit-icache-coherence")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-jit-icache-coherence" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1la7aw71kavh11d9k9nig7nbv2pd9xq72c99wp1fd4hnw198appc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Utilities for JIT icache maintenance")
    (description "This package provides Utilities for JIT icache maintenance.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-jit-debug-29
  (package
    (name "rust-wasmtime-jit-debug")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-jit-debug" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0spmc3laaava7a0bx8qryjnfq2kcqc3yfbf2r0shrq2yi9462yry"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-object" ,rust-object-0.36)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-wasmtime-versioned-export-macros" ,rust-wasmtime-versioned-export-macros-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "JIT debug interfaces support for Wasmtime")
    (description
     "This package provides JIT debug interfaces support for Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-fiber-29
  (package
    (name "rust-wasmtime-fiber")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-fiber" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "05qis8ry2z3mqkw2hlpz3yz1g9ih0xjqa10rj751n24z27a91fnc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-wasmtime-asm-macros" ,rust-wasmtime-asm-macros-29)
                       ("rust-wasmtime-versioned-export-macros" ,rust-wasmtime-versioned-export-macros-29)
                       ("rust-wasmtime-versioned-export-macros" ,rust-wasmtime-versioned-export-macros-29)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Fiber support for Wasmtime")
    (description "This package provides Fiber support for Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-versioned-export-macros-29
  (package
    (name "rust-wasmtime-versioned-export-macros")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-versioned-export-macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0nvvm5xh6yclnf7511cnvzfi79l710lwhh6yc8229h3d47dqdzw6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Macros for defining versioned exports in Wasmtime")
    (description
     "This package provides Macros for defining versioned exports in Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmprinter-0.221
  (package
    (name "rust-wasmprinter")
    (version "0.221.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmprinter" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "10xjs2bzvppwr4qdsgfqqmafjah9290bd0gz35w6r4pjjwmc8hvk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-termcolor" ,rust-termcolor-1)
                       ("rust-wasmparser" ,rust-wasmparser-0.221))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasmprinter")
    (synopsis
     "Rust converter from the WebAssembly binary format to the text format.")
    (description
     "This package provides Rust converter from the @code{WebAssembly} binary format to the text format.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-afl-0.15
  (package
    (name "rust-afl")
    (version "0.15.17")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "afl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "18k2y2kz60bj3xk5zzv1cg5nn0wnl2h75q1y6mszrjx5gbijz9c7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-home" ,rust-home-0.5)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-rustc-version" ,rust-rustc-version-0.4)
                       ("rust-xdg" ,rust-xdg-2))))
    (home-page "https://github.com/rust-fuzz/afl.rs")
    (synopsis "Fuzzing Rust code with american-fuzzy-lop")
    (description
     "This package provides Fuzzing Rust code with american-fuzzy-lop.")
    (license license:asl2.0)))

(define-public rust-cpp-demangle-0.4
  (package
    (name "rust-cpp-demangle")
    (version "0.4.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cpp_demangle" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0z8c656jiwphnw1brkb0whm4kgh39h1msvgig2wc44yi58s8vrcn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-afl" ,rust-afl-0.15)
                       ("rust-cfg-if" ,rust-cfg-if-1))))
    (home-page "https://github.com/gimli-rs/cpp_demangle")
    (synopsis "crate for demangling C++ symbols")
    (description "This package provides a crate for demangling C++ symbols.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasmtime-environ-29
  (package
    (name "rust-wasmtime-environ")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-environ" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1bclk4g44v8bcqf9fik9njsjdxqhk290iw54fsi7ld4pf2pw3bfd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cpp-demangle" ,rust-cpp-demangle-0.4)
                       ("rust-cranelift-bitset" ,rust-cranelift-bitset-0.116)
                       ("rust-cranelift-entity" ,rust-cranelift-entity-0.116)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-object" ,rust-object-0.36)
                       ("rust-postcard" ,rust-postcard-1)
                       ("rust-rustc-demangle" ,rust-rustc-demangle-0.1)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13)
                       ("rust-wasm-encoder" ,rust-wasm-encoder-0.221)
                       ("rust-wasmparser" ,rust-wasmparser-0.221)
                       ("rust-wasmprinter" ,rust-wasmprinter-0.221)
                       ("rust-wasmtime-component-util" ,rust-wasmtime-component-util-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis
     "Standalone environment support for WebAssembly code in Cranelift")
    (description
     "This package provides Standalone environment support for @code{WebAssembly} code in Cranelift.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-native-0.116
  (package
    (name "rust-cranelift-native")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-native" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ivna3w02yxa1hs2kkcv6xj8gs8g6mgcrwbpj6x4qb0z7wpyipmq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cranelift-codegen" ,rust-cranelift-codegen-0.116)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Support for targeting the host with Cranelift")
    (description
     "This package provides Support for targeting the host with Cranelift.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-frontend-0.116
  (package
    (name "rust-cranelift-frontend")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-frontend" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0msd90p3p5hs1bl687hf21k2h1zv60vrw32b2y9p6419czhl3b2g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cranelift-codegen" ,rust-cranelift-codegen-0.116)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Cranelift IR builder helper")
    (description "This package provides Cranelift IR builder helper.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-souper-ir-2
  (package
    (name "rust-souper-ir")
    (version "2.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "souper-ir" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0i60q84w5k3rd0j3zhsdc5xasrd4wrkamyrs01rik3lq6g71h355"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-id-arena" ,rust-id-arena-2))))
    (home-page "https://github.com/fitzgen/souper-ir")
    (synopsis "library for manipulating Souper IR")
    (description "This package provides a library for manipulating Souper IR.")
    (license (list license:expat license:asl2.0))))

(define-public rust-regalloc2-0.11
  (package
    (name "rust-regalloc2")
    (version "0.11.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "regalloc2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1lsqc68kbbj8j76v6a0x5icjvi7ybwf6m9waz2q0zwhlgqk1qp0l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-allocator-api2" ,rust-allocator-api2-0.2)
                       ("rust-bumpalo" ,rust-bumpalo-3)
                       ("rust-hashbrown" ,rust-hashbrown-0.15)
                       ("rust-libfuzzer-sys" ,rust-libfuzzer-sys-0.4)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-rustc-hash" ,rust-rustc-hash-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-smallvec" ,rust-smallvec-1))))
    (home-page "https://github.com/bytecodealliance/regalloc2")
    (synopsis "Backtracking register allocator inspired from IonMonkey")
    (description
     "This package provides Backtracking register allocator inspired from @code{IonMonkey}.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-isle-0.116
  (package
    (name "rust-cranelift-isle")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-isle" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0kclhdj14l7av24k2h2hlrm4vkza5pyfzabj196h8w2hdrbhv8hw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-codespan-reporting" ,rust-codespan-reporting-0.11)
                       ("rust-log" ,rust-log-0.4))))
    (home-page
     "https://github.com/bytecodealliance/wasmtime/tree/main/cranelift/isle")
    (synopsis
     "ISLE: Instruction Selection and Lowering Expressions. A domain-specific language for instruction selection in Cranelift")
    (description
     "This package provides ISLE: Instruction Selection and Lowering Expressions.  A domain-specific
language for instruction selection in Cranelift.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-control-0.116
  (package
    (name "rust-cranelift-control")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-control" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1vymgmnqqnmirvkyqraah03hgnjr2wbzqaj7cfali2mxs3335l96"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "White-box fuzz testing framework")
    (description "This package provides White-box fuzz testing framework.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-codegen-shared-0.116
  (package
    (name "rust-cranelift-codegen-shared")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-codegen-shared" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1src5xxbh4va2g0f1n5lgcfyrqhsk20589ccx1668bspjxa0y620"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis
     "For code shared between cranelift-codegen-meta and cranelift-codegen")
    (description
     "This package provides For code shared between cranelift-codegen-meta and cranelift-codegen.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-codegen-meta-0.116
  (package
    (name "rust-cranelift-codegen-meta")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-codegen-meta" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1f70xrardmbpvfij1djkavllzrlxy9wi6jkzh9bzq9qvqrqvq169"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cranelift-codegen-shared" ,rust-cranelift-codegen-shared-0.116)
                       ("rust-pulley-interpreter" ,rust-pulley-interpreter-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Metaprogram for cranelift-codegen code generator library")
    (description
     "This package provides Metaprogram for cranelift-codegen code generator library.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-entity-0.116
  (package
    (name "rust-cranelift-entity")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-entity" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "08xk00xzncxycxm0z1g6daysq2g0qs503pbryvxp8m1732b0sbab"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cranelift-bitset" ,rust-cranelift-bitset-0.116)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Data structures using entity references as mapping keys")
    (description
     "This package provides Data structures using entity references as mapping keys.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-bforest-0.116
  (package
    (name "rust-cranelift-bforest")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-bforest" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1i13rpcpzi2b26nf1fajf2jcvmpzjgv8rmlav3m3djw6rsh08pg1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cranelift-entity" ,rust-cranelift-entity-0.116))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "forest of B+-trees")
    (description "This package provides a forest of B+-trees.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-capstone-sys-0.16
  (package
    (name "rust-capstone-sys")
    (version "0.16.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "capstone-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1qshi53z72yciyqskswyll6i9q40yjxf90347b3bgzqi2wkq6wgy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.59)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-regex" ,rust-regex-1))))
    (home-page
     "https://github.com/capstone-rust/capstone-rs/tree/master/capstone-sys")
    (synopsis "System bindings to the capstone disassembly library")
    (description
     "This package provides System bindings to the capstone disassembly library.")
    (license license:expat)))

(define-public rust-capstone-0.12
  (package
    (name "rust-capstone")
    (version "0.12.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "capstone" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0v2vfzpibdbbabi7nzqrbxn2i5p0a7m8hbhcdchjnnjqv4wa935h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-capstone-sys" ,rust-capstone-sys-0.16)
                       ("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/capstone-rust/capstone-rs")
    (synopsis
     "High level bindings to capstone disassembly engine (https://capstone-engine.org/)")
    (description
     "This package provides High level bindings to capstone disassembly engine
(https://capstone-engine.org/).")
    (license license:expat)))

(define-public rust-cranelift-codegen-0.116
  (package
    (name "rust-cranelift-codegen")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-codegen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0kihpw7gaj9wx4rw2x9lkn0x3nkcy93vn5pm3hvmh9dl9hn068ic"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-bumpalo" ,rust-bumpalo-3)
                       ("rust-capstone" ,rust-capstone-0.12)
                       ("rust-cranelift-bforest" ,rust-cranelift-bforest-0.116)
                       ("rust-cranelift-bitset" ,rust-cranelift-bitset-0.116)
                       ("rust-cranelift-codegen-meta" ,rust-cranelift-codegen-meta-0.116)
                       ("rust-cranelift-codegen-shared" ,rust-cranelift-codegen-shared-0.116)
                       ("rust-cranelift-control" ,rust-cranelift-control-0.116)
                       ("rust-cranelift-entity" ,rust-cranelift-entity-0.116)
                       ("rust-cranelift-isle" ,rust-cranelift-isle-0.116)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-postcard" ,rust-postcard-1)
                       ("rust-pulley-interpreter" ,rust-pulley-interpreter-29)
                       ("rust-regalloc2" ,rust-regalloc2-0.11)
                       ("rust-rustc-hash" ,rust-rustc-hash-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-souper-ir" ,rust-souper-ir-2)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Low-level code generator library")
    (description "This package provides Low-level code generator library.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-cranelift-29
  (package
    (name "rust-wasmtime-cranelift")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-cranelift" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "11wyks7pdzshspw6ks5k5z45r28ngm6vrg0g559z2jsdcwiffsrn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-cranelift-codegen" ,rust-cranelift-codegen-0.116)
                       ("rust-cranelift-control" ,rust-cranelift-control-0.116)
                       ("rust-cranelift-entity" ,rust-cranelift-entity-0.116)
                       ("rust-cranelift-frontend" ,rust-cranelift-frontend-0.116)
                       ("rust-cranelift-native" ,rust-cranelift-native-0.116)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-itertools" ,rust-itertools-0.12)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-object" ,rust-object-0.36)
                       ("rust-pulley-interpreter" ,rust-pulley-interpreter-29)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wasmparser" ,rust-wasmparser-0.221)
                       ("rust-wasmtime-environ" ,rust-wasmtime-environ-29)
                       ("rust-wasmtime-versioned-export-macros" ,rust-wasmtime-versioned-export-macros-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Integration between Cranelift and Wasmtime")
    (description
     "This package provides Integration between Cranelift and Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-wit-bindgen-29
  (package
    (name "rust-wasmtime-wit-bindgen")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-wit-bindgen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1rh6ds0kcslrwks8k7rz6hand5c4myjx7if1wdwxpr6i5nf32n43"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-heck" ,rust-heck-0.5)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-wit-parser" ,rust-wit-parser-0.221))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Internal `*.wit` support for the `wasmtime` crate's macros")
    (description
     "This package provides Internal `*.wit` support for the `wasmtime` crate's macros.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-component-util-29
  (package
    (name "rust-wasmtime-component-util")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-component-util" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0vh5dzz2nn7clnbdy5igd07nm3igbgxy5krhdcv5maqjq6rwfzbh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis
     "Utility types and functions to support the component model in Wasmtime")
    (description
     "This package provides Utility types and functions to support the component model in Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-component-macro-29
  (package
    (name "rust-wasmtime-component-macro")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-component-macro" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1byzawnz8myzmlwbc0g5y415sk9h5ac464pp0akd0ifr5rcyckfp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-wasmtime-component-util" ,rust-wasmtime-component-util-29)
                       ("rust-wasmtime-wit-bindgen" ,rust-wasmtime-wit-bindgen-29)
                       ("rust-wit-parser" ,rust-wit-parser-0.221))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Macros for deriving component interface types from Rust types")
    (description
     "This package provides Macros for deriving component interface types from Rust types.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-cache-29
  (package
    (name "rust-wasmtime-cache")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-cache" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1z2gw8phnwchqdxh0ihxr3qikh6xrq6c92rm0zmdx018yv4624cb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-base64" ,rust-base64-0.21)
                       ("rust-directories-next" ,rust-directories-next-2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-postcard" ,rust-postcard-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-toml" ,rust-toml-0.8)
                       ("rust-windows-sys" ,rust-windows-sys-0.59)
                       ("rust-zstd" ,rust-zstd-0.13))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Support for automatic module caching with Wasmtime")
    (description
     "This package provides Support for automatic module caching with Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmtime-asm-macros-29
  (package
    (name "rust-wasmtime-asm-macros")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-asm-macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1wk4rwn8085nllba4nz4z68ihl9ypm4zisjvyzlzn0aj286qn5qz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Macros for defining asm functions in Wasmtime")
    (description
     "This package provides Macros for defining asm functions in Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-wasmparser-0.227
  (package
    (name "rust-wasmparser")
    (version "0.227.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmparser" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ckqsv60i08fyhds7vaxgcwqhwzv5p3ckk4vmdhr8g7vfkbwll8g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-hashbrown" ,rust-hashbrown-0.15)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasmparser")
    (synopsis
     "simple event-driven library for parsing WebAssembly binary files.")
    (description
     "This package provides a simple event-driven library for parsing
@code{WebAssembly} binary files.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-wasm-encoder-0.227
  (package
    (name "rust-wasm-encoder")
    (version "0.227.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-encoder" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "08kqd9lmpncf10p9y60lq7wani217l7ppcj36hc0ggvz5vq75fw0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-leb128fmt" ,rust-leb128fmt-0.1)
                       ("rust-wasmparser" ,rust-wasmparser-0.227))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasm-encoder")
    (synopsis "low-level WebAssembly encoder.")
    (description
     "This package provides a low-level @code{WebAssembly} encoder.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-leb128fmt-0.1
  (package
    (name "rust-leb128fmt")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "leb128fmt" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1chxm1484a0bly6anh6bd7a99sn355ymlagnwj3yajafnpldkv89"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/bluk/leb128fmt")
    (synopsis "library to encode and decode LEB128 compressed integers.")
    (description
     "This package provides a library to encode and decode LEB128 compressed integers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wast-227
  (package
    (name "rust-wast")
    (version "227.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wast" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "05i83gy4vhr55hqqclj1g18law4qabsb1fd3glk9sv5i8984xhc5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bumpalo" ,rust-bumpalo-3)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-leb128fmt" ,rust-leb128fmt-0.1)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-unicode-width" ,rust-unicode-width-0.2)
                       ("rust-wasm-encoder" ,rust-wasm-encoder-0.227))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wast")
    (synopsis
     "Customizable Rust parsers for the WebAssembly Text formats WAT and WAST")
    (description
     "This package provides Customizable Rust parsers for the @code{WebAssembly} Text formats WAT and WAST.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-wat-1
  (package
    (name "rust-wat")
    (version "1.227.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wat" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1k79jhlk0a9xsdgdzsv53rh7dbzi23583m1q6gv6y07ppvar9lxk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-wast" ,rust-wast-227))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wat")
    (synopsis "Rust parser for the WebAssembly Text format, WAT")
    (description
     "This package provides Rust parser for the @code{WebAssembly} Text format, WAT.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-id-arena-2
  (package
    (name "rust-id-arena")
    (version "2.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "id-arena" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "01ch8jhpgnih8sawqs44fqsqpc7bzwgy0xpi6j0f4j0i5mkvr8i5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rayon" ,rust-rayon-1))))
    (home-page "https://github.com/fitzgen/id-arena")
    (synopsis "simple, id-based arena.")
    (description "This package provides a simple, id-based arena.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wit-parser-0.221
  (package
    (name "rust-wit-parser")
    (version "0.221.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wit-parser" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1b5j2vpiww0crqavaijw4vv1y41darpd38q7id9llsymkrbi4qc9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-id-arena" ,rust-id-arena-2)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-unicode-xid" ,rust-unicode-xid-0.2)
                       ("rust-wasmparser" ,rust-wasmparser-0.221)
                       ("rust-wat" ,rust-wat-1))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wit-parser")
    (synopsis
     "Tooling for parsing `*.wit` files and working with their contents.")
    (description
     "This package provides Tooling for parsing `*.wit` files and working with their contents.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-logos-codegen-0.14
  (package
    (name "rust-logos-codegen")
    (version "0.14.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "logos-codegen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0gwnx7lk4y7xc4yk6pr0knrddard5z22rxaz9xrnc38cc1lh1y2r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-beef" ,rust-beef-0.5)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-regex-syntax" ,rust-regex-syntax-0.8)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://logos.maciej.codes/")
    (synopsis "Create ridiculously fast Lexers")
    (description "This package provides Create ridiculously fast Lexers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-logos-derive-0.14
  (package
    (name "rust-logos-derive")
    (version "0.14.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "logos-derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "07bk3q4jry9f8blrnsiy872ivilzy62xaglnn2ni5p590qmp5yr4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-logos-codegen" ,rust-logos-codegen-0.14))))
    (home-page "https://logos.maciej.codes/")
    (synopsis "Create ridiculously fast Lexers")
    (description "This package provides Create ridiculously fast Lexers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-logos-0.14
  (package
    (name "rust-logos")
    (version "0.14.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "logos" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0n349vin9mx326fkz68bsa4vc5sdn9n8qnfz7n1yqynbz1p3albj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-logos-derive" ,rust-logos-derive-0.14))))
    (home-page "https://logos.maciej.codes/")
    (synopsis "Create ridiculously fast Lexers")
    (description "This package provides Create ridiculously fast Lexers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasm-wave-0.221
  (package
    (name "rust-wasm-wave")
    (version "0.221.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-wave" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ysjy5gp0yflbmlly1scdfpd4m99m2gwc8pzppsyrkinpla86i1w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-logos" ,rust-logos-0.14)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wit-parser" ,rust-wit-parser-0.221))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasm-wave")
    (synopsis "WebAssembly Value Encoding")
    (description "This package provides @code{WebAssembly} Value Encoding.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-wasmparser-0.221
  (package
    (name "rust-wasmparser")
    (version "0.221.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmparser" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "11ficyz79dcypkxxg1c8vl8bm0avg8a80csnxq6vxhismcvglsyh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-hashbrown" ,rust-hashbrown-0.15)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasmparser")
    (synopsis
     "simple event-driven library for parsing WebAssembly binary files.")
    (description
     "This package provides a simple event-driven library for parsing
@code{WebAssembly} binary files.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-wasm-encoder-0.221
  (package
    (name "rust-wasm-encoder")
    (version "0.221.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-encoder" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1r9jv84kbjf6z18rgf3666vvcn5fybzn9daszsj81pi097z4916w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-leb128" ,rust-leb128-0.2)
                       ("rust-wasmparser" ,rust-wasmparser-0.221))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasm-encoder")
    (synopsis "low-level WebAssembly encoder.")
    (description
     "This package provides a low-level @code{WebAssembly} encoder.")
    (license (list license:asl2.0 unknown-license! license:asl2.0
                   license:expat))))

(define-public rust-trait-variant-0.1
  (package
    (name "rust-trait-variant")
    (version "0.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "trait-variant" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "19vpbnbcsxdiznwdw854pd0vya7rm7v7hnl3nh741621603pg5vh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/rust-lang/impl-trait-utils")
    (synopsis "Utilities for working with impl traits in Rust")
    (description
     "This package provides Utilities for working with impl traits in Rust.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasmtime-math-29
  (package
    (name "rust-wasmtime-math")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime-math" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "05yy3npnfk6h199bvibjm00yqf8g12pysp30ai6hzq15mb10w899"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libm" ,rust-libm-0.2))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Low-level math routines used in Wasmtime")
    (description
     "This package provides Low-level math routines used in Wasmtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-cranelift-bitset-0.116
  (package
    (name "rust-cranelift-bitset")
    (version "0.116.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cranelift-bitset" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0d4zvspdxpw8jl1q2zm8n1jrxg6kqmkphjr4rrcp49nflxlkjvkw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "Various bitset stuff for use inside Cranelift")
    (description
     "This package provides Various bitset stuff for use inside Cranelift.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-pulley-interpreter-29
  (package
    (name "rust-pulley-interpreter")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "pulley-interpreter" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0pg7rvnqkj47vz91zyqh0b1rvkw8m14jy64qhdqa4jfzfn2mznb2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-cranelift-bitset" ,rust-cranelift-bitset-0.116)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-sptr" ,rust-sptr-0.3)
                       ("rust-wasmtime-math" ,rust-wasmtime-math-29))))
    (home-page "https://github.com/bytecodealliance/wasmtime/tree/main/pulley")
    (synopsis
     "The Pulley interpreter, its bytecode definition, encoder, decoder, and etc..")
    (description
     "This package provides The Pulley interpreter, its bytecode definition, encoder, decoder, and etc...")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-psm-0.1
  (package
    (name "rust-psm")
    (version "0.1.25")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "psm" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "125y7h40mkwb64j4v2v7s6f69ilk745kg60w1s2cq62cw8im93pm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1))))
    (home-page "https://github.com/rust-lang/stacker/")
    (synopsis
     "Portable Stack Manipulation: stack manipulation and introspection routines")
    (description
     "This package provides Portable Stack Manipulation: stack manipulation and introspection routines.")
    (license (list license:expat license:asl2.0))))

(define-public rust-memfd-0.6
  (package
    (name "rust-memfd")
    (version "0.6.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "memfd" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0r5cm3wzyr1x7768h3hns77b494qbz0g05cb9wgpjvrcsm5gmkxj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustix" ,rust-rustix-0.38))))
    (home-page "https://github.com/lucab/memfd-rs")
    (synopsis "pure-Rust library to work with Linux memfd and sealing")
    (description
     "This package provides a pure-Rust library to work with Linux memfd and sealing.")
    (license (list license:expat license:asl2.0))))

(define-public rust-ittapi-sys-0.4
  (package
    (name "rust-ittapi-sys")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ittapi-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1z7lgc7gwlhcvkdk6bg9sf1ww4w0b41blp90hv4a4kq6ji9kixaj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1))))
    (home-page "https://github.com/intel/ittapi/tree/master/rust/ittapi-sys")
    (synopsis "Rust bindings for ittapi")
    (description "This package provides Rust bindings for ittapi.")
    (license (list license:gpl2 license:bsd-3))))

(define-public rust-ittapi-0.4
  (package
    (name "rust-ittapi")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ittapi" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1cb41dapbximlma0vnar144m2j2km44g8g6zmv6ra4y42kk6z6bb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-ittapi-sys" ,rust-ittapi-sys-0.4)
                       ("rust-log" ,rust-log-0.4))))
    (home-page "https://github.com/intel/ittapi/tree/master/rust/ittapi")
    (synopsis "High-level Rust bindings for ittapi")
    (description "This package provides High-level Rust bindings for ittapi.")
    (license (list license:gpl2 license:bsd-3))))

(define-public rust-fxprof-processed-profile-0.6
  (package
    (name "rust-fxprof-processed-profile")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "fxprof-processed-profile" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ggsn3im2bfcnxic0jzk00qgiacfrg2as6i4d8kj87kzxl52rl97"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-debugid" ,rust-debugid-0.8)
                       ("rust-fxhash" ,rust-fxhash-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/mstange/samply/")
    (synopsis
     "Create profiles in the Firefox Profiler's processed profile JSON format")
    (description
     "This package provides Create profiles in the Firefox Profiler's processed profile JSON format.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasmtime-29
  (package
    (name "rust-wasmtime")
    (version "29.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasmtime" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0s8f05h19hnnhx2jmi7dr4m1kjbacpbxbih49hf6smbj0qjnm5qi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-addr2line" ,rust-addr2line-0.24)
                       ("rust-anyhow" ,rust-anyhow-1)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-bumpalo" ,rust-bumpalo-3)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-fxprof-processed-profile" ,rust-fxprof-processed-profile-0.6)
                       ("rust-gimli" ,rust-gimli-0.31)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-ittapi" ,rust-ittapi-0.4)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mach2" ,rust-mach2-0.4)
                       ("rust-memfd" ,rust-memfd-0.6)
                       ("rust-object" ,rust-object-0.36)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-paste" ,rust-paste-1)
                       ("rust-postcard" ,rust-postcard-1)
                       ("rust-psm" ,rust-psm-0.1)
                       ("rust-pulley-interpreter" ,rust-pulley-interpreter-29)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-sptr" ,rust-sptr-0.3)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.13)
                       ("rust-trait-variant" ,rust-trait-variant-0.1)
                       ("rust-wasm-encoder" ,rust-wasm-encoder-0.221)
                       ("rust-wasm-wave" ,rust-wasm-wave-0.221)
                       ("rust-wasmparser" ,rust-wasmparser-0.221)
                       ("rust-wasmtime-asm-macros" ,rust-wasmtime-asm-macros-29)
                       ("rust-wasmtime-cache" ,rust-wasmtime-cache-29)
                       ("rust-wasmtime-component-macro" ,rust-wasmtime-component-macro-29)
                       ("rust-wasmtime-component-util" ,rust-wasmtime-component-util-29)
                       ("rust-wasmtime-cranelift" ,rust-wasmtime-cranelift-29)
                       ("rust-wasmtime-environ" ,rust-wasmtime-environ-29)
                       ("rust-wasmtime-fiber" ,rust-wasmtime-fiber-29)
                       ("rust-wasmtime-jit-debug" ,rust-wasmtime-jit-debug-29)
                       ("rust-wasmtime-jit-icache-coherence" ,rust-wasmtime-jit-icache-coherence-29)
                       ("rust-wasmtime-math" ,rust-wasmtime-math-29)
                       ("rust-wasmtime-slab" ,rust-wasmtime-slab-29)
                       ("rust-wasmtime-versioned-export-macros" ,rust-wasmtime-versioned-export-macros-29)
                       ("rust-wasmtime-versioned-export-macros" ,rust-wasmtime-versioned-export-macros-29)
                       ("rust-wasmtime-winch" ,rust-wasmtime-winch-29)
                       ("rust-wasmtime-wmemcheck" ,rust-wasmtime-wmemcheck-29)
                       ("rust-wat" ,rust-wat-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/bytecodealliance/wasmtime")
    (synopsis "High-level API to expose the Wasmtime runtime")
    (description
     "This package provides High-level API to expose the Wasmtime runtime.")
    (license (list license:asl2.0 unknown-license!))))

(define-public rust-typetag-impl-0.1
  (package
    (name "rust-typetag-impl")
    (version "0.1.8")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "typetag-impl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "03lw15ad39bgr4m6fmr5b9lb4wapkcfsnfxsbz0362635iw4f0g6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/dtolnay/typetag")
    (synopsis "Implementation detail of the typetag crate")
    (description
     "This package provides Implementation detail of the typetag crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-typetag-0.1
  (package
    (name "rust-typetag")
    (version "0.1.8")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "typetag" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "12jva00k063gb48bvx0p0ixwbq1l48411disynzvah92bd65d020"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-erased-serde" ,rust-erased-serde-0.3)
                       ("rust-inventory" ,rust-inventory-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-typetag-impl" ,rust-typetag-impl-0.1))))
    (home-page "https://github.com/dtolnay/typetag")
    (synopsis "Serde serializable and deserializable trait objects")
    (description
     "This package provides Serde serializable and deserializable trait objects.")
    (license (list license:expat license:asl2.0))))

(define-public rust-sysinfo-0.22
  (package
    (name "rust-sysinfo")
    (version "0.22.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sysinfo" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0hsx8pl4yx4fkjx609pqhscklvhmr2ljqrhs8lr778h6ffqgl6vz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-ntapi" ,rust-ntapi-0.3)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/GuillaumeGomez/sysinfo")
    (synopsis
     "Library to get system information such as processes, CPUs, disks, components and networks")
    (description
     "This package provides Library to get system information such as processes, CPUs, disks, components and
networks.")
    (license license:expat)))

(define-public rust-sixel-tokenizer-0.1
  (package
    (name "rust-sixel-tokenizer")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sixel-tokenizer" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0xnlg3vfmh96bqj1fnj6qdgjdnl0zc6v07ww2xh4v5mc55k7y6xp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/zellij-org/sixel-tokenizer")
    (synopsis "tokenizer for serialized Sixel bytes")
    (description
     "This package provides a tokenizer for serialized Sixel bytes.")
    (license license:expat)))

(define-public rust-sixel-image-0.1
  (package
    (name "rust-sixel-image")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sixel-image" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "17y9yykj03i47adh0bqqra659m8rd68yxmmsp50pgf26l1fhp244"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sixel-tokenizer" ,rust-sixel-tokenizer-0.1))))
    (home-page "https://github.com/zellij-org/sixel-image")
    (synopsis
     "An interface for querying, manipulating and serializing/deserializing Sixel data")
    (description
     "This package provides An interface for querying, manipulating and serializing/deserializing Sixel
data.")
    (license license:expat)))

(define-public rust-highway-0.6
  (package
    (name "rust-highway")
    (version "0.6.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "highway" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0p9r4ss563gj44qamnrr5bqf0p9lb8gjc0w5jqmk3jlmyrlbjq9l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/nickbabcock/highway-rs")
    (synopsis
     "Native Rust port of Google's HighwayHash, which makes use of SIMD instructions for a fast and strong hash function")
    (description
     "This package provides Native Rust port of Google's @code{HighwayHash}, which makes use of SIMD
instructions for a fast and strong hash function.")
    (license license:expat)))

(define-public rust-zellij-server-0.42
  (package
    (name "rust-zellij-server")
    (version "0.42.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zellij-server" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1a0cmd552dks729b29f7mfxjlvc38p8g9shvmmxsqwsxy9qla3rf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ansi-term" ,rust-ansi-term-0.12)
                       ("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-base64" ,rust-base64-0.13)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-cassowary" ,rust-cassowary-0.3)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-close-fds" ,rust-close-fds-0.3)
                       ("rust-daemonize" ,rust-daemonize-0.5)
                       ("rust-highway" ,rust-highway-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-semver" ,rust-semver-0.11)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-sixel-image" ,rust-sixel-image-0.1)
                       ("rust-sixel-tokenizer" ,rust-sixel-tokenizer-0.1)
                       ("rust-sysinfo" ,rust-sysinfo-0.22)
                       ("rust-typetag" ,rust-typetag-0.1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-wasmtime" ,rust-wasmtime-29)
                       ("rust-wasmtime-wasi" ,rust-wasmtime-wasi-29)
                       ("rust-zellij-utils" ,rust-zellij-utils-0.42))))
    (home-page "")
    (synopsis "The server-side library for Zellij")
    (description "This package provides The server-side library for Zellij.")
    (license license:expat)))

(define-public rust-prost-types-0.11
  (package
    (name "rust-prost-types")
    (version "0.11.9")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "prost-types" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "04ryk38sqkp2nf4dgdqdfbgn6zwwvjraw6hqq6d9a6088shj4di1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-prost" ,rust-prost-0.11))))
    (home-page "https://github.com/tokio-rs/prost")
    (synopsis "Prost definitions of Protocol Buffers well known types")
    (description
     "This package provides Prost definitions of Protocol Buffers well known types.")
    (license license:asl2.0)))

(define-public rust-prost-build-0.11
  (package
    (name "rust-prost-build")
    (version "0.11.9")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "prost-build" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0w5jx97q96ydhkg67wx3lb11kfy8195c56g0476glzws5iak758i"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-heck" ,rust-heck-0.4)
                       ("rust-itertools" ,rust-itertools-0.10)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-multimap" ,rust-multimap-0.8)
                       ("rust-petgraph" ,rust-petgraph-0.6)
                       ("rust-prettyplease" ,rust-prettyplease-0.1)
                       ("rust-prost" ,rust-prost-0.11)
                       ("rust-prost-types" ,rust-prost-types-0.11)
                       ("rust-pulldown-cmark" ,rust-pulldown-cmark-0.9)
                       ("rust-pulldown-cmark-to-cmark" ,rust-pulldown-cmark-to-cmark-10)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-syn" ,rust-syn-1)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-which" ,rust-which-4))))
    (home-page "https://github.com/tokio-rs/prost")
    (synopsis
     "Generate Prost annotated Rust types from Protocol Buffers files")
    (description
     "This package provides Generate Prost annotated Rust types from Protocol Buffers files.")
    (license license:asl2.0)))

(define-public rust-file-id-0.1
  (package
    (name "rust-file-id")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "file-id" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1hx8zmiqpydj4b471nd1llj1jb8bmjxbwqmq1jy92bm8dhgfffz1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-winapi-util" ,rust-winapi-util-0.1))))
    (home-page "https://github.com/notify-rs/notify")
    (synopsis
     "Utility for reading inode numbers (Linux, MacOS) and file IDs (Windows)")
    (description
     "This package provides Utility for reading inode numbers (Linux, @code{MacOS}) and file IDs (Windows).")
    (license (list license:cc0 license:artistic2.0))))

(define-public rust-notify-debouncer-full-0.1
  (package
    (name "rust-notify-debouncer-full")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "notify-debouncer-full" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "06a2wsi514dhrq8q5ghsvkgwj7n0pliid5plipxpdrwvnhg2r0gl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-file-id" ,rust-file-id-0.1)
                       ("rust-notify" ,rust-notify-6)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-walkdir" ,rust-walkdir-2))))
    (home-page "https://github.com/notify-rs/notify")
    (synopsis "notify event debouncer optimized for ease of use")
    (description
     "This package provides notify event debouncer optimized for ease of use.")
    (license (list license:cc0 license:artistic2.0))))

(define-public rust-destructure-traitobject-0.2
  (package
    (name "rust-destructure-traitobject")
    (version "0.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "destructure_traitobject" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ir5x9f5zksr1fs788jy5g2hyyc2hnnx7kwi87wd451wd5apb1rw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page
     "https://github.com/philip-peterson/destructure_traitobject.git")
    (synopsis
     "Unsafe helpers for working with raw trait objects. (Forked from traitobject)")
    (description
     "This package provides Unsafe helpers for working with raw trait objects. (Forked from traitobject).")
    (license (list license:expat license:asl2.0))))

(define-public rust-unsafe-any-ors-1
  (package
    (name "rust-unsafe-any-ors")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "unsafe-any-ors" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1bf0hxfhb3gh9hy8pw6l0jaqjprzn9w1vnfph2b2sdk50v9h78z0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-destructure-traitobject" ,rust-destructure-traitobject-0.2))))
    (home-page "https://github.com/orphanage-rs/rust-unsafe-any")
    (synopsis "Traits and implementations for unchecked downcasting")
    (description
     "This package provides Traits and implementations for unchecked downcasting.")
    (license license:expat)))

(define-public rust-typemap-ors-1
  (package
    (name "rust-typemap-ors")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "typemap-ors" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0rw8lbbh8aarfacyz133p0pqq1gj96fypk2c3s7x2bgh0yvj9356"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-unsafe-any-ors" ,rust-unsafe-any-ors-1))))
    (home-page "https://github.com/orphanage-rs/rust-typemap")
    (synopsis "typesafe store for many value types.")
    (description
     "This package provides a typesafe store for many value types.")
    (license license:expat)))

(define-public rust-log-mdc-0.1
  (package
    (name "rust-log-mdc")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "log-mdc" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1iw1x3qhjvrac35spikn5h06a1rxd9vw216jk8h52jhz9i0j2kd9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/sfackler/rust-log-mdc")
    (synopsis "mapped diagnostic context (MDC) for use with the `log` crate")
    (description
     "This package provides a mapped diagnostic context (MDC) for use with the `log`
crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-log4rs-1
  (package
    (name "rust-log4rs")
    (version "1.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "log4rs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "19jck058vgb2k1jypknjcgpadq1ydrzb7sl4y8f3kl2vw5d165h8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-arc-swap" ,rust-arc-swap-1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-derivative" ,rust-derivative-2)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-humantime" ,rust-humantime-2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-log-mdc" ,rust-log-mdc-0.1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-value" ,rust-serde-value-0.7)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-yaml" ,rust-serde-yaml-0.9)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-thread-id" ,rust-thread-id-4)
                       ("rust-toml" ,rust-toml-0.8)
                       ("rust-typemap-ors" ,rust-typemap-ors-1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/estk/log4rs")
    (synopsis
     "highly configurable multi-output logging implementation for the `log` facade")
    (description
     "This package provides a highly configurable multi-output logging implementation
for the `log` facade.")
    (license (list license:expat license:asl2.0))))

(define-public rust-kdl-4
  (package
    (name "rust-kdl")
    (version "4.7.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "kdl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "05wimwqd2fh4a35fmx3k4lm3b973mv1chrld11hyfvwjqnb2wgp0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-miette" ,rust-miette-5)
                       ("rust-nom" ,rust-nom-7)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://kdl.dev")
    (synopsis
     "Document-oriented KDL parser and API. Allows formatting/whitespace/comment-preserving parsing and modification of KDL text")
    (description
     "This package provides Document-oriented KDL parser and API. Allows
formatting/whitespace/comment-preserving parsing and modification of KDL text.")
    (license license:asl2.0)))

(define-public rust-colorsys-0.6
  (package
    (name "rust-colorsys")
    (version "0.6.7")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "colorsys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1g8vwcv89n2dzi9bmbzqlj9cl9a89jz49668grbcncv4cjx1l9jl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/emgyrz/colorsys.rs")
    (synopsis
     "module for color conversion and mutation. Works with RGB(a)( as hexadecimal too), HSL(a), CMYK color models and with ANSI color codes")
    (description
     "This package provides a module for color conversion and mutation.  Works with
RGB(a)( as hexadecimal too), HSL(a), CMYK color models and with ANSI color
codes.")
    (license license:expat)))

(define-public rust-zellij-utils-0.42
  (package
    (name "rust-zellij-utils")
    (version "0.42.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zellij-utils" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1j5f5y1lhcmkdfcgfrjpg7yrsxjhwxx6wagajh5w2spnwvr63ka3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-async-channel" ,rust-async-channel-1)
                       ("rust-async-std" ,rust-async-std-1)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-clap" ,rust-clap-3)
                       ("rust-clap-complete" ,rust-clap-complete-3)
                       ("rust-colored" ,rust-colored-2)
                       ("rust-colorsys" ,rust-colorsys-0.6)
                       ("rust-crossbeam" ,rust-crossbeam-0.8)
                       ("rust-curl-sys" ,rust-curl-sys-0.4)
                       ("rust-directories" ,rust-directories-5)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-humantime" ,rust-humantime-2)
                       ("rust-include-dir" ,rust-include-dir-0.7)
                       ("rust-interprocess" ,rust-interprocess-1)
                       ("rust-isahc" ,rust-isahc-1)
                       ("rust-kdl" ,rust-kdl-4)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-log4rs" ,rust-log4rs-1)
                       ("rust-miette" ,rust-miette-5)
                       ("rust-nix" ,rust-nix-0.23)
                       ("rust-notify-debouncer-full" ,rust-notify-debouncer-full-0.1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-openssl-sys" ,rust-openssl-sys-0.9)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-prost" ,rust-prost-0.11)
                       ("rust-prost-build" ,rust-prost-build-0.11)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rmp-serde" ,rust-rmp-serde-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-shellexpand" ,rust-shellexpand-3)
                       ("rust-signal-hook" ,rust-signal-hook-0.3)
                       ("rust-strip-ansi-escapes" ,rust-strip-ansi-escapes-0.1)
                       ("rust-strum" ,rust-strum-0.20)
                       ("rust-strum-macros" ,rust-strum-macros-0.20)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-termwiz" ,rust-termwiz-0.22)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-vte" ,rust-vte-0.11))))
    (home-page "")
    (synopsis "utility library for Zellij client and server")
    (description
     "This package provides a utility library for Zellij client and server.")
    (license license:expat)))

(define-public rust-zellij-client-0.42
  (package
    (name "rust-zellij-client")
    (version "0.42.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zellij-client" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "017zgag7wxlq5rg2j4pm9crgkccjaal54psghsl2bpmc3f57r0hk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-mio" ,rust-mio-0.7)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-yaml" ,rust-serde-yaml-0.8)
                       ("rust-url" ,rust-url-2)
                       ("rust-zellij-utils" ,rust-zellij-utils-0.42))))
    (home-page "")
    (synopsis "The client-side library for Zellij")
    (description "This package provides The client-side library for Zellij.")
    (license license:expat)))

(define-public rust-lev-distance-0.1
  (package
    (name "rust-lev-distance")
    (version "0.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "lev_distance" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0pk26fp1fcjyg2ml8g5ma1jj2gvgnmmri4md8y3bqdjr46yx3nbj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/ken-matsui/lev_distance#readme")
    (synopsis "copy of Levenshtein distance implementation from Rust Compiler")
    (description
     "This package provides a copy of Levenshtein distance implementation from Rust
Compiler.")
    (license license:expat)))

(define-public rust-suggest-0.4
  (package
    (name "rust-suggest")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "suggest" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0nb6axl4i58g7k0q3p3bg6m363aw6qnqdg31y5c8b43x6bbd0n15"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap" ,rust-clap-3)
                       ("rust-lev-distance" ,rust-lev-distance-0.1))))
    (home-page "https://github.com/ken-matsui/suggest#readme")
    (synopsis
     "minimal library to provide similar name suggestions like \"Did you mean?\"")
    (description
     "This package provides a minimal library to provide similar name suggestions like
\"Did you mean?\".")
    (license license:expat)))

(define-public rust-names-0.14
  (package
    (name "rust-names")
    (version "0.14.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "names" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1g1rxifcsvj9zj2nmwbdix8b5ynpghs4rq40vs966jqlylxwvpbv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap" ,rust-clap-3)
                       ("rust-rand" ,rust-rand-0.8))))
    (home-page "https://github.com/fnichol/names")
    (synopsis "random name generator with names suitable for use in container
instances, project names, application instances, etc.")
    (description
     "This package provides a random name generator with names suitable for use in
container instances, project names, application instances, etc.")
    (license license:expat)))

(define-public rust-zellij-0.42
  (package
    (name "rust-zellij")
    (version "0.42.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zellij" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0agc53zxpcifjqpfa7gr6sgyml5v0vx7wrkfl2p3clxf0069r9rl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-dialoguer" ,rust-dialoguer-0.10)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-names" ,rust-names-0.14)
                       ("rust-suggest" ,rust-suggest-0.4)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-zellij-client" ,rust-zellij-client-0.42)
                       ("rust-zellij-server" ,rust-zellij-server-0.42)
                       ("rust-zellij-utils" ,rust-zellij-utils-0.42))
       #:cargo-development-inputs (("rust-insta" ,rust-insta-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-regex" ,rust-regex-1)
                                   ("rust-ssh2" ,rust-ssh2-0.9))))
    (home-page "https://zellij.dev")
    (synopsis "terminal workspace with batteries included")
    (description
     "This package provides a terminal workspace with batteries included.")
    (license license:expat)))

