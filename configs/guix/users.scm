(define-module (users)
  #:use-module (gnu system accounts))

(define-public user/ghgsrt
  (user-account
    (name "ghgsrt")
    (comment "ghgsrt")
    (group "users")
    (home-directory "/home/ghgsrt")
    (supplementary-groups '("wheel"
			    "netdev"
			    "audio"
			    "input"
			    "tty"
			    "video"
			    "seat"
			    "lp"))))

(define-public user/bosco
  (user-account
    (name "bosco")
    (comment "Bosco")
    (group "users")
    (home-directory "/home/bosco")
    (supplementary-groups '("wheel"
			    "netdev"
			    "audio"
			    "input"
			    "tty"
			    "video"
			    "seat"
			    "lp"))))

(define-public users/bos 
  (list user/ghgsrt
	user/bosco))

