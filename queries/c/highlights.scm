;; extends

((identifier) @constant.builtin
 (#eq? @constant.builtin "null"))

((identifier) @operator
 (#eq? @operator "size_of"))

((type_identifier) @keyword
 (#eq? @keyword "global"))
((type_identifier) @keyword
 (#eq? @keyword "proc"))
((type_identifier) @keyword
 (#eq? @keyword "local_perisist"))

(call_expression
  function: (identifier) @assert
  (#eq? @assert "assert"))
(call_expression
  function: (identifier) @keyword.cast
  (#eq? @keyword.cast "cast"))

; C3 specific
((type_identifier) @keyword
 (#eq? @keyword "fn"))
((type_identifier) @keyword
 (#eq? @keyword "foreach"))
((type_identifier) @keyword
 (#eq? @keyword "constdef"))
((type_identifier) @keyword
 (#eq? @keyword "import"))
((type_identifier) @keyword
 (#eq? @keyword "macro"))

