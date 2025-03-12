(define-module (users)
  #:use-module (gnu system accounts))

(define-public ghgsrt-user
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

(define-public bosco-user
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

(define-public bos-users 
  (list ghgsrt-user
	bosco-user))

