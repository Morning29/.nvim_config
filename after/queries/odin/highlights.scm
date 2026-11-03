;; extends

(continue_statement
  (identifier) @label (#set! priority 140))

(break_statement
  (identifier) @label (#set! priority 140))

(attributes
  (attribute
    (identifier) @attribute.odin (#set! priority 140)))

; (call_expression
;   function: (identifier) @function.call (#set! priority 140))

(member_expression
 (identifier)
 (call_expression
   function: (identifier) @function.call (#set! priority 140)))
