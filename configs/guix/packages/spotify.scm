(define-module (packages spotify)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-web)
  #:use-module (gnu packages crates-crypto)
  #:use-module (gnu packages crates-audio)
  #:use-module (gnu packages crates-windows)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages crates-check)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-apple)
  #:use-module (gnu packages crates-compression)
  #:use-module (gnu packages crates-tls)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages pkg-config)
  #:use-module ((guix licenses) #:prefix license:))

(define-public rust-multimap-0.10
  (package
    (name "rust-multimap")
    (version "0.10.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "multimap" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "00vs2frqdhrr8iqx4y3fbq73ax5l12837fvbjrpi729d85alrz6y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/havarnov/multimap")
    (synopsis "multimap implementation.")
    (description "This package provides a multimap implementation.")
    (license (list license:expat license:asl2.0))))

(define-public rust-if-addrs-0.12
  (package
    (name "rust-if-addrs")
    (version "0.12.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "if-addrs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1j0c5xzzbfcb3k97zb050cygikfxv47mpj1hlyyyr249qglk6amv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-windows-sys" ,rust-windows-sys-0.52))))
    (home-page "https://github.com/messense/if-addrs")
    (synopsis "Return interface IP addresses on Posix and windows systems")
    (description
     "This package provides Return interface IP addresses on Posix and windows systems.")
    (license (list license:expat license:bsd-3))))

(define-public rust-libmdns-0.9
  (package
    (name "rust-libmdns")
    (version "0.9.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "libmdns" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0qjq77vbmpspq943z686kfrb1jjz6vicws8v8cri848vw6cld1a8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-hostname" ,rust-hostname-0.4)
                       ("rust-if-addrs" ,rust-if-addrs-0.12)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-multimap" ,rust-multimap-0.10)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-socket2" ,rust-socket2-0.5)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/librespot-org/libmdns")
    (synopsis
     "mDNS Responder library for building discoverable LAN services in Rust")
    (description
     "This package provides @code{mDNS} Responder library for building discoverable LAN services in Rust.")
    (license license:expat)))

(define-public rust-librespot-discovery-0.6
  (package
    (name "rust-librespot-discovery")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-discovery" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1a7yjx1xq9lalvrb5k3z2lqwnd58wg005483nswn4mbpik955acl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-aes" ,rust-aes-0.8)
                       ("rust-base64" ,rust-base64-0.22)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-ctr" ,rust-ctr-0.9)
                       ("rust-dns-sd" ,rust-dns-sd-0.1)
                       ("rust-form-urlencoded" ,rust-form-urlencoded-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-hmac" ,rust-hmac-0.12)
                       ("rust-http-body-util" ,rust-http-body-util-0.1)
                       ("rust-hyper" ,rust-hyper-1)
                       ("rust-hyper-util" ,rust-hyper-util-0.1)
                       ("rust-libmdns" ,rust-libmdns-0.9)
                       ("rust-librespot-core" ,rust-librespot-core-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-repr" ,rust-serde-repr-0.1)
                       ("rust-sha1" ,rust-sha1-0.10)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-zbus" ,rust-zbus-4))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The discovery logic for librespot")
    (description "This package provides The discovery logic for librespot.")
    (license license:expat)))

(define-public rust-sdl2-sys-0.37
  (package
    (name "rust-sdl2-sys")
    (version "0.37.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sdl2-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1lr16nj54d77llbbidhnxflg149wm42hsywb0v3dk3phgarfl7cm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.69)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-cmake" ,rust-cmake-0.1)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-pkg-config" ,rust-pkg-config-0.3)
                       ("rust-vcpkg" ,rust-vcpkg-0.2)
                       ("rust-version-compare" ,rust-version-compare-0.1))))
    (home-page "https://github.com/rust-sdl2/rust-sdl2")
    (synopsis "Raw SDL2 bindings for Rust, used internally rust-sdl2")
    (description
     "This package provides Raw SDL2 bindings for Rust, used internally rust-sdl2.")
    (license (list license:expat license:zlib))))

(define-public rust-sdl2-0.37
  (package
    (name "rust-sdl2")
    (version "0.37.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sdl2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "106kkjd71kgj9lxmyq43fnjr07f1dynx96vj774dc6jds6kqsj9v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-c-vec" ,rust-c-vec-2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-raw-window-handle" ,rust-raw-window-handle-0.6)
                       ("rust-sdl2-sys" ,rust-sdl2-sys-0.37))))
    (home-page "https://github.com/Rust-SDL2/rust-sdl2")
    (synopsis "SDL2 bindings for Rust")
    (description "This package provides SDL2 bindings for Rust.")
    (license license:expat)))

(define-public rust-extended-0.1
  (package
    (name "rust-extended")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "extended" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0r830ak1a9775i9yl5lljm29zbnlncw7xlfz35mhgjrz43c775mg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/depp/extended-rs")
    (synopsis "Extended precision 80-bit floating-point numbers (f80).")
    (description
     "This package provides Extended precision 80-bit floating-point numbers (f80).")
    (license license:expat)))

