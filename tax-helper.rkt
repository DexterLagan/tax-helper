#lang racket/gui
(define appname "Tax Helper")
(include "tax-helper-lib.rkt")
(require "tax-helper-ui.rkt")

;;; purpose

; to help compute totals for tax return purposes

;;; documentation

; To add a new tab / list :
; 1) launch MrEd UI editor, open the tax-helper-ui.med project
; 2) copy-paste the last tab+listbox
; 3) rename the new tab and listboxes appropriately
; 4) save the project and export to tax-helper-ui.rkt
; 5) update the load-and-compute procedure :
;    a) add a label and a total to the summary list
;    b) define a new column-data and populate it to the new list
; Notes:
;   Column data has to be strings only
;   You might need to switch rows and columns depending on the data source.

;;; user defs

; Define some common transaction predicates
(defpl pay "Branch Transaction CREDIT MEMO")
(defpl pay-canada "Electronic Funds Transfer PAY CANADA")
(defpl deposit "INTERNET DEPOSIT")
(defpl deposit-canada "DEPOSIT CANADA")
(defpl fee "TRANSACTION FEE")
(defpl insurance "Dominion of Canada Gen")
(defpl insurance2 "DOMINION OF CANADA GROUP")
(defpl timmies "TIM HORTONS")
(defpl shoppers "SHOPPER'S DRUG")
(defpl metro "METRO")
(defpl golf "VW CREDIT CAN")
(defpl bills "INTERNET BILL PAY")
(defpl bell "BELL CANADA")
(defpl one-bill "BELL CANADA - ONE BILL")
(defpl rogers "ROGERS")
(defpl hydro "HYDRO OTTAWA")
(defpl gas "ENBRIDGE")
(defpl water "OTTAWA WATER")
(defpl cra "CRA (REVENUE -")
(defpl cra2014 "CRA (REVENUE) - 2014")
(defpl installments "CRA (REVENUE) - TAX INSTA")
(defpl cheques "CHEQUE")

; Define some minimum amounts for filtering
(defpf min-100 100)
(defpf maria-400 400)
(defpf min-3000 3000)

;;; Main

;; command line version
;(loadt "Transactions_2019.csv")
;(help)
;(newline)
;(totals)
;(echo "Child Care Expenses (Maria Reyes - 70 Monterey Drive): ")
;(dispt cheques maria-400)
;(newline)
;(input-loop)

; gui version (default)
(tax-helper-ui-init  #:menu-item-open-callback  (λ (c e) (load-and-compute))        ; file -> open
                     #:menu-item-exit-callback  (λ (c e) (send MainWindow show #f)) ; file -> exit
                     #:menu-item-about-callback (λ (c e) (display-about-dialog)))   ; help -> about

