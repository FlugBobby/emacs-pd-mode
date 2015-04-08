(defun pd-comment-dwim (arg)
    (interactive "*P")
    (require 'newcomment)
    (let (
	  (comment-start "//") (comment-end "")
	  )
      (comment-dwim arg)))




(setq pd-keywords-mjr '("class" "end" "post" "pre" "invariant" "interface" "abstract" "assert" "absurd" "axiom" "ghost"))
(setq pd-keywords-mnr '("in" "for" "those" "forall" "let" "yield" "over" "that" "try" "throw" "self" "pragma" "it" "any" "after" "catch" "goto" "import" "exists" "pass" "property" "satisfy" ))
(setq pd-vars '("map" "set" "queue" "bag" "seq" "pair" "of" "enum" "triple" "as"))
(setq pd-functions '("function" "schema" "build" "var"))
(setq pd-constants '("true" "false" "null"))

(setq pd-keywords-mjr-regexp	(regexp-opt pd-keywords-mjr 'words))
(setq pd-keywords-mnr-regexp	(regexp-opt pd-keywords-mnr 'words))
(setq pd-vars-regexp		(regexp-opt pd-vars 'words))
(setq pd-functions-regexp	(regexp-opt pd-functions 'words))
(setq pd-constants-regexp	(regexp-opt pd-constants 'words))


(setq pd-font-lock-keywords
      `(
	("class\s\\([^ ]+?\\)\s.=" . ( 1 font-lock-comment-face)) 
	("function\s\\([^ ]+?\\)\s*\(" . ( 1 font-lock-comment-face))
	("function\s*\\([^ ]+?\\)\s*;" . ( 1 font-lock-comment-face))
	("function\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face)) 
	("schema\s\\([^ ]+?\\)\s*\(" . ( 1 font-lock-comment-face)) 
	("schema\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face)) 
	("function\s*\!\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face)) 

	("[^\]:]:\s*\\([^: ]+?\\)\s*;" . ( 1 font-lock-string-face)) 
	("[^\]:]:\s*\\([^: ]+?\\)\s*," . ( 1 font-lock-string-face)) 
	("[^\]:]:\s*\\([^: ]+?\\)\s*\)" . ( 1 font-lock-string-face)) 
	("[^\]:]:\s*\\([^: ]+?\\)\s*}" . ( 1 font-lock-string-face)) 
	("[^\]:]:\s*\\([^: ]+?\\)\s*\n" . ( 1 font-lock-string-face))
	("of\s*\\([^ \(\)]+?\\)\s*\n" . ( 1 font-lock-string-face))

	("(\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	("{\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	("var\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))
	(",\s*\\([^ ]+?\\)\s*:" . ( 1 font-lock-comment-face))

	;; ("\s*\\([^ ]+?\\)\@" . ( 1 font-lock-constant-face))

	("operator[\+-\\*%]"	 . font-lock-function-name-face)

	(,pd-keywords-mjr-regexp . font-lock-keyword-face)
	(,pd-keywords-mnr-regexp . font-lock-keyword-face)
	(,pd-constants-regexp	 . font-lock-constant-face)
	(,pd-vars-regexp	 . font-lock-string-face)
	(,pd-functions-regexp	 . font-lock-function-name-face)
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
