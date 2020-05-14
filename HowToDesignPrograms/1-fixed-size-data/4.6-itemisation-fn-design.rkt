;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.6-itemisation-fn-design) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

(define NO-TAX-UPPER 1000)
(define NORMAL-TAX-UPPER 10000)
(define NORMAL-TAX 0.05)
(define HIGH-TAX 0.08)

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 5000) (* 0.05 5000))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))


;(define (sales-tax p) 0) ;stub

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p NO-TAX-UPPER)) 0]
    [(and (<= NO-TAX-UPPER p) (< p NORMAL-TAX-UPPER)) (* NORMAL-TAX p)]
    [(>= p NORMAL-TAX-UPPER) (* HIGH-TAX p)]))