;;;; crypto-db-wrapper.lisp

(in-package #:crypto-db-wrapper)

;;; Globally defined connection object
(defvar *connection*
  (dbi:connect :postgres
	       :database-name "price_db"
	       :username "dan"
	       :password "Coffee32"))

;;(defvar *tickers* '())

;;; make-candle
(defun make-candle (ticker exchange period unixtime open high low close volume)
  (list :TICKER ticker
	:EXCHANGE exchange
	:PERIOD period
	:UNIXTIME unixtime
	:OPEN open
	:HIGH high
	:LOW low
	:CLOSE close
	:VOLUME volume))

;;; get-destinct-on-column
(defun get-tickers ()
  (let* ((query (dbi:prepare *connection*
			     "SELECT DISTINCT(ticker) from candles_table"))
	  (result (dbi:execute query)))
    (loop for ticker = (dbi:fetch result)
	  while ticker
	  do (format t "~A~%" ticker))))

;;; get-candles "btcusd" "bitstamp" 3600 
(defun get-candles (ticker exchange period)
  (dbi:with-connection (conn :postgres :database-name "price_db" :username "dan" :password "Coffee32")
    (let* ((sql "SELECT * FROM candles_table WHERE ticker = ? and exchange = ? and period = ? ORDER BY unixtime DESC LIMIT 1")
	   (query (dbi:prepare conn sql))
	   (query (dbi:execute query ticker exchange period)))
      (loop for row = (dbi:fetch query)
	    while row
	    do (format t "~A~%" row)))))
