(define-module (users)
  #:use-module (gnu system accounts))

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
