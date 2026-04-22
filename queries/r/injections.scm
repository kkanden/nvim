; extends

; injects only the second argument
; dbGetQuery(conn, "select * from dupa")
(call
  function: [
     (identifier) @_fn
     (namespace_operator
       rhs: (identifier) @_fn)
   ]
  arguments: (arguments
    .
    (argument)
    (comma)
    .
    (argument
      value: (string
        content: (string_content) @injection.content)))
 (#match? @_fn "^(dbGetQuery|dbExecute|dbSendQuery|dbSendStatement|dbGetStatement|sqlQuery|sqlExecute|odbcQuery|odbcExecute)$")
 (#set! injection.language "sql"))

; generic keyword argument
(call
  arguments: (arguments
    (argument
      name: (identifier) @_param
      value: (string
               (string_content) @injection.content)))
  (#match? @_param "^(query|statement|sql|SQL)$")
  (#set! injection.language "sql"))
