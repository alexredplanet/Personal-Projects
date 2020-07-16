;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.2-posn-structure) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Using Racket's posn structure

; Simple function that computes the distance to origin given a posn
(define (distance-to-0 pos)
  (sqrt
   (+ (* (posn-x pos) (posn-x pos))
      (* (posn-y pos) (posn-y pos)))))

; Compute manhattan distance from origin
(define (manhattan-distance pos)
  (+ (posn-x pos) (posn-y pos)))