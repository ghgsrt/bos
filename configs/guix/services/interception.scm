(define-module (services interception)
  #:use-module (utils)
  #:use-module (system)

  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)

  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)

  #:export (services/interception))

(define (udevmon-shepherd-service keyboards)
  "Return a shepherd service for udevmon (interception-tools) with KEYBOARD"
  (let ((keyboard-configs (map (lambda (kb)
                                 (string-append "-c /etc/interception/udevmon.d/" kb))
                               keyboards)))
  (list (shepherd-service
          (documentation "Run udevmon for key remapping")
          (provision '(udevmon))
          (start #~(make-forkexec-constructor
                     (cons (string-append #$interception-tools "/bin/udevmon")
                             keyboard-configs)))
          (stop #~(make-kill-destructor))))))

(define udevmon-service-type
  (service-type
    (name 'udevmon)
    (description "Run udevmon from interception-tools")
    (extensions (list (service-extension shepherd-root-service-type
                                         udevmon-shepherd-service)))
    (compose concatenate)
    (extend append)
    (default-value '())))

(define* (services/interception #:optional (keyboard #f))
  (bos-services (if keyboard
                  (string->symbol (string-append keyboard "-udevmon"))
                  'udevmon)
    #:packages (list interception-tools
                     interception-dual-function-keys)
    #:services (service udevmon-service-type (ensure-list keyboard))))

