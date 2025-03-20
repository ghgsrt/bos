(define-module (packages spellcheck)
  #:use-module (gnu packages aspell)
  #:use-module (gnu packages hunspell)
  #:use-module (gnu packages enchant)
  #:export (packages/aspell
	    packages/hunspell
	    packages/nuspell
	    packages/spellcheck
	    packages/spellcheck:full))

(define packages/aspell
  (list aspell
	aspell-dict-en))

(define packages/hunspell
  (list hunspell
	hunspell-dict-en-us))

(define packages/nuspell
  (list nuspell
	hunspell-dict-en-us))

(define packages/spellcheck
  (cons enchant
	packages/hunspell))

(define packages/spellcheck:full
  (cons* enchant
	 ispell
	 packages/aspell
	 packages/hunspell
	 packages/nuspell))

