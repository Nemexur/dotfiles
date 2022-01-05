;; Copyright to https://github.com/emacs-mirror/emacs/blob/master/lisp/leim/quail/cyrillic.el

;; This was `cyrillic-jcuken'.  Alexander Mikhailian
;; <mikhailian@altern.org> says:  "cyrillic-jcuken" is actually
;; russian.  It is ok but a bit outdated.  This layout has been used
;; in typewriters for ages but it has been superseded on desktops by
;; a variation of this layout, implemented in M$ Windows software.
;; The Windows layout is greatly preferred because of the comma and
;; period being placed more conveniently and, of course, because of
;; the popularity of Windows software. This layout is a common option
;; in X Windows and console layouts for GNU/Linux.  [See
;; `russian-computer' below.]

(require 'quail)

(quail-define-package
 "russian-typewriter" "Russian" "ЖЙ" nil
 "ЙЦУКЕН Russian typewriter layout (ISO 8859-5 encoding)."
 nil t t t t nil nil nil nil nil t)

;;  №1 -2 /3 "4 :5 ,6 .7 _8 ?9 %0 != ;\ |+
;;   Й  Ц  У  К  Е  Н  Г  Ш  Щ  З  Х  Ъ )(
;;    Ф  Ы  В  А  П  Р  О  Л  Д  Ж  Э
;;     Я  Ч  С  М  И  Т  Ь  Б  Ю  Ё

(quail-define-rules
 ("1" ?№)
 ("2" ?-)
 ("3" ?/)
 ("4" ?\")
 ("5" ?:)
 ("6" ?,)
 ("7" ?.)
 ("8" ?_)
 ("9" ??)
 ("0" ?%)
 ("-" ?!)
 ("=" ?\;)
 ("`" ?|)
 ("q" ?й)
 ("w" ?ц)
 ("e" ?у)
 ("r" ?к)
 ("t" ?е)
 ("y" ?н)
 ("u" ?г)
 ("i" ?ш)
 ("o" ?щ)
 ("p" ?з)
 ("[" ?х)
 ("]" ?ъ)
 ("a" ?ф)
 ("s" ?ы)
 ("d" ?в)
 ("f" ?а)
 ("g" ?п)
 ("h" ?р)
 ("j" ?о)
 ("k" ?л)
 ("l" ?д)
 (";" ?ж)
 ("'" ?э)
 ("\\" ?\))
 ("z" ?я)
 ("x" ?ч)
 ("c" ?с)
 ("v" ?м)
 ("b" ?и)
 ("n" ?т)
 ("m" ?ь)
 ("," ?б)
 ("." ?ю)
 ("/" ?ё)

 ("!" ?1)
 ("@" ?2)
 ("#" ?3)
 ("$" ?4)
 ("%" ?5)
 ("^" ?6)
 ("&" ?7)
 ("*" ?8)
 ("(" ?9)
 (")" ?0)
 ("_" ?=)
 ("+" ?\\)
 ("~" ?+)
 ("Q" ?Й)
 ("W" ?Ц)
 ("E" ?У)
 ("R" ?К)
 ("T" ?Е)
 ("Y" ?Н)
 ("U" ?Г)
 ("I" ?Ш)
 ("O" ?Щ)
 ("P" ?З)
 ("{" ?Х)
 ("}" ?Ъ)
 ("A" ?Ф)
 ("S" ?Ы)
 ("D" ?В)
 ("F" ?А)
 ("G" ?П)
 ("H" ?Р)
 ("J" ?О)
 ("K" ?Л)
 ("L" ?Д)
 (":" ?Ж)
 ("\"" ?Э)
 ("|" ?\()
 ("Z" ?Я)
 ("X" ?Ч)
 ("C" ?С)
 ("V" ?М)
 ("B" ?И)
 ("N" ?Т)
 ("M" ?Ь)
 ("<" ?Б)
 (">" ?Ю)
 ("?" ?Ё)
 )

;; Maintain the obsolete name for now.
(push (cons "cyrillic-jcuken"
	    (cdr (assoc "russian-typewriter" quail-package-alist)))
      quail-package-alist)
