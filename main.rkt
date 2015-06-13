#lang racket/base

(require "server.rkt"
         "db.rkt"
         racket/cmdline
         web-server/servlet-env)

(define (serve [port 8888])
  (displayln "Initializing database.")
  (db-init)
  (displayln (format "Running server on 0.0.0.0:~s" port))
  (serve/servlet start
                 #:port port
                 #:servlet-regexp #rx""
                 #:command-line? #t))

(command-line #:program "web-server name"
              #:usage-help
              "Available commands:"
              "  serve: start server"
              "  db-reset: reset database"
              #:args (cmd)
              (case cmd
                [("serve") (serve)]
                [("db-reset") (db-reset)]
                [else (printf "~s is not a command.\n" cmd)]))
