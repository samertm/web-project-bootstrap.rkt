# web-project-bootstrap.rkt

This project is a skeleton for bootstrapping new web projects in
Racket.

# Usage

```
 $ racket main.rkt serve    # Start the server.
 $ racket main.rkt db-reset # Reset the database.
 $ racket main.rkt help     # Show help.
```

# Info

Define routes and route handlers in `server.rkt`. Define your database
schema in `db.rkt`. Define command line dispatches in `main.rkt`.

# TODO

 - Find an ORM.
 - Write tutorial for dealing with form data.
