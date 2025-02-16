;; extends

(when_statement
 (identifier) @constant (#set! priority 140))

(call_expression
  function: (identifier) @function.call (#set! priority 140))

(member_expression
  "." 
  (identifier) @variable.member (#set! priority 140))

(member_expression
  .
  "." 
  (identifier) @constant (#set! priority 140))
