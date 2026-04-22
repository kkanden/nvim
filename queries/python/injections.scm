; extends

; spark.sql
(call
  function: (attribute
    object: (identifier) @_spark
    attribute: (identifier) @_sql)
  arguments: (argument_list
    (string
      (string_content) @injection.content))
  (#eq? @_spark "spark")
  (#eq? @_sql "sql")
  (#set! injection.language "sql"))

; generic keyword argument
(call
  arguments: (argument_list
    (keyword_argument
      name: (identifier) @_param
      value: (string
               (string_content) @injection.content)))
  (#match? @_param "^(query|statement|sql|SQL)$")
  (#set! injection.language "sql"))
