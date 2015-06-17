#lang racket

(require web-server/templates
         web-server/http/response-structs
         web-server/http/request-structs)

(provide response/default template form-value)

(define (response/default #:code      [code 200]
                          #:message   [message #"Okay"]
                          #:seconds   [seconds (current-seconds)]
                          #:mime-type [mime-type TEXT/HTML-MIME-TYPE]
                          #:headers   [headers '()]
                          ;; #:cookies   [cookies '()]
                          #:body      [body '(#"")])
  (response/full code message seconds mime-type headers body))

;; TODO: Figure out how the hell macro scoping works to get
;; "templates/" appended to the syntax rule.
(define-syntax template
  (syntax-rules ()
    [(_ . p)
     (list (string->bytes/utf-8 (include-template . p)))]))

(define (form-value id req)
  (define val (bindings-assq id (request-bindings/raw req)))
  (when (binding:form? val)
    (bytes->string/utf-8 (binding:form-value val))))
