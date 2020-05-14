;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.7-happiness-meter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; This is a world program that displays a happiness gauge
; Date 11/04/2020
; Author: Alex

(require 2htdp/image)
(require 2htdp/universe)

; Happiness is a Number
; Interp the height of the happiness meter
; A red rectangle of height Number represents happiness

; Constants

(define HEIGHT 100)
(define WIDTH 50)

(define BOX (rectangle WIDTH HEIGHT "outline" "black"))

; Main Function

(define (main h)
  (big-bang h
    [on-tick tock]
    [to-draw render]
    [on-key press]))

; Auxillary Function

; Happiness -> Happiness
; Decrease the happiness bar by -0.1 until it reaches 0
(check-expect (tock 0) 0)
(check-expect (tock 20) 19.9)

;(define (tock h) 0) ;stub

(define (tock h)
  (cond [(>= h 0.1) (- h 0.1)]
        [else 0]))

; Happiness -> Image
; Place the appropriately sized red rectangle in the box

(check-expect (render 0) (overlay/align "middle" "bottom"
                          BOX
                          (rectangle WIDTH 0 "solid" "red")))
(check-expect (render 45) (overlay/align "middle" "bottom"
                          BOX
                          (rectangle WIDTH 45 "solid" "red")))
(check-expect (render HEIGHT) (overlay/align "middle" "bottom"
                               BOX
                               (rectangle WIDTH HEIGHT "solid" "red")))
(check-expect (render (+ HEIGHT 20)) (overlay/align "middle" "bottom"
                                      BOX
                                      (rectangle WIDTH HEIGHT "solid" "red")))

;(define (render h) BOX) ;stub

(define (render h)
  (cond [(>= h HEIGHT) (overlay/align "middle" "bottom"
                        BOX
                        (rectangle WIDTH HEIGHT "solid" "red"))]
        [else
         (overlay/align "middle" "bottom"
          BOX
          (rectangle WIDTH h "solid" "red"))]))

; Happiness KeyEvent -> Happiness
; When up-arrow is pressed, increase happiness by 1/3
; When down-arrow is pressed, increase happiness by 1/5
(check-expect (press 5 "down") (+ 5 (/ HEIGHT 5)))
(check-expect (press 14 "up") (+ 14 (/ HEIGHT 3)))

;(define (press h ke) 0) ;stub

(define (press h ke)
  (cond [(key=? ke "down") (+ h (/ HEIGHT 5))]
        [(key=? ke "up") (+ h (/ HEIGHT 3))]))

