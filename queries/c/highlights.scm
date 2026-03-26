;; extends

; ((call_expression)
;  function: (identifier) @keyword
;  (#eq? @keyword "cast"))

((identifier) @zero_struct
  (#eq? @zero_struct "zero_struct"))

(call_expression
  function: (identifier) @assert
  (#eq? @assert "assert"))

(call_expression
  function: (identifier) @keyword.cast
  (#eq? @keyword.cast "cast"))

(call_expression
  function: (identifier) @keyword.cast
  arguments: (argument_list (identifier) @type)
  (#eq? @keyword.cast "cast"))

(call_expression
  function: (identifier) @keyword.cast
  arguments: (argument_list
	       (binary_expression
		 left: (identifier)
		 right: (identifier)
		 ) @type)
  (#eq? @keyword.cast "cast"))

(call_expression
  function: (identifier) @keyword.cast
  arguments: (argument_list
	       (binary_expression
		 left: (identifier)
		 right: (number_literal)
		 ) @type)
  (#eq? @keyword.cast "cast"))

(function_definition
  type: (type_identifier)
  (ERROR (identifier)) @type)

((declaration
   type: (type_identifier)
   declarator: (identifier) @type)
 (function_definition
   type: (type_identifier) @function))