(define-public rust-symphonia-format-riff-0.5
  (package
    (name "rust-symphonia-format-riff")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-format-riff" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0l2zs6zl7q15jhsk9j1lahs2j29k5kkcn5bi9dzr6bwn5wivxxq5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-extended" ,rust-extended-0.1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust RIFF demuxer (a part of project Symphonia)")
    (description
     "This package provides Pure Rust RIFF demuxer (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-format-ogg-0.5
  (package
    (name "rust-symphonia-format-ogg")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-format-ogg" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0cd9py2xgx211qvwl9sw8n5l5vgd55vwcmqizh0cyssii5bm18xd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5)
                       ("rust-symphonia-utils-xiph" ,rust-symphonia-utils-xiph-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust OGG demuxer (a part of project Symphonia)")
    (description
     "This package provides Pure Rust OGG demuxer (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-format-mkv-0.5
  (package
    (name "rust-symphonia-format-mkv")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-format-mkv" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0vrxzr95d1xk2l5jarp7k2935s5ybsyrawwkr4nqixq0l5qk9d0v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5)
                       ("rust-symphonia-utils-xiph" ,rust-symphonia-utils-xiph-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust MKV/WebM demuxer (a part of project Symphonia)")
    (description
     "This package provides Pure Rust MKV/@code{WebM} demuxer (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-format-isomp4-0.5
  (package
    (name "rust-symphonia-format-isomp4")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-format-isomp4" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0i68dnhp3q7hv4i51hryw0c75i4l3fx85ffrwphhrrcpsrwg3zdb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5)
                       ("rust-symphonia-utils-xiph" ,rust-symphonia-utils-xiph-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust ISO/MP4 demuxer (a part of project Symphonia)")
    (description
     "This package provides Pure Rust ISO/MP4 demuxer (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-format-caf-0.5
  (package
    (name "rust-symphonia-format-caf")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-format-caf" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0l5gjy8asdcw8p2k9xqw0hc8npcz0wrv2wgy55d2k253jv39jg74"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust CAF demuxer (a part of project Symphonia)")
    (description
     "This package provides Pure Rust CAF demuxer (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-codec-vorbis-0.5
  (package
    (name "rust-symphonia-codec-vorbis")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-codec-vorbis" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0c4z98b8yg2kws3pknw7ipvvca911j3y5xq7n0r6f2kanigpd62s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-utils-xiph" ,rust-symphonia-utils-xiph-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust Vorbis decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust Vorbis decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-codec-pcm-0.5
  (package
    (name "rust-symphonia-codec-pcm")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-codec-pcm" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "16zq2s8zf0rs6070y3sfyscvm9z1riqvxcbv9plcbsy2axqad5gk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust PCM audio decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust PCM audio decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-codec-alac-0.5
  (package
    (name "rust-symphonia-codec-alac")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-codec-alac" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1wrq1s6w029bz7lqj08q87i375wvzl78nsj70qll224scik6d2id"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust ALAC decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust ALAC decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-codec-adpcm-0.5
  (package
    (name "rust-symphonia-codec-adpcm")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-codec-adpcm" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "03va885srhrzfz31jvxh2rgr9crnmmlvxmbkx4bdcz1jqgm1ykn9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust ADPCM audio decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust ADPCM audio decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-codec-aac-0.5
  (package
    (name "rust-symphonia-codec-aac")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-codec-aac" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0w1ga9c7m5bb11rc9bpnjb5g9bqms4x69slix3ikw3dd8nsjbgyd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust AAC decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust AAC decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-bundle-mp3-0.5
  (package
    (name "rust-symphonia-bundle-mp3")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-bundle-mp3" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1m062zkxq2cbwqxbm3qp4qvgpc9hm49g23vgdc4zpwghf2p2l760"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis
     "Pure Rust MP1, MP2, and MP3 demuxer and decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust MP1, MP2, and MP3 demuxer and decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-utils-xiph-0.5
  (package
    (name "rust-symphonia-utils-xiph")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-utils-xiph" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1zhhs1p0h6wdcgcwfqpmqq07n8v2wvn50razvapr36d41xc74i28"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Project Symphonia utilities for Xiph codecs and formats")
    (description
     "This package provides Project Symphonia utilities for Xiph codecs and formats.")
    (license license:mpl2.0)))

(define-public rust-symphonia-metadata-0.5
  (package
    (name "rust-symphonia-metadata")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-metadata" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0g02lhhyf6yyxm7bynx5b9fn2ha39y8fp6cfn72qj05186c2nqmw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Project Symphonia multimedia tag and metadata readers")
    (description
     "This package provides Project Symphonia multimedia tag and metadata readers.")
    (license license:mpl2.0)))

(define-public rust-symphonia-core-0.5
  (package
    (name "rust-symphonia-core")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1hr2w2a217vq4lpghszmsdwxr5ilh5d1ysfm3cixbirxkrvhd0vr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytemuck" ,rust-bytemuck-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-rustfft" ,rust-rustfft-6))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Project Symphonia shared structs, traits, and features")
    (description
     "This package provides Project Symphonia shared structs, traits, and features.")
    (license license:mpl2.0)))

(define-public rust-symphonia-bundle-flac-0.5
  (package
    (name "rust-symphonia-bundle-flac")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia-bundle-flac" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "15xxncx6gfh7jwvxvqqw4f8x9ic4bfzpyv3s77a0hwwa54s4zqvj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5)
                       ("rust-symphonia-utils-xiph" ,rust-symphonia-utils-xiph-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis
     "Pure Rust FLAC demuxer and decoder (a part of project Symphonia)")
    (description
     "This package provides Pure Rust FLAC demuxer and decoder (a part of project Symphonia).")
    (license license:mpl2.0)))

(define-public rust-symphonia-0.5
  (package
    (name "rust-symphonia")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "symphonia" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1agmsnmzgsmvd70hq760nvkjrb52nnjmz5hgn1xp6x7fwwm98p41"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-symphonia-bundle-flac" ,rust-symphonia-bundle-flac-0.5)
                       ("rust-symphonia-bundle-mp3" ,rust-symphonia-bundle-mp3-0.5)
                       ("rust-symphonia-codec-aac" ,rust-symphonia-codec-aac-0.5)
                       ("rust-symphonia-codec-adpcm" ,rust-symphonia-codec-adpcm-0.5)
                       ("rust-symphonia-codec-alac" ,rust-symphonia-codec-alac-0.5)
                       ("rust-symphonia-codec-pcm" ,rust-symphonia-codec-pcm-0.5)
                       ("rust-symphonia-codec-vorbis" ,rust-symphonia-codec-vorbis-0.5)
                       ("rust-symphonia-core" ,rust-symphonia-core-0.5)
                       ("rust-symphonia-format-caf" ,rust-symphonia-format-caf-0.5)
                       ("rust-symphonia-format-isomp4" ,rust-symphonia-format-isomp4-0.5)
                       ("rust-symphonia-format-mkv" ,rust-symphonia-format-mkv-0.5)
                       ("rust-symphonia-format-ogg" ,rust-symphonia-format-ogg-0.5)
                       ("rust-symphonia-format-riff" ,rust-symphonia-format-riff-0.5)
                       ("rust-symphonia-metadata" ,rust-symphonia-metadata-0.5))))
    (home-page "https://github.com/pdeljanov/Symphonia")
    (synopsis "Pure Rust media container and audio decoding library")
    (description
     "This package provides Pure Rust media container and audio decoding library.")
    (license license:mpl2.0)))

(define-public rust-minimp3-fixed-0.5
  (package
    (name "rust-minimp3-fixed")
    (version "0.5.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "minimp3_fixed" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "06wmic6gy3k3jmbz767clapx98v20aqmc9kc76p9gnkmgr7g3c22"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-minimp3-sys" ,rust-minimp3-sys-0.3)
                       ("rust-slice-ring-buffer" ,rust-slice-ring-buffer-0.3)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/BOB450/minimp3-rs.git")
    (synopsis
     "Rust bindings for the minimp3 library. With Security patch applied")
    (description
     "This package provides Rust bindings for the minimp3 library.  With Security patch applied.")
    (license license:expat)))

(define-public rust-rodio-0.19
  (package
    (name "rust-rodio")
    (version "0.19.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rodio" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1jvs8a6iq7h7s23acq1d76jk9zlc85snap58sgrkg3d3q4ksc1k0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-claxon" ,rust-claxon-0.4)
                       ("rust-cpal" ,rust-cpal-0.15)
                       ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-hound" ,rust-hound-3)
                       ("rust-lewton" ,rust-lewton-0.10)
                       ("rust-minimp3-fixed" ,rust-minimp3-fixed-0.5)
                       ("rust-symphonia" ,rust-symphonia-0.5)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/RustAudio/rodio")
    (synopsis "Audio playback library")
    (description "This package provides Audio playback library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-ogg-0.9
  (package
    (name "rust-ogg")
    (version "0.9.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ogg" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0azf3npw93y62fj7ha5lmppjcvlsrly7mc4gmynfllj0ip6qvazx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-io" ,rust-futures-io-0.3)
                       ("rust-pin-project" ,rust-pin-project-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.6))))
    (home-page "https://github.com/RustAudio/ogg")
    (synopsis "Ogg container decoder and encoder written in pure Rust")
    (description
     "This package provides Ogg container decoder and encoder written in pure Rust.")
    (license license:bsd-3)))

(define-public rust-librespot-metadata-0.6
  (package
    (name "rust-librespot-metadata")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-metadata" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0pxyz32fklj5cmsl3603w6x4nsdab7lxrsv2w39is6s0db2dbxkw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-librespot-core" ,rust-librespot-core-0.6)
                       ("rust-librespot-protocol" ,rust-librespot-protocol-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-protobuf" ,rust-protobuf-3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The metadata logic for librespot")
    (description "This package provides The metadata logic for librespot.")
    (license license:expat)))

(define-public rust-gstreamer-audio-sys-0.23
  (package
    (name "rust-gstreamer-audio-sys")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-audio-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0lgv2js08ymnd463v2q48sf1h3g4bqlgsq341asi227kxhk9aikx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-glib-sys" ,rust-glib-sys-0.20)
                       ("rust-gobject-sys" ,rust-gobject-sys-0.20)
                       ("rust-gstreamer-base-sys" ,rust-gstreamer-base-sys-0.23)
                       ("rust-gstreamer-sys" ,rust-gstreamer-sys-0.23)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-system-deps" ,rust-system-deps-7))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "FFI bindings to libgstaudio-1.0")
    (description "This package provides FFI bindings to libgstaudio-1.0.")
    (license license:expat)))

(define-public rust-gstreamer-audio-0.23
  (package
    (name "rust-gstreamer-audio")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-audio" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1phyxypxnwcyx552pzz8zz17j46rjy2arz09flh45z72hjk8q4a9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-glib" ,rust-glib-0.20)
                       ("rust-gstreamer" ,rust-gstreamer-0.23)
                       ("rust-gstreamer-audio-sys" ,rust-gstreamer-audio-sys-0.23)
                       ("rust-gstreamer-base" ,rust-gstreamer-base-0.23)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-smallvec" ,rust-smallvec-1))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "Rust bindings for GStreamer Audio library")
    (description
     "This package provides Rust bindings for GStreamer Audio library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-gstreamer-base-0.23
  (package
    (name "rust-gstreamer-base")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-base" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1s45x5ylpqcm1s2612mdc4rvkzq0z00gjr1i6sn1blmh9m2dscxd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-atomic-refcell" ,rust-atomic-refcell-0.1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-glib" ,rust-glib-0.20)
                       ("rust-gstreamer" ,rust-gstreamer-0.23)
                       ("rust-gstreamer-base-sys" ,rust-gstreamer-base-sys-0.23)
                       ("rust-libc" ,rust-libc-0.2))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "Rust bindings for GStreamer Base library")
    (description
     "This package provides Rust bindings for GStreamer Base library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-gstreamer-base-sys-0.23
  (package
    (name "rust-gstreamer-base-sys")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-base-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "095zv2bwjxh7xdmiwyfjigvvnxjkbm7ya02bqlh0z9qr9xq2ljqi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-glib-sys" ,rust-glib-sys-0.20)
                       ("rust-gobject-sys" ,rust-gobject-sys-0.20)
                       ("rust-gstreamer-sys" ,rust-gstreamer-sys-0.23)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-system-deps" ,rust-system-deps-7))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "FFI bindings to libgstbase-1.0")
    (description "This package provides FFI bindings to libgstbase-1.0.")
    (license license:expat)))

(define-public rust-gstreamer-app-sys-0.23
  (package
    (name "rust-gstreamer-app-sys")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-app-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0maly3dfrqwd142ql02rb80dwhmcg7f18fjh5n2m3zh6hf1yzxwl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-glib-sys" ,rust-glib-sys-0.20)
                       ("rust-gstreamer-base-sys" ,rust-gstreamer-base-sys-0.23)
                       ("rust-gstreamer-sys" ,rust-gstreamer-sys-0.23)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-system-deps" ,rust-system-deps-7))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "FFI bindings to libgstapp-1.0")
    (description "This package provides FFI bindings to libgstapp-1.0.")
    (license license:expat)))

(define-public rust-gstreamer-app-0.23
  (package
    (name "rust-gstreamer-app")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-app" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0kh0mxdx5r0wzzqaf7zpxjk5vsksbz02b0hmi49czsqsn8z8i6if"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-glib" ,rust-glib-0.20)
                       ("rust-gstreamer" ,rust-gstreamer-0.23)
                       ("rust-gstreamer-app-sys" ,rust-gstreamer-app-sys-0.23)
                       ("rust-gstreamer-base" ,rust-gstreamer-base-0.23)
                       ("rust-libc" ,rust-libc-0.2))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "Rust bindings for GStreamer App library")
    (description
     "This package provides Rust bindings for GStreamer App library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-gstreamer-sys-0.23
  (package
    (name "rust-gstreamer-sys")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1lfvcyhf6byf7g3b1mxc3q7abr6rqnkh8rng11c74n20hcw945gy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-glib-sys" ,rust-glib-sys-0.20)
                       ("rust-gobject-sys" ,rust-gobject-sys-0.20)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-system-deps" ,rust-system-deps-7))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "FFI bindings to libgstreamer-1.0")
    (description "This package provides FFI bindings to libgstreamer-1.0.")
    (license license:expat)))

(define-public rust-gstreamer-0.23
  (package
    (name "rust-gstreamer")
    (version "0.23.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gstreamer" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "01ci5krjlyl4japaz9xbklk3dabhhijzdg1brzj15ghfkf1gx211"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-glib" ,rust-glib-0.20)
                       ("rust-gstreamer-sys" ,rust-gstreamer-sys-0.23)
                       ("rust-itertools" ,rust-itertools-0.13)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-muldiv" ,rust-muldiv-1)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-rational" ,rust-num-rational-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-option-operations" ,rust-option-operations-0.5)
                       ("rust-paste" ,rust-paste-1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-bytes" ,rust-serde-bytes-0.11)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-thiserror" ,rust-thiserror-2))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "Rust bindings for GStreamer")
    (description "This package provides Rust bindings for GStreamer.")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-interface-0.53
  (package
    (name "rust-windows-interface")
    (version "0.53.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows-interface" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0q4bb5zigzr3083kwb7qkhx63dlymwx8gy6mw7jgm25281qmacys"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "The interface macro for the windows crate")
    (description
     "This package provides The interface macro for the windows crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-implement-0.53
  (package
    (name "rust-windows-implement")
    (version "0.53.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows-implement" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1gd05sw9knn8i7n9ip1kdwpxqcwmldja3w32m16chjcjprkc4all"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "The implement macro for the windows crate")
    (description
     "This package provides The implement macro for the windows crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-core-0.54
  (package
    (name "rust-windows-core")
    (version "0.54.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows-core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0r8x2sgl4qq1h23ldf4z7cj213k0bz7479m8a156h79mi6f1nrhj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-result" ,rust-windows-result-0.1)
                       ("rust-windows-targets" ,rust-windows-targets-0.52))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Core type support for COM and Windows")
    (description
     "This package provides Core type support for COM and Windows.")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-0.54
  (package
    (name "rust-windows")
    (version "0.54.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0j8vd8sg2rbln6g3a608qg1a7r2lwxcga78mmxjjin5ybmrfallj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-core" ,rust-windows-core-0.54)
                       ("rust-windows-implement" ,rust-windows-implement-0.53)
                       ("rust-windows-interface" ,rust-windows-interface-0.53)
                       ("rust-windows-targets" ,rust-windows-targets-0.52))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "This package provides Rust for Windows.")
    (license (list license:expat license:asl2.0))))

(define-public rust-oboe-sys-0.6
  (package
    (name "rust-oboe-sys")
    (version "0.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "oboe-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "17g7yb4kk6bakc4rhv1izfcqjgqhpkasgq6gf20nc79b9adb12vc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.69)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-fetch-unroll" ,rust-fetch-unroll-0.3))))
    (home-page "https://github.com/katyo/oboe-rs")
    (synopsis
     "Unsafe bindings for oboe an android library for low latency audio IO")
    (description
     "This package provides Unsafe bindings for oboe an android library for low latency audio IO.")
    (license license:asl2.0)))

(define-public rust-oboe-0.6
  (package
    (name "rust-oboe")
    (version "0.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "oboe" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1yv7x06mwk61nsy3ckcmqwgg9q0n3j4y4zncz3sl6pcyskmipdp8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-jni" ,rust-jni-0.21)
                       ("rust-ndk" ,rust-ndk-0.8)
                       ("rust-ndk-context" ,rust-ndk-context-0.1)
                       ("rust-num-derive" ,rust-num-derive-0.4)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-oboe-sys" ,rust-oboe-sys-0.6))))
    (home-page "https://github.com/katyo/oboe-rs")
    (synopsis
     "Safe interface for oboe an android library for low latency audio IO")
    (description
     "This package provides Safe interface for oboe an android library for low latency audio IO.")
    (license license:asl2.0)))

(define-public rust-jack-sys-0.5
  (package
    (name "rust-jack-sys")
    (version "0.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "jack-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1aw6zishflmd5v9dz5yvpc5f9jsfm9pjjhzvdmbjp8lmkdhvf4v0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libloading" ,rust-libloading-0.7)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page "https://github.com/RustAudio/rust-jack/tree/main/jack-sys")
    (synopsis "Low-level binding to the JACK audio API")
    (description
     "This package provides Low-level binding to the JACK audio API.")
    (license (list license:expat license:asl2.0))))

(define-public rust-jack-0.11
  (package
    (name "rust-jack")
    (version "0.11.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "jack" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1kd6p6bfmxyclkkq9pkrqyynf0mj53ias4binx7kbyxfqaiihnhf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-jack-sys" ,rust-jack-sys-0.5)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4))))
    (home-page "https://github.com/RustAudio/rust-jack")
    (synopsis "Real time audio and midi with JACK")
    (description "This package provides Real time audio and midi with JACK.")
    (license license:expat)))

(define-public rust-dasp-sample-0.11
  (package
    (name "rust-dasp-sample")
    (version "0.11.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "dasp_sample" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zzw35akm3qs2rixbmlijk6h0l4g9ry6g74qc59zv1q8vs1f31qc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rustaudio/sample")
    (synopsis
     "An abstraction for audio PCM DSP samples, along with useful conversions and operations")
    (description
     "This package provides An abstraction for audio PCM DSP samples, along with useful conversions and
operations.")
    (license (list license:expat license:asl2.0))))

(define-public rust-coreaudio-rs-0.11
  (package
    (name "rust-coreaudio-rs")
    (version "0.11.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "coreaudio-rs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1kmssby4rqhv2iq1a8zmaav5p3bl40qs0wah9zv65ikr5lbpf41j"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8)
                       ("rust-coreaudio-sys" ,rust-coreaudio-sys-0.2))))
    (home-page "https://github.com/RustAudio/coreaudio-rs")
    (synopsis "friendly rust interface for Apple's CoreAudio API.")
    (description
     "This package provides a friendly rust interface for Apple's @code{CoreAudio}
API.")
    (license (list license:expat license:asl2.0))))

(define-public rust-cpal-0.15
  (package
    (name "rust-cpal")
    (version "0.15.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cpal" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0yd7d51kcf8ml0bfkjrac12zgfjzk21wa97maxg0fhzpr03sngc7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-alsa" ,rust-alsa-0.9)
                       ("rust-asio-sys" ,rust-asio-sys-0.2)
                       ("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8)
                       ("rust-coreaudio-rs" ,rust-coreaudio-rs-0.11)
                       ("rust-dasp-sample" ,rust-dasp-sample-0.11)
                       ("rust-jack" ,rust-jack-0.11)
                       ("rust-jni" ,rust-jni-0.21)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mach2" ,rust-mach2-0.4)
                       ("rust-ndk" ,rust-ndk-0.8)
                       ("rust-ndk-context" ,rust-ndk-context-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-oboe" ,rust-oboe-0.6)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                       ("rust-wasm-bindgen-futures" ,rust-wasm-bindgen-futures-0.4)
                       ("rust-web-sys" ,rust-web-sys-0.3)
                       ("rust-windows" ,rust-windows-0.54))))
    (home-page "https://github.com/rustaudio/cpal")
    (synopsis "Low-level cross-platform audio I/O library in pure Rust")
    (description
     "This package provides Low-level cross-platform audio I/O library in pure Rust.")
    (license license:asl2.0)))

(define-public rust-librespot-playback-0.6
  (package
    (name "rust-librespot-playback")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-playback" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0r6zf72kyhlzlq7nsv7c56kmwqgj6kq4v3bz81sr532cl1vgglaf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-alsa" ,rust-alsa-0.9)
                       ("rust-cpal" ,rust-cpal-0.15)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-glib" ,rust-glib-0.20)
                       ("rust-gstreamer" ,rust-gstreamer-0.23)
                       ("rust-gstreamer-app" ,rust-gstreamer-app-0.23)
                       ("rust-gstreamer-audio" ,rust-gstreamer-audio-0.23)
                       ("rust-jack" ,rust-jack-0.11)
                       ("rust-libpulse-binding" ,rust-libpulse-binding-2)
                       ("rust-libpulse-simple-binding" ,rust-libpulse-simple-binding-2)
                       ("rust-librespot-audio" ,rust-librespot-audio-0.6)
                       ("rust-librespot-core" ,rust-librespot-core-0.6)
                       ("rust-librespot-metadata" ,rust-librespot-metadata-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ogg" ,rust-ogg-0.9)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-portaudio-rs" ,rust-portaudio-rs-0.3)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rand-distr" ,rust-rand-distr-0.4)
                       ("rust-rodio" ,rust-rodio-0.19)
                       ("rust-sdl2" ,rust-sdl2-0.37)
                       ("rust-shell-words" ,rust-shell-words-1)
                       ("rust-symphonia" ,rust-symphonia-0.5)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-zerocopy" ,rust-zerocopy-0.7))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The audio playback logic for librespot")
    (description
     "This package provides The audio playback logic for librespot.")
    (license license:expat)))

(define-public rust-librespot-connect-0.6
  (package
    (name "rust-librespot-connect")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-connect" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0q7s2visnzxk5ddgsigh3l8k2j27g91zbkr5li8y17366ib3mkk7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-form-urlencoded" ,rust-form-urlencoded-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-librespot-core" ,rust-librespot-core-0.6)
                       ("rust-librespot-playback" ,rust-librespot-playback-0.6)
                       ("rust-librespot-protocol" ,rust-librespot-protocol-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-protobuf" ,rust-protobuf-3)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-stream" ,rust-tokio-stream-0.1))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The discovery and Spotify Connect logic for librespot")
    (description
     "This package provides The discovery and Spotify Connect logic for librespot.")
    (license license:expat)))

(define-public rust-vergen-lib-0.1
  (package
    (name "rust-vergen-lib")
    (version "0.1.6")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "vergen-lib" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0rn1x40xwx4zlj62nkl63y6sczar6hw1dq34n7y5jghg1h0yc1wv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-derive-builder" ,rust-derive-builder-0.20)
                       ("rust-rustversion" ,rust-rustversion-1))))
    (home-page "https://github.com/rustyhorde/vergen")
    (synopsis "Common code used to support the vergen libraries")
    (description
     "This package provides Common code used to support the vergen libraries.")
    (license (list license:expat license:asl2.0))))

(define-public rust-sysinfo-0.33
  (package
    (name "rust-sysinfo")
    (version "0.33.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sysinfo" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "00bcbj9rk39n07ylclj9klggkshxyianv2lfkpqnc6x0iqj5ij2g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-ntapi" ,rust-ntapi-0.4)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-windows" ,rust-windows-0.58))))
    (home-page "https://github.com/GuillaumeGomez/sysinfo")
    (synopsis
     "Library to get system information such as processes, CPUs, disks, components and networks")
    (description
     "This package provides Library to get system information such as processes, CPUs, disks, components and
networks.")
    (license license:expat)))

(define-public rust-vergen-9
  (package
    (name "rust-vergen")
    (version "9.0.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "vergen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "16nd0ghig27s51dnjn1w3f9c433glhl1g8m28dd80nq7z1wz3lp0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-cargo-metadata" ,rust-cargo-metadata-0.19)
                       ("rust-derive-builder" ,rust-derive-builder-0.20)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rustc-version" ,rust-rustc-version-0.4)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-sysinfo" ,rust-sysinfo-0.33)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-vergen-lib" ,rust-vergen-lib-0.1))))
    (home-page "https://github.com/rustyhorde/vergen")
    (synopsis
     "Generate 'cargo:rustc-env' instructions via 'build.rs' for use in your code via the 'env!' macro")
    (description
     "This package provides Generate cargo:rustc-env instructions via build.rs for use in your code via the
env! macro.")
    (license (list license:expat license:asl2.0))))

(define-public rust-time-macros-0.2
  (package
    (name "rust-time-macros")
    (version "0.2.22")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "time-macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0jcaxpw220han2bzbrdlpqhy1s5k9i8ri3lw6n5zv4zcja9p69im"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-num-conv" ,rust-num-conv-0.1)
                       ("rust-time-core" ,rust-time-core-0.1))))
    (home-page "https://github.com/time-rs/time")
    (synopsis
     "Procedural macros for the time crate.
    This crate is an implementation detail and should not be relied upon directly.")
    (description
     "This package provides Procedural macros for the time crate.  This crate is an implementation detail
and should not be relied upon directly.")
    (license (list license:expat license:asl2.0))))

(define-public rust-time-core-0.1
  (package
    (name "rust-time-core")
    (version "0.1.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "time-core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0z5h9fknvdvbs2k2s1chpi3ab3jvgkfhdnqwrvixjngm263s7sf9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/time-rs/time")
    (synopsis
     "This crate is an implementation detail and should not be relied upon directly")
    (description
     "This crate is an implementation detail and should not be relied upon directly.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wit-bindgen-rt-0.39
  (package
    (name "rust-wit-bindgen-rt")
    (version "0.39.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wit-bindgen-rt" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1hd65pa5hp0nl664m94bg554h4zlhrzmkjsf6lsgsb7yc4734hkg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-once-cell" ,rust-once-cell-1))))
    (home-page "https://github.com/bytecodealliance/wit-bindgen")
    (synopsis "Internal runtime support for the `wit-bindgen` crate.")
    (description
     "This package provides Internal runtime support for the `wit-bindgen` crate.")
    (license (list license:asl2.0  license:asl2.0
                   license:expat))))

(define-public rust-wasi-0.14
  (package
    (name "rust-wasi")
    (version "0.14.2+wasi-0.2.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasi" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1cwcqjr3dgdq8j325awgk8a715h0hg0f7jqzsb077n4qm6jzk0wn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-wit-bindgen-rt" ,rust-wit-bindgen-rt-0.39))))
    (home-page "https://github.com/bytecodealliance/wasi-rs")
    (synopsis "WASI API bindings for Rust")
    (description "This package provides WASI API bindings for Rust.")
    (license (list license:asl2.0  license:asl2.0
                   license:expat))))

(define-public rust-r-efi-5
  (package
    (name "rust-r-efi")
    (version "5.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "r-efi" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ig93jvpqyi87nc5kb6dri49p56q7r7qxrn8kfizmqkfj5nmyxkl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/r-efi/r-efi/wiki")
    (synopsis
     "UEFI Reference Specification Protocol Constants and Definitions")
    (description
     "This package provides UEFI Reference Specification Protocol Constants and Definitions.")
    (license (list license:expat license:asl2.0 license:lgpl2.1+))))

(define-public rust-wasm-bindgen-shared-0.2
  (package
    (name "rust-wasm-bindgen-shared")
    (version "0.2.100")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-bindgen-shared" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0gffxvqgbh9r9xl36gprkfnh3w9gl8wgia6xrin7v11sjcxxf18s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-unicode-ident" ,rust-unicode-ident-1))))
    (home-page "https://rustwasm.github.io/wasm-bindgen/")
    (synopsis
     "Shared support between wasm-bindgen and wasm-bindgen cli, an internal
dependency.")
    (description
     "This package provides Shared support between wasm-bindgen and wasm-bindgen cli, an internal
dependency.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasm-bindgen-backend-0.2
  (package
    (name "rust-wasm-bindgen-backend")
    (version "0.2.100")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-bindgen-backend" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ihbf1hq3y81c4md9lyh6lcwbx6a5j0fw4fygd423g62lm8hc2ig"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bumpalo" ,rust-bumpalo-3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-wasm-bindgen-shared" ,rust-wasm-bindgen-shared-0.2))))
    (home-page "https://rustwasm.github.io/wasm-bindgen/")
    (synopsis "Backend code generation of the wasm-bindgen tool")
    (description
     "This package provides Backend code generation of the wasm-bindgen tool.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasm-bindgen-macro-support-0.2
  (package
    (name "rust-wasm-bindgen-macro-support")
    (version "0.2.100")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-bindgen-macro-support" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1plm8dh20jg2id0320pbmrlsv6cazfv6b6907z19ys4z1jj7xs4a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-wasm-bindgen-backend" ,rust-wasm-bindgen-backend-0.2)
                       ("rust-wasm-bindgen-shared" ,rust-wasm-bindgen-shared-0.2))))
    (home-page "https://rustwasm.github.io/wasm-bindgen/")
    (synopsis
     "The part of the implementation of the `#[wasm_bindgen]` attribute that is not in the shared backend crate")
    (description
     "This package provides The part of the implementation of the `#[wasm_bindgen]` attribute that is not in
the shared backend crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasm-bindgen-macro-0.2
  (package
    (name "rust-wasm-bindgen-macro")
    (version "0.2.100")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-bindgen-macro" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "01xls2dvzh38yj17jgrbiib1d3nyad7k2yw9s0mpklwys333zrkz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-quote" ,rust-quote-1)
                       ("rust-wasm-bindgen-macro-support" ,rust-wasm-bindgen-macro-support-0.2))))
    (home-page "https://rustwasm.github.io/wasm-bindgen/")
    (synopsis
     "Definition of the `#[wasm_bindgen]` attribute, an internal dependency")
    (description
     "This package provides Definition of the `#[wasm_bindgen]` attribute, an internal dependency.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wasm-bindgen-0.2
  (package
    (name "rust-wasm-bindgen")
    (version "0.2.100")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasm-bindgen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1x8ymcm6yi3i1rwj78myl1agqv2m86i648myy3lc97s9swlqkp0y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-wasm-bindgen-macro" ,rust-wasm-bindgen-macro-0.2))))
    (home-page "https://rustwasm.github.io/")
    (synopsis "Easy support for interacting between JS and Rust.")
    (description
     "This package provides Easy support for interacting between JS and Rust.")
    (license (list license:expat license:asl2.0))))

(define-public rust-js-sys-0.3
  (package
    (name "rust-js-sys")
    (version "0.3.77")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "js-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13x2qcky5l22z4xgivi59xhjjx4kxir1zg7gcj0f1ijzd4yg7yhw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-once-cell" ,rust-once-cell-1)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2))))
    (home-page "https://rustwasm.github.io/wasm-bindgen/")
    (synopsis
     "Bindings for all JS global objects and functions in all JS environments like
Node.js and browsers, built on `#[wasm_bindgen]` using the `wasm-bindgen` crate.")
    (description
     "This package provides Bindings for all JS global objects and functions in all JS environments like
Node.js and browsers, built on `#[wasm_bindgen]` using the `wasm-bindgen` crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-getrandom-0.3
  (package
    (name "rust-getrandom")
    (version "0.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "getrandom" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1w2mlixa1989v7czr68iji7h67yra2pbg3s480wsqjza1r2sizkk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-r-efi" ,rust-r-efi-5)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-wasi" ,rust-wasi-0.14)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2))))
    (home-page "https://github.com/rust-random/getrandom")
    (synopsis
     "small cross-platform library for retrieving random data from system source")
    (description
     "This package provides a small cross-platform library for retrieving random data
from system source.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rand-core-0.9
  (package
    (name "rust-rand-core")
    (version "0.9.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rand_core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0f3xhf16yks5ic6kmgxcpv1ngdhp48mmfy4ag82i1wnwh8ws3ncr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-getrandom" ,rust-getrandom-0.3)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://rust-random.github.io/book")
    (synopsis
     "Core random number generator traits and tools for implementation.")
    (description
     "This package provides Core random number generator traits and tools for implementation.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rand-chacha-0.9
  (package
    (name "rust-rand-chacha")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rand_chacha" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1jr5ygix7r60pz0s1cv3ms1f6pd1i9pcdmnxzzhjc3zn3mgjn0nk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ppv-lite86" ,rust-ppv-lite86-0.2)
                       ("rust-rand-core" ,rust-rand-core-0.9)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://rust-random.github.io/book")
    (synopsis "ChaCha random number generator")
    (description
     "This package provides @code{ChaCha} random number generator.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rand-0.9
  (package
    (name "rust-rand")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rand" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "156dyvsfa6fjnv6nx5vzczay1scy5183dvjchd7bvs47xd5bjy9p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-rand-chacha" ,rust-rand-chacha-0.9)
                       ("rust-rand-core" ,rust-rand-core-0.9)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-zerocopy" ,rust-zerocopy-0.8))))
    (home-page "https://rust-random.github.io/book")
    (synopsis "Random number generators and other randomness functionality.")
    (description
     "This package provides Random number generators and other randomness functionality.")
    (license (list license:expat license:asl2.0))))

(define-public rust-deranged-macros-0.2
  (package
    (name "rust-deranged-macros")
    (version "0.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "deranged-macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13xpi0bbcfnjnqj67ls8z8x94j3zrh3i85lawjral726jjh9mfqn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/jhpratt/deranged")
    (synopsis "Ranged integers")
    (description "This package provides Ranged integers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-deranged-0.4
  (package
    (name "rust-deranged")
    (version "0.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "deranged" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0n7hswnz5jz1rjy6zr8sc9awbszkmv1345hphccawj40w1larkr8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-deranged-macros" ,rust-deranged-macros-0.2)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-powerfmt" ,rust-powerfmt-0.2)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rand" ,rust-rand-0.9)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/jhpratt/deranged")
    (synopsis "Ranged integers")
    (description "This package provides Ranged integers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-time-0.3
  (package
    (name "rust-time")
    (version "0.3.41")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "time" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0h0cpiyya8cjlrh00d2r72bmgg4lsdcncs76qpwy0rn2kghijxla"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-deranged" ,rust-deranged-0.4)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-num-conv" ,rust-num-conv-0.1)
                       ("rust-num-threads" ,rust-num-threads-0.1)
                       ("rust-powerfmt" ,rust-powerfmt-0.2)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-time-core" ,rust-time-core-0.1)
                       ("rust-time-macros" ,rust-time-macros-0.2))))
    (home-page "https://time-rs.github.io")
    (synopsis
     "Date and time library. Fully interoperable with the standard library. Mostly compatible with #![no_std]")
    (description
     "This package provides Date and time library.  Fully interoperable with the standard library.  Mostly
compatible with #![no_std].")
    (license (list license:expat license:asl2.0))))

(define-public rust-rustversion-1
  (package
    (name "rust-rustversion")
    (version "1.0.20")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rustversion" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1lhwjb16dsm8brd18bn2bh0ryzc7qi29bi2jjsc6ny2zbwn3ivgd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/dtolnay/rustversion")
    (synopsis "Conditional compilation according to rustc compiler version")
    (description
     "This package provides Conditional compilation according to rustc compiler version.")
    (license (list license:expat license:asl2.0))))

(define-public rust-vergen-gitcl-1
  (package
    (name "rust-vergen-gitcl")
    (version "1.0.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "vergen-gitcl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "04bp9ck9nlxc7nk04kmvri4idxacqrszbvcw0yk0cicalmq9vy5j"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-derive-builder" ,rust-derive-builder-0.20)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-vergen" ,rust-vergen-9)
                       ("rust-vergen-lib" ,rust-vergen-lib-0.1))))
    (home-page "https://github.com/rustyhorde/vergen")
    (synopsis
     "Generate 'cargo:rustc-env' instructions via 'build.rs' for use in your code via the 'env!' macro")
    (description
     "This package provides Generate cargo:rustc-env instructions via build.rs for use in your code via the
env! macro.")
    (license (list license:expat license:asl2.0))))

(define-public rust-priority-queue-2
  (package
    (name "rust-priority-queue")
    (version "2.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "priority-queue" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13ff7y3s9x6m9q0dazdnjz6v0b3j2iyxfjljm9cim6jql5gp027g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-equivalent" ,rust-equivalent-1)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/garro95/priority-queue")
    (synopsis
     "Priority Queue implemented as a heap with a function to efficiently change the priority of an item.")
    (description
     "This package provides a Priority Queue implemented as a heap with a function to
efficiently change the priority of an item.")
    (license (list license:lgpl3+ license:mpl2.0))))

(define-public rust-protobuf-parse-3
  (package
    (name "rust-protobuf-parse")
    (version "3.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "protobuf-parse" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0wy9pnfrsk2iz2ghhvzdpp0riklrm6p8dvdfxr4d7wb04hgsmbml"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-protobuf" ,rust-protobuf-3)
                       ("rust-protobuf-support" ,rust-protobuf-support-3)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-which" ,rust-which-4))))
    (home-page
     "https://github.com/stepancheg/rust-protobuf/tree/master/protobuf-parse/")
    (synopsis
     "Parse `.proto` files.

Files are parsed into a `protobuf::descriptor::FileDescriptorSet` object using either:
* pure rust parser (no dependencies)
* `protoc` binary (more reliable and compatible with Google's implementation)")
    (description
     "This package provides Parse `.proto` files.  Files are parsed into a
`protobuf::descriptor::@code{FileDescriptorSet`} object using either: * pure
rust parser (no dependencies) * `protoc` binary (more reliable and compatible
with Google's implementation).")
    (license license:expat)))

(define-public rust-protobuf-codegen-3
  (package
    (name "rust-protobuf-codegen")
    (version "3.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "protobuf-codegen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1kjaakqk0595akxdhv68w23zw136hw0h0kxkyg9bn500bj17cfax"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-protobuf" ,rust-protobuf-3)
                       ("rust-protobuf-parse" ,rust-protobuf-parse-3)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/stepancheg/rust-protobuf/")
    (synopsis
     "Code generator for rust-protobuf.

Includes a library to invoke programmatically (e. g. from `build.rs`) and `protoc-gen-rs` binary.")
    (description
     "This package provides Code generator for rust-protobuf.  Includes a library to invoke programmatically
(e.  g.  from `build.rs`) and `protoc-gen-rs` binary.")
    (license license:expat)))

(define-public rust-protobuf-support-3
  (package
    (name "rust-protobuf-support")
    (version "3.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "protobuf-support" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1mnpn2q96bxm2vidh86m5p2x5z0z8rgfyixk1wlgjiqa3vrw4diy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/stepancheg/rust-protobuf/")
    (synopsis
     "Code supporting protobuf implementation. None of code in this crate is public API.")
    (description
     "This package provides Code supporting protobuf implementation.  None of code in this crate is public
API.")
    (license license:expat)))

(define-public rust-protobuf-3
  (package
    (name "rust-protobuf")
    (version "3.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "protobuf" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1x4riz4znnjsqpdxnhxj0aq8rfivmbv4hfqmd3gbbn77v96isnnn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-protobuf-support" ,rust-protobuf-support-3)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/stepancheg/rust-protobuf/")
    (synopsis "Rust implementation of Google protocol buffers")
    (description
     "This package provides Rust implementation of Google protocol buffers.")
    (license license:expat)))

(define-public rust-librespot-protocol-0.6
  (package
    (name "rust-librespot-protocol")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-protocol" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0ih5ignz7srpl3zabq22p7vzn9x6hfjarrjlfhas5cx1nm92z040"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-protobuf" ,rust-protobuf-3)
                       ("rust-protobuf-codegen" ,rust-protobuf-codegen-3))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The protobuf logic for communicating with Spotify servers")
    (description
     "This package provides The protobuf logic for communicating with Spotify servers.")
    (license license:expat)))

(define-public rust-oauth2-4
  (package
    (name "rust-oauth2")
    (version "4.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "oauth2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zwkmwxwygl4fwghgyanixzqgn7yvkwwwacdghz7x124v36l3263"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-base64" ,rust-base64-0.13)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-curl" ,rust-curl-0.4)
                       ("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-reqwest" ,rust-reqwest-0.11)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-path-to-error" ,rust-serde-path-to-error-0.1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-ureq" ,rust-ureq-2)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/ramosbugs/oauth2-rs")
    (synopsis "An extensible, strongly-typed implementation of OAuth2")
    (description
     "This package provides An extensible, strongly-typed implementation of OAuth2.")
    (license (list license:expat license:asl2.0))))

(define-public rust-librespot-oauth-0.6
  (package
    (name "rust-librespot-oauth")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-oauth" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0kyiz3a7nn634sq0ap56737myp1sm06a9qlkwi1b9hx6k9vsvp00"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-oauth2" ,rust-oauth2-4)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis
     "OAuth authorization code flow with PKCE for obtaining a Spotify access token")
    (description
     "This package provides OAuth authorization code flow with PKCE for obtaining a Spotify access token.")
    (license license:expat)))

(define-public rust-tokio-openssl-0.6
  (package
    (name "rust-tokio-openssl")
    (version "0.6.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tokio-openssl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1pga4xm5fcms6k1rqg4hsl8mmna7qiizhdlsgxbbffx4r94nipsr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-openssl" ,rust-openssl-0.10)
                       ("rust-openssl-sys" ,rust-openssl-sys-0.9)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/tokio-rs/tokio-openssl")
    (synopsis "An implementation of SSL streams for Tokio backed by OpenSSL")
    (description
     "This package provides An implementation of SSL streams for Tokio backed by @code{OpenSSL}.")
    (license (list license:expat license:asl2.0))))

(define-public rust-hyper-proxy2-0.1
  (package
    (name "rust-hyper-proxy2")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "hyper-proxy2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1brzvj6v5rfzq17x6wbg41vcqhpwli87phhlf0f4mg5h7yrbfhwh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-headers" ,rust-headers-0.4)
                       ("rust-http" ,rust-http-1)
                       ("rust-hyper" ,rust-hyper-1)
                       ("rust-hyper-rustls" ,rust-hyper-rustls-0.26)
                       ("rust-hyper-tls" ,rust-hyper-tls-0.6)
                       ("rust-hyper-util" ,rust-hyper-util-0.1)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-openssl" ,rust-openssl-0.10)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.7)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-openssl" ,rust-tokio-openssl-0.6)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.25)
                       ("rust-tower-service" ,rust-tower-service-0.3)
                       ("rust-webpki" ,rust-webpki-0.22)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.26))))
    (home-page "https://github.com/siketyan/hyper-proxy2")
    (synopsis "proxy connector for Hyper-based applications")
    (description
     "This package provides a proxy connector for Hyper-based applications.")
    (license license:expat)))

(define-public rust-spinning-top-0.3
  (package
    (name "rust-spinning-top")
    (version "0.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "spinning_top" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "001kjbiz1gg111rsqxc4pq9a1izx7wshkk38f69h1dbgf4fjsvfr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lock-api" ,rust-lock-api-0.4))))
    (home-page "https://github.com/rust-osdev/spinning_top")
    (synopsis
     "simple spinlock crate based on the abstractions provided by `lock_api`.")
    (description
     "This package provides a simple spinlock crate based on the abstractions provided
by `lock_api`.")
    (license (list license:expat license:asl2.0))))

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

(define-public rust-quanta-0.12
  (package
    (name "rust-quanta")
    (version "0.12.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "quanta" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "03kwh0xb7gr461jcjhrxvcj9157k1jyg2gyy0f4579nf4ilgxl9v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-prost-types" ,rust-prost-types-0.11)
                       ("rust-raw-cpuid" ,rust-raw-cpuid-11)
                       ("rust-wasi" ,rust-wasi-0.11)
                       ("rust-web-sys" ,rust-web-sys-0.3)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/metrics-rs/quanta")
    (synopsis "high-speed timing library")
    (description "This package provides high-speed timing library.")
    (license license:expat)))

(define-public rust-nonzero-ext-0.3
  (package
    (name "rust-nonzero-ext")
    (version "0.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nonzero_ext" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "08fghyinb07xwhbj7vwvlhg45g5cvhvld2min25njidir12rdgrq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/antifuchs/nonzero_ext")
    (synopsis "Extensions and additional traits for non-zero integer types")
    (description
     "This package provides Extensions and additional traits for non-zero integer types.")
    (license license:asl2.0)))

(define-public rust-governor-0.6
  (package
    (name "rust-governor")
    (version "0.6.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "governor" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0yw66yb1rfc7np23n9af9sb8kbhv3jnhvg3an1rsydbbxr1gb9v8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-dashmap" ,rust-dashmap-5)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-futures-timer" ,rust-futures-timer-3)
                       ("rust-no-std-compat" ,rust-no-std-compat-0.4)
                       ("rust-nonzero-ext" ,rust-nonzero-ext-0.3)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-portable-atomic" ,rust-portable-atomic-1)
                       ("rust-quanta" ,rust-quanta-0.12)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-spinning-top" ,rust-spinning-top-0.3))))
    (home-page "https://github.com/boinkor-net/governor")
    (synopsis "rate-limiting implementation in Rust")
    (description
     "This package provides a rate-limiting implementation in Rust.")
    (license license:expat)))

(define-public rust-librespot-core-0.6
  (package
    (name "rust-librespot-core")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1rs4bv62kx3r00d69cyv6bx74k8c8b5200iqz5crm56gxw1n7iy4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-aes" ,rust-aes-0.8)
                       ("rust-base64" ,rust-base64-0.22)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-data-encoding" ,rust-data-encoding-2)
                       ("rust-form-urlencoded" ,rust-form-urlencoded-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-governor" ,rust-governor-0.6)
                       ("rust-hmac" ,rust-hmac-0.12)
                       ("rust-http" ,rust-http-1)
                       ("rust-http-body-util" ,rust-http-body-util-0.1)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-hyper" ,rust-hyper-1)
                       ("rust-hyper-proxy2" ,rust-hyper-proxy2-0.1)
                       ("rust-hyper-rustls" ,rust-hyper-rustls-0.27)
                       ("rust-hyper-util" ,rust-hyper-util-0.1)
                       ("rust-librespot-oauth" ,rust-librespot-oauth-0.6)
                       ("rust-librespot-protocol" ,rust-librespot-protocol-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nonzero-ext" ,rust-nonzero-ext-0.3)
                       ("rust-num-bigint" ,rust-num-bigint-0.4)
                       ("rust-num-derive" ,rust-num-derive-0.4)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-pbkdf2" ,rust-pbkdf2-0.12)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-priority-queue" ,rust-priority-queue-2)
                       ("rust-protobuf" ,rust-protobuf-3)
                       ("rust-quick-xml" ,rust-quick-xml-0.36)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rsa" ,rust-rsa-0.9)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-sha1" ,rust-sha1-0.10)
                       ("rust-shannon" ,rust-shannon-0.2)
                       ("rust-sysinfo" ,rust-sysinfo-0.31)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-stream" ,rust-tokio-stream-0.1)
                       ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.24)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-vergen-gitcl" ,rust-vergen-gitcl-1))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The core functionality provided by librespot")
    (description
     "This package provides The core functionality provided by librespot.")
    (license license:expat)))

(define-public rust-librespot-audio-0.6
  (package
    (name "rust-librespot-audio")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "librespot-audio" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1f5sd0a68v16irrzk9saj151295mxndxvfv1dj9l4c2mwxpmc1vy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-aes" ,rust-aes-0.8)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-ctr" ,rust-ctr-0.9)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-http-body-util" ,rust-http-body-util-0.1)
                       ("rust-hyper" ,rust-hyper-1)
                       ("rust-hyper-util" ,rust-hyper-util-0.1)
                       ("rust-librespot-core" ,rust-librespot-core-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/librespot-org/librespot")
    (synopsis "The audio fetching logic for librespot")
    (description
     "This package provides The audio fetching logic for librespot.")
    (license license:expat)))

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
    (license (list license:asl2.0  license:asl2.0
                   license:expat))))

(define-public rust-rustix-1
  (package
    (name "rust-rustix")
    (version "1.0.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rustix" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1gsqrw9cp762ps9dl1d13n8mk5r0b6r2s002l1njxfylilwify6r"))))
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
    (license (list license:asl2.0  license:asl2.0
                   license:expat))))

(define-public rust-gethostname-1
  (package
    (name "rust-gethostname")
    (version "1.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "gethostname" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "17l5hgpfkjl3wbs2vbnwk2bwm8b8cvvkcrhf7r8n7pmvgbjk2wgd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustix" ,rust-rustix-1)
                       ("rust-windows-targets" ,rust-windows-targets-0.52))))
    (home-page "https://github.com/swsnr/gethostname.rs")
    (synopsis "gethostname for all platforms")
    (description "This package provides gethostname for all platforms.")
    (license license:asl2.0)))

