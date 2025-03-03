(define-module (bos system wsl empty)
  #:use-module (gnu)
  #:use-module (gnu packages tls)
  #:use-module (gnu services ssh)
  #:use-module (gnu services networking)
  #:use-module (gnu packages version-control)
  #:use-module (guix channels)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:use-module (ice-9 pretty-print)
  #:use-module (srfi srfi-1))

(define-public empty-wsl-system
  (operating-system
   (host-name "bos-guix")
   (keyboard-layout (keyboard-layout "us"))
   (locale "en_US.utf8")
   (timezone "America/New_York")

   ;; User account
   (users (cons (user-account
                 (name "wsl")
                 (group "users")
                 (home-directory "/home/wsl")
                 (supplementary-groups '("wheel")))
                %base-user-accounts))

   (kernel hello)
   (initrd (lambda* (. rest) (plain-file "dummyinitrd" "dummyinitrd")))
   (initrd-modules '())
   (firmware '())

   (packages (list openssl))

   (bootloader
    (bootloader-configuration
     (bootloader
      (bootloader
       (name 'dummybootloader)
       (package hello)
       (configuration-file "/dev/null")
       (configuration-file-generator (lambda* (. rest) (computed-file "dummybootloader" #~(mkdir #$output))))
       (installer #~(const #t))))))

   (file-systems (list (file-system
                        (device "/dev/sdb")
                        (mount-point "/")
                        (type "ext4")
                        (mount? #t))))

   (services (list (service guix-service-type)
                   (service special-files-service-type
                            `(("/usr/bin/env" ,(file-append coreutils "/bin/env"))))))))

empty-wsl-system
