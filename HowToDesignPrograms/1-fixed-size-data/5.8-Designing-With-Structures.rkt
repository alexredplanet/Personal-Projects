;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.8-Designing-With-Structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Section 5.8 Designing with Structures


; Data Definition
(define-struct r3 [x y z])
; An R3 is a structure:
; - (make-r3 Number Number Number)
; - interp. the x, y, and z coordinates of an object in 3D space

(define Ob1 (make-r3 0 3 4))
(define Ob2 (make-r3 -2 1 2))

; Functions

; R3 -> Natural
; Compute the distance of a point in 3D space to the origin
(check-expect (dist-origin Ob1) (sqrt (+ (sqr (r3-x Ob1)) (sqr (r3-y Ob1)) (sqr (r3-z Ob1)))))
(check-expect (dist-origin Ob2) (sqrt (+ (sqr (r3-x Ob2)) (sqr (r3-y Ob2)) (sqr (r3-z Ob2)))))

;(define (dist-origin r) 0) ;stub

(define (dist-origin r)
  (sqrt (+ (sqr (r3-x r))
           (sqr (r3-y r))
           (sqr (r3-z r)))))

; Additional Practise:
; Templates for the following structure definitions:
(define-struct movie [title director year])
(define (movie-fn m)
  (... (movie-title m)
       (movie-director m)
       (movie-year M)))

(define-struct pet [name number])
(define (pet-fn p)
  (... (pet-name p)
       (pet-number p)))

; Structure Type Definition and Data Definition for representing points in time since midnight
(define-struct time [hours minutes seconds])
; interp. the number of hours, minutes and seconds since the last occurence of midnight
; - hours is Natural[0, 23]
; - minutes is Natural[0, 59]
; - seconds is Natural[0, 59]

(define T1 (make-time 10 21 45))
(define T2 (make-time 23 59 59))
(define T3 (make-time 0 0 0))

; Time -> Natural
; Produce the number of seconds that have occured since midnight given a Time
(check-expect (time->seconds T3) 0)
(check-expect (time->seconds T2) (+ (* 3600 23) (* 60 59) 59))
(check-expect (time->seconds T1) (+ (* 3600 10) (* 60 21) 45))

(define (time->seconds t)
  (+ (* 3600 (time-hours t))
     (* 60 (time-minutes t))
     (time-seconds t)))

; Representing 3-letter words
(define-struct 3-word [L1 L2 L3])
; interp. a 3-word consists of 3 letters, L1, L2, and L3
; A letter is a sub-set of a 1String, and is one of:
; - "a" to "z"
; - false

(define 3-WORD-1 (make-3-word "c" "a" "t"))
(define 3-WORD-2 (make-3-word "d" "o" "g"))
(define 3-WORD-3 (make-3-word "g" "o" false))

; 3-word 3-word -> 3-word
; Check to see if two 3-words have the same letters
; - where they do, retain the letter
; - where they do not, replace the letter with #false
(check-expect (compare-word 3-WORD-1 3-WORD-2) (make-3-word false false false))
(check-expect (compare-word 3-WORD-2 3-WORD-3) (make-3-word false "o" false))
(check-expect (compare-word 3-WORD-1 3-WORD-1) (make-3-word "c" "a" "t"))

;(define (compare-word 3w1 3w2) (make-3-word "s" "t" "u")) ;stub

(define (compare-word 3w1 3w2)
  (make-3-word (compare-letter (3-word-L1 3w1)
                               (3-word-L1 3w2))
               (compare-letter (3-word-L2 3w1)
                               (3-word-L2 3w2))
               (compare-letter (3-word-L3 3w1)
                               (3-word-L3 3w2))))

; Letter1 Letter2 -> Letter
; If Letter1 and Letter2 are the same, return Letter1, otherwise return false
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") false)
(check-expect (compare-letter "a" false) false)

;(define (compare-letter l1 l2) false) ;stub

(define (compare-letter l1 l2)
  (cond
    [(or (boolean? l1) (boolean? l2)) false]    
    [(string=? l1 l2) l1]
    [else false]))
