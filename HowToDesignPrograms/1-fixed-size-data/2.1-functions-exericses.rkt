;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 2.1-functions-exericses) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Fixed Sized Data
; Section 2.1 Functions

; Exercises

; 11
;Compute distance to origin of point (x, y)
(define (dist x y)
  (sqrt (+ (* x x) (* y y))))

; 12
; Compute volume of cube of side length l
(define (cvolume l)
  (* l l l))
; Compute surface of cube of side length l
(define (csurface l)
  (* l l 6))

; 13
; Extract first 1String from a string
(define (string-first s)
  (string-ith s 0))

;14
; Extract last 1String from a string
(define (string-last s)
  (string-ith s (- (string-length s) 1)))

;15
(define (string-delete s i)
  (string-append (substring s 0 i)
                 (substring s (+ i 1) (string-length s))))
