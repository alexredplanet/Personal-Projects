;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.4-ufo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A UFO is a Number.
; interpretation number of pixels between the top and the UFO

(require 2htdp/image)
(require 2htdp/universe)

; Constants
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 500)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (circle 30 "solid" "grey")))
(define HALF-UFO (/ (image-height UFO) 2))
(define UFO-X (/ WIDTH 2))
 
; UFO -> UFO
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]))
 
; UFO -> UFO
; computes next location of UFO, stops when UFO has landed
(check-expect (nxt 11) 14)
(check-expect (nxt (- HEIGHT HALF-UFO)) (- HEIGHT HALF-UFO))

(define (nxt y)
  (cond [(>= y (- HEIGHT HALF-UFO)) (- HEIGHT HALF-UFO)]
        [else
         (+ y 3)]))
  
 
; UFO -> Image
; places UFO at given height into the center of MTSCN, including a commentary of progress
(check-expect (render 11) (overlay/align "left" "bottom"
                                         (text "UFO descending" 12 "black")
                                         (place-image UFO UFO-X 11 MTSCN)))
(check-expect (render (- HEIGHT (/ HEIGHT 3))) (overlay/align "left" "bottom"
                                                                  (text "UFO closing in" 12 "black")
                                                                  (place-image UFO UFO-X (- HEIGHT (/ HEIGHT 3)) MTSCN)))
(check-expect (render (- HEIGHT HALF-UFO)) (overlay/align "left" "bottom"
                                                          (text "UFO landed" 12 "black")
                                                          (place-image UFO UFO-X (- HEIGHT HALF-UFO) MTSCN)))

(define (render y)
  (overlay/align "left" "bottom"
                 (cond [(< y (- HEIGHT (/ HEIGHT 3))) (text "UFO descending" 12 "black")]
                       [(>= y (- HEIGHT HALF-UFO)) (text "UFO landed" 12 "black")]
                       [else
                        (text "UFO closing in" 12 "black")])
                 (place-image UFO UFO-X y MTSCN)))
