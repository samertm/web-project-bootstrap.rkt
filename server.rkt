#lang web-server

(provide interface-version stuffer start)
(define interface-version 'stateless)

;; start is the entry point for your server.
(define (start req)
  (site-router req))

;; Router:

(define-values (site-router site-url)
  ;; See http://docs.racket-lang.org/web-server/dispatch.html for
  ;; dispatch-rules syntax.
  (dispatch-rules
   [("") serve-home]))

;; Request handlers:

(define (serve-home req)
  (response/xexpr
   `(html
     (body
      (p "Sample website homepage")))))
