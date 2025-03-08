;; -*- no-byte-compile: t; -*-
;;; completion/vertico/packages.el

(package! vertico :pin "ac82acf177a0dfc97deac8626a8a98c06bffc96c")

(package! orderless :pin "c7cb04499d94ee1c17affb29b1cfcd2a45116c97")

(package! consult :pin "ce38dd037769ccba93e7b854ab9b0cc0eced84ee")
(package! consult-dir :pin "6cb46395df8f02ec5e5f4b58a08281e6981fda15")
(when (modulep! :checkers syntax -flymake)
  (package! consult-flycheck :pin "3bc2141daf8cfad7e4d2e2f78b15d45033f707a5"))
(package! embark :pin "d5df0eff182b014ab49328a4dbb1d69eb7faafbd")
(package! embark-consult :pin "d5df0eff182b014ab49328a4dbb1d69eb7faafbd")

(package! marginalia :pin "a527fb03b76a2bce1e360c6e73a095e06922c3f3")

(package! wgrep :pin "49f09ab9b706d2312cab1199e1eeb1bcd3f27f6f")

(when (modulep! +icons)
  (package! nerd-icons-completion :pin "8e5b995eb2439850ab21ba6062d9e6942c82ab9c"))

(when (modulep! +childframe)
  (package! vertico-posframe
    :recipe (:host github :repo "tumashu/vertico-posframe")
    :pin "c5a8b5f72a582e88a2a696a3bbc2df7af28bd229"))

(when (modulep! :editor snippets)
  (package! consult-yasnippet :pin "834d39acfe8a7d2c304afbe4d649b9372118c756"))
