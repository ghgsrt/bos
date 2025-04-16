(define-module (system extension broadcom)
  #:use-module (system)
  #:use-module (gnu system)
  #:use-module (nongnu packages linux))

(define-public extension/broadcom
  (operating-system
    (inherit system/empty)
    (kernel-arguments '("modprobe.blacklist=b43,b43legacy,ssb,bcm43xx,brcm80211,brcmfmac,brcmsmac,bcma"))
    (kernel-loadable-modules (list broadcom-sta))
    (firmware (list broadcom-bt-firmware))))