(define-public rust-fern-0.7
  (package
    (name "rust-fern")
    (version "0.7.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "fern" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0a9v59vcq2fgd6bwgbfl7q6b0zzgxn85y6g384z728wvf1gih5j3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-chrono" ,rust-chrono-0.4)
                       ("rust-colored" ,rust-colored-2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-reopen" ,rust-reopen-0.3)
                       ("rust-reopen" ,rust-reopen-1)
                       ("rust-syslog" ,rust-syslog-3)
                       ("rust-syslog" ,rust-syslog-4)
                       ("rust-syslog" ,rust-syslog-6)
                       ("rust-syslog" ,rust-syslog-7))))
    (home-page "https://github.com/daboross/fern")
    (synopsis "Simple, efficient logging")
    (description "This package provides Simple, efficient logging.")
    (license license:expat)))

(define-public rust-redox-users-0.5
  (package
    (name "rust-redox-users")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "redox_users" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0awxx66izdw6kz97r3zxrl5ms5f6dqi5l0f58mlsvlmx8wyrsvyx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-libredox" ,rust-libredox-0.1)
                       ("rust-rust-argon2" ,rust-rust-argon2-0.8)
                       ("rust-thiserror" ,rust-thiserror-2)
                       ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://gitlab.redox-os.org/redox-os/users")
    (synopsis "Rust library to access Redox users and groups functionality")
    (description
     "This package provides a Rust library to access Redox users and groups
functionality.")
    (license license:expat)))

(define-public rust-dirs-sys-0.5
  (package
    (name "rust-dirs-sys")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "dirs-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1aqzpgq6ampza6v012gm2dppx9k35cdycbj54808ksbys9k366p0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-option-ext" ,rust-option-ext-0.2)
                       ("rust-redox-users" ,rust-redox-users-0.5)
                       ("rust-windows-sys" ,rust-windows-sys-0.59))))
    (home-page "https://github.com/dirs-dev/dirs-sys-rs")
    (synopsis
     "System-level helper functions for the dirs and directories crates")
    (description
     "This package provides System-level helper functions for the dirs and directories crates.")
    (license (list license:expat license:asl2.0))))

