(defun pd-comment-dwim (arg)
    (interactive "*P")
    (require 'newcomment)
    (let (
	  (comment-start "//") (comment-end "")
	  )
      (comment-dwim arg)))

(setq pd-keywords-lvl0 '("abstract"
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
			 "class" ))

(setq pd-keywords-lvl1 '("assert"
			 "build"
			 "const"
			 "function"
			 "ghost"
			 "nonmember"
			 "opaque"
			 "property"
			 "schema"
			 "selector"
			 "var"))

(setq pd-keywords-lvl2 '("after"
			 "any"
			 "begin"
			 "catch"
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

(setq pd-keywords-lvl0-regexp	(regexp-opt pd-keywords-lvl0 'words))
(setq pd-keywords-lvl1-regexp	(regexp-opt pd-keywords-lvl1 'words))
(setq pd-keywords-lvl2-regexp	(regexp-opt pd-keywords-lvl2 'words))
(setq pd-types-regexp		(regexp-opt pd-types 'words))
(setq pd-constants-regexp	(regexp-opt pd-constants 'words))

(setq pd-function-name-regexp	"function\s*\\([^ ]+?\\)\s*[\(;:]")
(setq pd-function2-name-regexp	"function\s*\!?\s*\\([^ ]+?\\)\s*:")
(setq pd-class-name-regexp	"class\s*\\([^ ]+?\\)\s*^=")
(setq pd-schema-name-regexp	"schema\s*\\([^ ]+?\\)\s*[\(:]")

(setq pd-of-types-name-regexp	"of\s*\\([^ \(\)]+?\\)\s*\n")
(setq pd-colon-types-name-regexp	"\s*[^\]:]\s*:\s*\\([^: ]+?\\)\s*[;,\)}\s*\n]")
(setq pd-vars-name-regexp	"[\(\{\,]\s*\\([^ ]+?\\)\s*:")
(setq pd-var-vars-name-regexp	"var\s*\\([^ ]+?\\)\s*:")
(setq pd-const-vars-name-regexp	"const\s*\\([^ ]+?\\)\s*^=")

(setq pd-operator-regexp	"operator[\+-\\*%]\s*")


(setq pd-font-lock-keywords
      `(
	(,pd-function-name-regexp	. (1 font-lock-variable-name-face))
	(,pd-function2-name-regexp	. (1 font-lock-variable-name-face))
	(,pd-class-name-regexp		. (1 font-lock-variable-name-face))
	(,pd-schema-name-regexp		. (1 font-lock-variable-name-face))

	(,pd-of-types-name-regexp	. (1 font-lock-string-face))
	(,pd-colon-types-name-regexp	. (1 font-lock-string-face))
	(,pd-vars-name-regexp		. (1 font-lock-variable-name-face))
	(,pd-var-vars-name-regexp	. (1 font-lock-variable-name-face))
	(,pd-const-vars-name-regexp	. (1 font-lock-variable-name-face))

	(,pd-operator-regexp		. (1 font-lock-function-name-face))

	(,pd-keywords-lvl0-regexp	. font-lock-keyword-face)
	(,pd-keywords-lvl1-regexp	. font-lock-function-name-face)
	(,pd-keywords-lvl2-regexp	. font-lock-keyword-face)
	(,pd-constants-regexp		. font-lock-constant-face)
	(,pd-types-regexp		. font-lock-string-face)
	)
      )

(defvar pd-syntax-table nil "Syntax table for `pd-mode'.")
(setq pd-syntax-table
      (let ((synTable (make-syntax-table)))
	(modify-syntax-entry ?\/ ". 12b" synTable)
	(modify-syntax-entry ?\n "> b" synTable)
	     synTable))

(define-derived-mode pd-mode prog-mode
  "pd-mode is a major mode for editing language Perfect developer."
  :syntax-table pd-syntax-table
  (setq font-lock-defaults '((pd-font-lock-keywords)))
  (setq mode-name "Perfect developer")
  (define-key pd-mode-map [remap comment-dwim] 'pd-comment-dwim)
  )

(provide 'pd-mode)
