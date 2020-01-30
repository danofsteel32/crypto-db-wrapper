;;;; crypto-db-wrapper.asd

(asdf:defsystem #:crypto-db-wrapper
  :description "crypto-db-wrapper: Set of functions for querying price_db"
  :author "Dan Davis <dan@nthdegreesoftware.com>"
  :license  "BSD-style"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-dbi)
  :components ((:file "package")
               (:file "crypto-db-wrapper")))
