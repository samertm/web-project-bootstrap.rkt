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
    (lambda () (sqlite3-connect	#:database db-name)))))

(define (db-reset)
  (when (not (file-exists? db-name))
    ;; Create db.
    (system (string-append "sqlite3 -cmd '.save " db-name "'")))
  (for ([q '("DROP TABLE IF EXISTS sample_table_1"
             "DROP TABLE IF EXISTS sample_table_2")])
    (query-exec db-conn q))
  (db-init))

;; TODO: Nop for now, figure out how to write to the stdin of a
;; process.
(define (db-init) #f)
;;   (when (not (file-exists? db-name))
;;     ;; Create db.
;;     (match-let ([(list stdout stdin _ stderr control) (process "sqlite3 -batch")])
;;       (write (string-append "-cmd '.save " db-name "'") stdin)
;;       (write eof stdin)
;;       (control 'wait)
;;       (close-output-port stdin)
;;       (close-input-port stdout)
;;       (close-input-port stderr))
;;     (for ([q '("CREATE TABLE IF NOT EXISTS sample_table_1 (
;; id         INTEGER PRIMARY KEY
;; )"
;;                "CREATE TABLE IF NOT EXISTS sample_table_2 (
;; id      INTEGER PRIMARY KEY
;; )"
;;                )])
;;       (query-exec db-conn q))))
