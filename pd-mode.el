(defun pd-comment-dwim (arg)
    (interactive "*P")
    (require 'newcomment)
    (let (
	  (comment-start "//") (comment-end "")
	  )
      (comment-dwim arg)))

(setq pd-keywords-lvl0 '("abstract"
			 "assert"
			 "class"
			 "confined"
			 "deferred"
			 "end"
			 "final"
			 "import"
			 "interface"
			 "internal"
			 "invariant"
			 "post"
			 "pre"
			 "property"
			 "class" ))

(setq pd-keywords-lvl1 '("build"
			 "function"
			 "ghost"
			 "nonmember"
			 "opaque"
			 "schema"
			 "selector"
			 "var"))




(setq pd-keywords-lvl2 '("after"
			 "any"
			 "begin"
			 "catch"
			 "const"
			 "decrease"
			 "done"
			 "exists"
			 "fi"
			 "for"
			 "forall"
			 "goto"
			 "has"
			 "if"
			 "in"
			 "inherits"
			 "keep"
			 "let"
			 "like"
			 "loop"
			 "over"
			 "par"
			 "pass"
			 "proof"
			 "rank"
			 "satisfy"
			 "self"
			 "storable"
			 "that"
			 "then"
			 "those"
			 "throw"
			 "try"
			 "value"
			 "via"
			 "within"
			 "yield"))

(setq pd-types '("as"
		 "bag"
		 "enum"
		 "map"
		 "of"
		 "pair"
		 "seq"
		 "set"
		 "triple"))

(setq pd-constants '("true"
		     "false"
		     "null"
		     ))



;; (setq pd-keywords-mnr '("in" "for" "ghost" "those" "forall" "let" "yield" "over" "that" "try" "throw" "self" "pragma" "it" "any" "after" "catch" "goto" "import" "exists" "pass" "property" "satisfy" ))
;; (setq pd-vars '("map" "set" "queue" "bag" "seq" "pair" "of" "enum" "triple" "as"))
;; (setq pd-functions '("function" "schema" "build" "var"))
;; (setq pd-constants '("true" "false" "null"))

(setq pd-keywords-lvl0-regexp	(regexp-opt pd-keywords-lvl0 'words))
(setq pd-keywords-lvl1-regexp	(regexp-opt pd-keywords-lvl1 'words))
(setq pd-keywords-lvl2-regexp	(regexp-opt pd-keywords-lvl2 'words))
(setq pd-types-regexp		(regexp-opt pd-types 'words))
(setq pd-constants-regexp	(regexp-opt pd-constants 'words))

(setq pd-function-name-regexp	"function\s*\\([^ ]+?\\)\s*[\(;:]")
(setq pd-function2-name-regexp	"function\s*\!?\s*\\([^ ]+?\\)\s*:")
(setq pd-class-name-regexp	"class\s*\\([^ ]+?\\)\s*.=")
(setq pd-schema-name-regexp	"schema\s*\\([^ ]+?\\)\s*[\(:]")


(setq pd-font-lock-keywords
      `(
	 ;; ("class\s*\\([^ ]+?\\)\s*.=" . ( 1 font-lock-comment-face))
	;; ("function\s*\\([^ ]+?\\)\s*\(" . ( 1 font-lock-comment-face))
	;; ("function\s*\\([^ ]+?\\)\s*;" . ( 1 font-lock-comment-face))
	;; ("function\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	;; ("schema\s*\\([^ ]+?\\)\s*[\(:]" . ( 1 font-lock-comment-face))
	;; ("function\s*\!\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))

	(,pd-function-name-regexp	. (1 font-lock-variable-name-face))
	(,pd-function2-name-regexp	. (1 font-lock-variable-name-face))
	(,pd-class-name-regexp		. (1 font-lock-variable-name-face))
	(,pd-schema-name-regexp		. (1 font-lock-variable-name-face))

	;; ("\s*[^\]:]\s*:\s*\\([^: ]+?\\)\s*[;,\)}\s*\n]" . ( 1 font-lock-string-face))
	;; ("of\s*\\([^ \(\)]+?\\)\s*\n" . ( 1 font-lock-string-face))

	;; ("(\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	;; ("{\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	;; ("var\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	;; (",\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))

	;; ("operator[\+-\\*%]"	 . font-lock-function-name-face)


	;; (,pd-constants-regexp	 . font-lock-function-name-face) 
	(,pd-keywords-lvl0-regexp . font-lock-keyword-face)
	(,pd-keywords-lvl1-regexp . font-lock-function-name-face)
	(,pd-keywords-lvl2-regexp . font-lock-keyword-face)
	(,pd-constants-regexp	 . font-lock-constant-face)
	(,pd-types-regexp	 . font-lock-string-face)
	)
      )

(defvar pd-syntax-table nil "Syntax table for `pd-mode'.")
(setq pd-syntax-table
      (let ((synTable (make-syntax-table)))
	(modify-syntax-entry ?\/ ". 12b" synTable)
	(modify-syntax-entry ?\n "> b" synTable)
	     synTable))

(define-derived-mode pd-mode fundamental-mode
  "pd-mode is a major mode for editing language Perfect developer."
  :syntax-table pd-syntax-table
  (setq font-lock-defaults '((pd-font-lock-keywords)))
  (setq mode-name "Perfect developer")
  (define-key pd-mode-map [remap comment-dwim] 'pd-comment-dwim)
  )

(provide 'pd-mode)
