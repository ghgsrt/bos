(define-module (modules)
  #:use-module (utils)
  #:use-module (system)
  #:use-module (home)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (ice-9 string-fun)
  #:export (bos-module
            bos-module?
            bos-module-name
            bos-module-packages
            bos-module-packages-set!
            bos-module-env-vars
            bos-module-env-vars-set!
            bos-module-includes
            bos-module-includes-set!
            bos-module-excludes
            bos-module-excludes-set!

            bos-module->services
            bos-module->home-services

            re-export:modules->services
            re-export:modules->home-services))

(define-record-type <bos-module>
  (make-bos-module name packages env-vars includes excludes)
  bos-module?
  (name bos-module-name)
  (packages bos-module-packages bos-module-packages-set!)
  (env-vars bos-module-env-vars bos-module-env-vars-set!)
  (includes bos-module-includes bos-module-includes-set!)
  (excludes bos-module-excludes bos-module-excludes-set!))

(define* (bos-module name #:key (includes #f) (packages #f) (env-vars #f) (excludes #f))
  (process-module (make-bos-module name packages env-vars includes excludes)))

(define (filter-module-packages mod excludes-list)
  (let ((packages (bos-module-packages mod)))
    (if (not packages)
        '()
        (let ((pkg-list (ensure-list packages)))
          (filter (lambda (pkg)
                    (not (member pkg excludes-list)))
                  pkg-list)))))

(define* (process-module mod #:optional (excludes (ensure-list (bos-module-excludes mod))))
  (unless (null? excludes)
    (for-each (lambda (included-mod)
                (process-module included-mod excludes))
              (ensure-list (bos-module-includes mod)))

    (when (bos-module-packages mod) 
      (bos-module-packages-set! mod (filter-module-packages mod excludes))))

  mod)

(define-syntax re-export:modules->services
  (lambda (x)
    (syntax-case x ()
      ((_ imodule)
       (let* ((module (syntax->datum #'imodule))
              (syms (filter (lambda (x) x) 
                            (module-map
                              (lambda (sym var)
                                (let ((sym-string (symbol->string sym)))
                                  (cond ((string-prefix? "module/" sym-string)
                                         (list sym (string->symbol (string-replace-substring
                                                                     sym-string "module/" "services/"))))
                                        ((string-prefix? "services/" sym-string)
                                         (list sym sym))
                                        (else #f))))
                              (resolve-interface module)))))
         #`(begin
             (use-modules imodule)
             #,@(append-map (lambda (sym)
                              (let ((mod (datum->syntax #'imodule (car sym)))
                                    (name (datum->syntax #'imodule (cadr sym))))
                                (append (if (not (eq? (car sym) (cadr sym)))
                                          (list #`(define #,name (bos-module->services #,mod)))
                                          '())
                                        (list #`(export #,name)))))
                            syms)))))))

(define-syntax re-export:modules->home-services
  (lambda (x)
    (syntax-case x ()
      ((_ imodule)
       (let* ((module (syntax->datum #'imodule))
              (syms (filter (lambda (x) x) 
                            (module-map
                              (lambda (sym var)
                                (let ((sym-string (symbol->string sym)))
                                  (cond ((string-prefix? "module/" sym-string)
                                         (list sym (string->symbol (string-replace-substring
                                                                     sym-string "module/" "home/services/"))))
                                        ((string-prefix? "home/services/" sym-string)
                                         (list sym sym))
                                        (else #f))))
                              (resolve-interface module)))))
         #`(begin
             (use-modules imodule)
             #,@(append-map (lambda (sym)
                              (let ((mod (datum->syntax #'imodule (car sym)))
                                    (name (datum->syntax #'imodule (cadr sym))))
                                (append (if (not (eq? (car sym) (cadr sym)))
                                          (list #`(define #,name (bos-module->home-services #,mod)))
                                          '())
                                        (list #`(export #,name)))))
                            syms)))))))

(define* (bos-module->services module #:optional (extra-services '()))
  (cond ((list? module) (bos-modules->services module extra-services))
        ((not module) '())
        (else (bos-services (bos-module-name module)
                 #:packages (bos-module-packages module)
                 #:env-vars (bos-module-env-vars module)
                 #:services (bos-modules->services (bos-module-includes module) extra-services)))))

(define* (bos-modules->services modules #:optional (extra-services '()))
  (append (append-map bos-module->services (ensure-list modules))
          extra-services))

(define* (bos-module->home-services module #:optional (extra-home-services '()))
  (cond ((list? module) (bos-modules->home-services module extra-home-services))
        ((not module) '())
        (else (bos-home-services (bos-module-name module)
                      #:packages (bos-module-packages module)
                      #:env-vars (bos-module-env-vars module)
                      #:services (bos-modules->home-services (bos-module-includes module) extra-home-services)))))

(define* (bos-modules->home-services modules #:optional (extra-home-services '()))
  (append (append-map bos-module->home-services (ensure-list modules))
          extra-home-services))


;(define-syntax define-re-export
;  (lambda (x)
;    (syntax-case x ()
;      ((_ type)
;       (let ((macro-name (datum->syntax #'x (symbol-append 're-export:modules-> (syntax->datum #'type)))))
;         (display macro-name)
;         (newline)
;         (macroexpand #`(define-syntax #,macro-name
;             (lambda (y)
;               (syntax-case y ()
;                 ((_ imodule)
;                  (let* ((module (syntax->datum #'imodule))
;                         (prefix (string-append (symbol->string (syntax->datum #'type)) "/"))
;                         (syms (filter (lambda (x) x) 
;                                       (module-map
;                                         (lambda (sym var)
;                                           (if (string-prefix? "module/" (symbol->string sym))
;                                             (list sym
;                                                   (string->symbol (string-replace-substring
;                                                                     (symbol->string sym)
;                                                                     "module/"
;                                                                     (string-replace-substring prefix "-" "/"))))
;                                             #f))
;                                         (resolve-interface module)))))
;                    #`(begin
;                        (use-modules imodule)
;                        #,@(append-map (lambda (sym)
;                                         (let ((mod (datum->syntax #'imodule (car sym)))
;                                               (converter (datum->syntax #'imodule (symbol-append 'bos-module-> (syntax->datum #'type))))
;                                               (name (datum->syntax #'imodule (cadr sym))))
;                                           (list #`(define #,name (#,converter #,mod))
;                                                 #`(export #,name))))
;                                       syms)))))))))))))
;
;(define-re-export services)
;(define-re-export home-services)