(define-public rust-directories-6
  (package
    (name "rust-directories")
    (version "6.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "directories" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zgy2w088v8w865c11dmc3dih899fgrhvrfp7g83h6v6ai60kx8n"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-dirs-sys" ,rust-dirs-sys-0.5))))
    (home-page "https://github.com/soc/directories-rs")
    (synopsis
     "tiny mid-level library that provides platform-specific standard locations of directories for config, cache and other data on Linux, Windows and macOS by leveraging the mechanisms defined by the XDG base/user directory specifications on Linux, the Known Folder API on Windows, and the Standard Directory guidelines on macOS.")
    (description
     "This package provides a tiny mid-level library that provides platform-specific
standard locations of directories for config, cache and other data on Linux,
Windows and @code{macOS} by leveraging the mechanisms defined by the XDG
base/user directory specifications on Linux, the Known Folder API on Windows,
and the Standard Directory guidelines on @code{macOS}.")
    (license (list license:expat license:asl2.0))))

(define-public rust-aws-lc-sys-0.28
  (package
    (name "rust-aws-lc-sys")
    (version "0.28.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "aws-lc-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zzmrwlh41g18zllmbkggw9s0dy6v0gsfs87z5vwla7dfh5p5xxr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.69)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cmake" ,rust-cmake-0.1)
                       ("rust-dunce" ,rust-dunce-1)
                       ("rust-fs-extra" ,rust-fs-extra-1))))
    (home-page "https://github.com/aws/aws-lc-rs")
    (synopsis
     "AWS-LC is a general-purpose cryptographic library maintained by the AWS Cryptography team for AWS and their customers. It Ñs based on code from the Google BoringSSL project and the OpenSSL project")
    (description
     "This package provides AWS-LC is a general-purpose cryptographic library maintained by the AWS
Cryptography team for AWS and their customers.  It Ñs based on code from the
Google @code{BoringSSL} project and the @code{OpenSSL} project.")
    (license (list license:isc  
                   license:openssl))))

