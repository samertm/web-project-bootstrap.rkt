#lang racket/base

;; TODO: Use an ORM?

(require db
         racket/system
         racket/match)

(provide db-conn db-reset db-init)

(define db-name "sample-db.sqlite3")

(define db-conn
  (virtual-connection
   (connection-pool
    (lambda () (sqlite3-connect	#:database db-name
                                #:mode 'create)))))

(define (db-reset)
  (for ([q '("DROP TABLE IF EXISTS sample_table_1"
             "DROP TABLE IF EXISTS sample_table_2")])
    (query-exec db-conn q))
  (db-init))

(define (db-init)
  (for ([q '("CREATE TABLE IF NOT EXISTS sample_table_1 (
id         INTEGER PRIMARY KEY
)"
             "CREATE TABLE IF NOT EXISTS sample_table_2 (
id      INTEGER PRIMARY KEY
)"
             )])
    (query-exec db-conn q)))
