;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.2-function-design) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 3.2 Function Design

(require 2htdp/image)
; Exercise 34

; String -> String
; Extract the first character from a given string
; given "hello", expect "h"

;(define (string-first s) "") ;stub

(define (string-first s)
  (substring s 0 1))

(string-first "hello")

; String -> String
; Extract the last character from a given string
; given "hello" expect "o"

;(define (string-last s) "") ;stub

(define (string-last s)
  (substring s (- (string-length s) 1) (string-length s)))

(string-last "hello")

; Image -> Integer
; Return the number of pixels in a given image
; Given (square 5 "solid" "blue") expect 25

;(define (image-area img) 0) ;stub

(define (image-area img)
  (* (image-width img)
     (image-height img)))

(image-area (square 3 "solid" "blue"))
(image-area (rectangle 3 5 "solid" "blue"))

; String -> String
; Remove the first character of supplied string
; given "hello", expect "ello"

;(define (string-rest s) "") ;stub

(define (string-rest s)
  (substring s 1))

(string-rest "hello")

; String -> String
; Remove the last character from a given string
; given "hello" expect "hell"

;(define (string-remove-last s) "") ;stub

(define (string-remove-last s)
  (substring s 0 (- (string-length s) 1)))

(string-remove-last "hello")