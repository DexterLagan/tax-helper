;;; defs

(define sample-listbox-contents (list (list "01" "02" "03") (list "Dexter" "John" "Albert")))
(define summary-column-widths '(640 200))
(define details-column-widths '(120 600 120))

; Nicer string-append
(define ++ string-append)

; Fancy echo
(define echo
  (lambda args
    (displayln (apply ~a args))))

; Curried version of string-split
(define (split-comma s)
  (string-split s ","))

; Give the clean name of a procedure
(define (get-proc-name proc)
  (replace2 (~a proc) "#<procedure:" "" ">" ""))

; Replace two strings, not just one
(define (replace2 str from1 to1 from2 to2)
  (string-replace (string-replace str from1 to1) from2 to2))

; Template for transactions
(define transaction-lines null)

; Load transactions from filename
(define (load-transactions f)
  (set! transaction-lines (map split-comma (file->lines f))))

; Get transaction list [typep] [floorp]
; typep - type predicate (transaction string predicate)
; floorp - floor predicate (minimum transaction amount) - optional
(define get-transactions
  (lambda (typep [floorp null])
    (if (null? floorp)
        (filter typep transaction-lines)
        (filter floorp (filter typep transaction-lines)))))

; Display transaction list [typep] [floorp]
; typep - type predicate (transaction string predicate)
; floorp - floor predicate (minimum transaction amount) - optional
(define display-transactions ; supports the specification of a predicate
  (lambda (typep [floorp null])
    (if (null? floorp)
        (for-each displayln
                  (map ~a (filter typep transaction-lines)))
        (for-each displayln
                  (map ~a (filter floorp (filter typep transaction-lines)))))))

; Display transaction list and total [typep] [floorp]
; typep - type predicate (transaction string predicate)
; floorp - floor predicate (minimum transaction amount) - optional
(define display-transactions-and-total
  (lambda (typep [floorp null])
    (if (null? floorp)
        (begin
          (disp typep)
          (echo "                                    Total: " (display-total typep)))
        (begin
          (disp typep floorp)
          (echo "                                    Total: " (display-total typep floorp))))))

; Returns the amount from a string-transaction
(define (get-transaction-amount l)
  (string->number (last l)))

; Get total for a predicate (varargs)
(define get-total
  (lambda (typep [floorp null])
    (string->number
     (real->decimal-string
      (apply +
             (map get-transaction-amount
                  (if (null? floorp)
                      (get-transactions typep)
                      (get-transactions typep floorp))))))))

; Display total for a predicate (varargs)
(define display-total
  (lambda (typep [floorp null])
    (if (null? floorp)
        (display (get-total typep))
        (display (get-total typep floorp)))))

;; Aliases
(define total display-total)
(define disp display-transactions)
(define dispt display-transactions-and-total)
(define get get-transactions)
(define loadt load-transactions)


;; Define a global namespace to allow input-loop eval to understand our commands
(define-namespace-anchor a)
(define input-loop-ns (namespace-anchor->namespace a))

; Template for predicate lists
(define type-predicate-list null)
(define floor-predicate-list null)

; Input loop
(define (input-loop)
  (let/ec break
    (let loop ()
      (display "> ")
      (define command (read-line))
      (cond [(string=? command "exit") (break)]
            [(string=? command "totals") (totals)]
            [(string=? command "help") (help)]
            [(or (string-prefix? command "get ") ; If any of these commands are recognized,
                 (string-prefix? command "disp ")
                 (string-prefix? command "dispt ")
                 (string-prefix? command "total ")
                 (string-prefix? command "defpl ")
                 (string-prefix? command "defpf ")) (begin
                                                      (newline)
                                                      (eval (call-with-input-string (++ "(" command ")") read) input-loop-ns) ; Evaluate directly
                                                      (newline))]
            [else (echo "Unknown command or missing parameter. Type 'help' for help.\n")])
      (loop)))
  (displayln "Goodbye!"))

; Display help info
(define (help)
  (begin
    (echo "\nType 'help' to display this page.")
    (newline)
    (echo "commands:")
    (echo " totals - get a quick summary of business income and expenses (using 3000 floor for credit memos)")
    (echo " get [type] [floor] - get a list of transactions from [type], minimum [floor]")
    (echo " total [type] [floor] - display the total amount from [type], taking transactions with [floor] as minimum")
    (echo " disp [type] [floor] - display a list of transactions from [type], minimum [floor]")
    (echo " dispt [type] [floor] - display a list of transactions from [type], minimum [floor] and calculates the total")
    (echo " defpl [name] [string] - define a new transaction type where [name] a unique identifier and [string] the string to filter with")
    (echo " defpf [name] [amount] - define a new floor where [name] is a unique identifier and [amount] is the floor amount ")
    (echo " exit - quits the program")
    (newline)
    (echo "available types:")
    (echo (++ " " (~a (sort type-predicate-list string<?))))
    (newline)
    (echo "available floors:")
    (echo (++ " " (~a (sort floor-predicate-list string<?))))))

; Quick summary
(define (totals)
  (begin
    (echo "Business Income:")
    (echo " Gross Sales: " (get-total pay min-3000))
    (echo "Home Office Expenses:")
    (echo " Heat: " (get-total gas))
    (echo " Electricity: " (get-total hydro))
    (echo " Insurance: " (+ (get-total insurance) (get-total insurance2)))
    (echo " Mortgage Interest: ~7800")
    (echo " Property Tax: ~2700")
    (echo " Internet: " (get-total bell))
    (echo " Cellphone: " (/ (get-total rogers) 2))
    (newline)))

; Macro that defines a predicate from an id and a string and saves it to a list
(define-syntax-rule (defpl pred str)
  (begin
    (define (pred l)
      (string-contains? (second l) str)) ; If transaction description contains the given keyword
    (set! type-predicate-list
          (cons
           (get-proc-name pred)
           type-predicate-list))))

; Macro that defines a predicate from an id and a floor (minimum amount) and saves it to a list
(define-syntax-rule (defpf pred floor)
  (begin
    (define (pred l)
      (>= (string->number (last l)) floor)) ; If the amount if at least [floor]
    (set! floor-predicate-list
          (cons
           (replace2 (~a pred) "#<procedure:" "" ">" "")
           floor-predicate-list))))


; swap columns and rows for display in a list-box
(define (swap-columns-and-rows l)
  (if (and (cons? l)
           (cons? (first l)))
      (apply map list l)
      #f))

; Helper function to set a list-box's column's width
(define (set-column-width listbox column-index column-width)
  (let ((min-width 20)
        (max-width 640))
    (send listbox set-column-width column-index column-width min-width max-width)))

; Helper function to populate a list-box control
(define (populate-listbox-w-columns listbox listbox-contents column-widths)
  (if (null? listbox-contents) null
      (begin (cond [(null? column-widths)   (for ([i (in-range 0 (length listbox-contents))]) ((curry set-column-width listbox i) 100))]                         ; If no column widths provided, use fixed default width
                   [(number? column-widths) (for ([i (in-range 0 (length listbox-contents))]) ((curry set-column-width listbox i) column-widths))]               ; If one width provided, use fixed specified width
                   [else                    (for ([i (in-range 0 (length column-widths))])    ((curry set-column-width listbox i) (list-ref column-widths i)))]) ; Else, set column widths using list
             (when (cons? listbox-contents)
               (send/apply listbox set listbox-contents)))))

; marshall data into strings in columns and rows for display in a listbox
(define (get-data l)
  (swap-columns-and-rows (force-string l)))

; convert sub-list to string
(define (force-string l)
  (if (and (cons? l)
           (cons? (first l)))
      (map (λ (l1) (map ~a l1)) l)
      #f))

; second level remove (to remove something from a sub-list
(define (remove2 what l)
  (if (and (cons? l)
           (cons? (first l)))
      (map (λ (l1) (remove what l1)) l)
      #f))

; asks user to select a file and load it
(define (load-and-compute)
  (let ((file (get-file)))
    (if file (begin (loadt file)         
                    (compute-and-populate))
        (void))))

; display an about dialog
(define (display-about-dialog)
  (message-box appname (string-append appname "\nby Dexter Santucci\n(c) Gluten Free Software 2018")))

; computer all values and lists, display them
(define (compute-and-populate)
  ; collect some lists
  (define summary-data
    (list (list "Gross Sales"
                "Babysitting"
                "Heat"
                "Hydro"
                "Insurance (Home + Car)"
                "Mortage Interest (Est.)"
                "Property Tax (Est.)"
                "Internet"
                "CellPhone"
                "Water")
          (list (get-total pay min-3000)
                (get-total cheques maria-400)
                (get-total gas)
                (get-total hydro)
                (+ (get-total insurance) (get-total insurance2))
                7800
                2800
                (get-total bell)
                (/ (get-total rogers) 2)
                (get-total water))))
  (define biz-income-data (get-data (remove2 "" (get pay min-3000))))
  (define babysitting-data (get-data (get cheques maria-400)))
  (define heat-data (get-data (get gas)))
  (define hydro-data (get-data (get hydro)))
  (define insurance1-data (get-data (get insurance)))
  (define insurance2-data (get-data (get insurance2)))
  (define internet-data (get-data (get bell)))
  (define cellphone-data (get-data (get rogers)))
  (define water-data (get-data (get water)))

  ; populate summary
  (populate-listbox-w-columns lbSummary (force-string summary-data) summary-column-widths)

  ; populate details in tabs
  (populate-listbox-w-columns lbDetails1 biz-income-data details-column-widths)
  (populate-listbox-w-columns lbDetails2 babysitting-data details-column-widths)
  (populate-listbox-w-columns lbDetails3 heat-data details-column-widths)
  (populate-listbox-w-columns lbDetails4 hydro-data details-column-widths)
  (populate-listbox-w-columns lbDetails5 insurance1-data details-column-widths)
  (populate-listbox-w-columns lbDetails6 insurance2-data details-column-widths)
  (populate-listbox-w-columns lbDetails7 internet-data details-column-widths)
  (populate-listbox-w-columns lbDetails8 cellphone-data details-column-widths)
  (populate-listbox-w-columns lbDetails9 water-data details-column-widths))

