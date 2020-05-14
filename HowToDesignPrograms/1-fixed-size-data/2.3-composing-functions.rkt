;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 2.3-composing-functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; How to Design Programs
; Chapter 2.3 Composing Functions

; Exercises

(define standard-attendance 120)
(define standard-price 5.0)
(define price-change 0.1)
(define people-change 15)
(define show-cost 180)
(define cost-per-attendee 1.50)

(define (attendees ticket-price)
  (- standard-attendance (* (- ticket-price standard-price) (/ people-change price-change))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* cost-per-attendee (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 1)
(profit 2)
(profit 3) ;Ticket price of $3 yields best profit of $1063.2
(profit 4) ; After removing fixed cost from revenue, and increasing cost per attendee, this is most profitable
(profit 5)