(define-public rust-aws-lc-fips-sys-0.13
  (package
    (name "rust-aws-lc-fips-sys")
    (version "0.13.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "aws-lc-fips-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "15fpxrq5ckix6vkabh5rx160rrrrhsb8l1cbqz5yhmqz5aajx71d"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.69)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cmake" ,rust-cmake-0.1)
                       ("rust-dunce" ,rust-dunce-1)
                       ("rust-fs-extra" ,rust-fs-extra-1)
                       ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/aws/aws-lc-rs")
    (synopsis
     "AWS-LC is a general-purpose cryptographic library maintained by the AWS Cryptography team for AWS and their customers. This is the FIPS validated version of AWS-LC")
    (description
     "This package provides AWS-LC is a general-purpose cryptographic library maintained by the AWS
Cryptography team for AWS and their customers.  This is the FIPS validated
version of AWS-LC.")
    (license (list license:isc  
                   license:openssl))))

(define-public rust-aws-lc-rs-1
  (package
    (name "rust-aws-lc-rs")
    (version "1.13.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "aws-lc-rs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0y08lzplcfcyqhlb1xvzmsf8whp2wq2xbp561a8dry5jkj9mddqr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-aws-lc-fips-sys" ,rust-aws-lc-fips-sys-0.13)
                       ("rust-aws-lc-sys" ,rust-aws-lc-sys-0.28)
                       ("rust-untrusted" ,rust-untrusted-0.7)
                       ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://github.com/aws/aws-lc-rs")
    (synopsis
     "aws-lc-rs is a cryptographic library using AWS-LC for its cryptographic operations. This library strives to be API-compatible with the popular Rust library named ring")
    (description
     "This package provides aws-lc-rs is a cryptographic library using AWS-LC for its cryptographic
operations.  This library strives to be API-compatible with the popular Rust
library named ring.")
    (license (list license:isc  ))))

(define-public spotifyd-dbus
  (package
    (name "spotifyd")
    (version "0.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "spotifyd" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1m0z1q35by9wskjy2imnf8g8liy4g2ljyd69z6fryvvw64j0qzd6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-alsa" ,rust-alsa-0.9)
                       ("rust-aws-lc-rs" ,rust-aws-lc-rs-1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-clap" ,rust-clap-4)
                       ("rust-color-eyre" ,rust-color-eyre-0.6)
                       ("rust-daemonize" ,rust-daemonize-0.5)
                       ("rust-dbus" ,rust-dbus-0.9)
                       ("rust-dbus-crossroads" ,rust-dbus-crossroads-0.5)
                       ("rust-dbus-tokio" ,rust-dbus-tokio-0.7)
                       ("rust-directories" ,rust-directories-6)
                       ("rust-fern" ,rust-fern-0.7)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-gethostname" ,rust-gethostname-1)
                       ("rust-hex" ,rust-hex-0.4)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-librespot-audio" ,rust-librespot-audio-0.6)
                       ("rust-librespot-connect" ,rust-librespot-connect-0.6)
                       ("rust-librespot-core" ,rust-librespot-core-0.6)
                       ("rust-librespot-discovery" ,rust-librespot-discovery-0.6)
                       ("rust-librespot-metadata" ,rust-librespot-metadata-0.6)
                       ("rust-librespot-oauth" ,rust-librespot-oauth-0.6)
                       ("rust-librespot-playback" ,rust-librespot-playback-0.6)
                       ("rust-librespot-protocol" ,rust-librespot-protocol-0.6)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-pledge" ,rust-pledge-0.4)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-ignored" ,rust-serde-ignored-0.1)
                       ("rust-sha-1" ,rust-sha-1-0.10)
                       ("rust-syslog" ,rust-syslog-7)
                       ("rust-thiserror" ,rust-thiserror-2)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-stream" ,rust-tokio-stream-0.1)
                       ("rust-toml" ,rust-toml-0.8)
                       ("rust-url" ,rust-url-2)
                       ("rust-whoami" ,rust-whoami-1))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.11))
       #:features (list "alsa_backend"
                        "dbus_mpris"
                        "pulseaudio_backend"
                        "portaudio_backend"
                        "rodio_backend"
                        "rodiojack_backend")))
    (native-inputs (list pkg-config))
    (inputs (list alsa-lib dbus pulseaudio portaudio jack-2))
    (home-page "https://github.com/Spotifyd/spotifyd")
    (synopsis "Spotify daemon")
    (description "This package provides a Spotify daemon.")
    (license license:gpl3)))
