;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.6-world-programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; A simple world program
; A car will move from left to right across the screen

; Constants
(define WIDTH 200)
(define HEIGHT 50)
(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define BACKGROUND (place-image tree (/ WIDTH 3)
                                (- HEIGHT (/ (image-height tree) 2))
                                (empty-scene WIDTH HEIGHT)))
(define CAR-SPEED 3)

(define WHEEL-RADIUS 5)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define WHEEL-SEPARATION (rectangle (* WHEEL-RADIUS 3) 0 "solid" "white"))
(define BOTH-WHEELS (beside WHEEL WHEEL-SEPARATION WHEEL))
(define HALF-CAR (/ (* WHEEL-RADIUS 8) 2))
(define CAR-BODY (above/align "middle"
                   (rectangle (* WHEEL-RADIUS 6) WHEEL-RADIUS "solid" "red")
                   (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red")))
 
(define CAR (above/align "middle"
                         CAR-BODY
                         BOTH-WHEELS))
(define Y-CAR (- HEIGHT (/ (image-height CAR) 2)))
                   

; Car is a Number
; interp. the number of pixels between
; the left border of the screen and the car

; Car Examples:
(define C1 5)
(define C2 20)

; Car -> Car
; Start the world with (main 0)
(define (main car)
  (big-bang car
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))

; Car -> Car
; Increase the current Car by CAR-SPEED pixels
(check-expect (tock 5) (+ 5 CAR-SPEED))
(check-expect (tock 56) (+ 56 CAR-SPEED))

;(define (tock c) c) ;stub

(define (tock c)
  (+ c CAR-SPEED))

; Car -> Image
; Place the image of the car at the correct position on the screen
(check-expect (render 5)
              (place-image CAR (+ 5 HALF-CAR) Y-CAR BACKGROUND))
(check-expect (render 132)
              (place-image CAR (+ 132 HALF-CAR) Y-CAR BACKGROUND))

;(define (render c) (empty-scene 0 0)) ;stub

(define (render c)
  (place-image CAR (+ c HALF-CAR) Y-CAR BACKGROUND))

; Car -> Boolean
; Produce true when the Car has passed WIDTH of the screen
(check-expect (end? 20) false)
(check-expect (end? 0) false)
(check-expect (end? WIDTH) false)
(check-expect (end? (+ WIDTH HALF-CAR)) true)

;(define (end? c) false) ;stub

(define (end? c)
  (>= c (+ WIDTH HALF-CAR)))
