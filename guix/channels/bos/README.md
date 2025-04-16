## Bos
#### My Personal Guix Channel

To use, add the following to your channels list in channels.scm:
```scheme
(channel
    (name 'bos)
    (url "https://github.com/ghgsrt/guix-channel-bos")
    (introduction
        (make-channel-introduction
            "abe16f8800a5065473158e40af1fcdd44cda6b15"
            (openpgp-fingerprint
                "9698 FD97 58A6 94F4 DD5C  C953 AE35 5160 48EE FBFB"))))
```

