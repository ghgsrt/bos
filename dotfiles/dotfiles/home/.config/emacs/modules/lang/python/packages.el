;; -*- no-byte-compile: t; -*-
;;; lang/python/packages.el

;; Major modes
(package! pip-requirements :pin "31e0dc62abb2d88fa765e0ea88b919d756cc0e4f")
(when (modulep! +cython)
  (package! cython-mode :pin "3e4790559d3168fe992cf2aa62f01423038cedb5")
  (when (modulep! :checkers syntax)
    (package! flycheck-cython :pin "ecc4454d35ab5317ab66a04406f36f0c1dbc0b76")))

;; LSP
(when (modulep! +lsp)
  (unless (modulep! :tools lsp +eglot)
    (when (modulep! +pyright)
      (package! lsp-pyright :pin "dd54b3ae7c22d34faaced7b1a89739063c552b1f"))))

;; Programming environment
(package! anaconda-mode :pin "5c6eff46458408c5a456ad216448109964aa5de4")
(when (modulep! :completion company)
  (package! company-anaconda :pin "0f7984b3bee46c6c376b7c4b88f2e885bc2b12df"))

;; Environment management
(package! pipenv :pin "3af159749824c03f59176aff7f66ddd6a5785a10")
(package! pyvenv :pin "31ea715f2164dd611e7fc77b26390ef3ca93509b")
(when (modulep! +pyenv)
  (package! pyenv-mode :pin "f7d53796d6d9d26df9f694299b7f67a1536ac462"))
(when (modulep! +conda)
  (package! conda :pin "05de0c8f0cf336d90c044446aaa066ee13001b83"))
(when (modulep! +poetry)
  (package! poetry :pin "1dff0d4a51ea8aff5f6ce97b154ea799902639ad"))

;; Testing frameworks
(package! nose :pin "f8528297519eba911696c4e68fa88892de9a7b72")
(package! python-pytest :pin "25d9801562a789ea5debceb1992bd528ebb4f689")

;; Import managements
(package! pyimport :pin "4398ce8dd64fa0f685f4bf8683a35087649346d3")
(package! py-isort :pin "e67306f459c47c53a65604e4eea88a3914596560")
