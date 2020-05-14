;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Define_struct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define-struct pos (x y))

; make compound data called pos that takes two fields

(define P1 (make-pos 3 6)) ;makes a pos structure where x field is 3 and y field is 6

(define P2 (make-pos 2 8))

(pos-x P1) ;3
(pos-y P2) ;8

(pos? P1)       ;true
(pos? "hello")  ;false