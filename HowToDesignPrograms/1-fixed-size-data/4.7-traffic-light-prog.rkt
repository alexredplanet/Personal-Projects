;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.7-traffic-light-prog) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Traffic Light World Program
; Author: Alex
; 16/04/2020

; Imports
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume
(define T1 "red")
(define T2 "green")
(define T3 "yellow")

; Constants
(define WIDTH 90)
(define HEIGHT 30)
(define BULB-SIZE (/ HEIGHT 3))
(define MTS (empty-scene WIDTH HEIGHT))

; Main function
; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

; Auxillary functions

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")

(define (tl-next t)
  (cond
    [(string=? "red" t) "green"]
    [(string=? "green" t) "yellow"]
    [(string=? "yellow" t) "red"]))


; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red") (place-image (beside
                                              (circle BULB-SIZE "solid" "red")
                                              (circle BULB-SIZE "outline" "yellow")
                                              (circle BULB-SIZE "outline" "green"))
                                             (/ WIDTH 2)
                                             (/ HEIGHT 2)
                                             MTS))
(check-expect (tl-render "yellow") (place-image (beside
                                              (circle BULB-SIZE "outline" "red")
                                              (circle BULB-SIZE "solid" "yellow")
                                              (circle BULB-SIZE "outline" "green"))
                                             (/ WIDTH 2)
                                             (/ HEIGHT 2)
                                             MTS))
(check-expect (tl-render "green") (place-image (beside
                                              (circle BULB-SIZE "outline" "red")
                                              (circle BULB-SIZE "outline" "yellow")
                                              (circle BULB-SIZE "solid" "green"))
                                             (/ WIDTH 2)
                                             (/ HEIGHT 2)
                                             MTS)) 
 

  
(define (tl-render t)
  (cond [(string=? t "red") (place-image (make-bulb "red")
                                         (/ WIDTH 2)
                                         (/ HEIGHT 2)
                                         MTS)]
        [(string=? t "green") (place-image (make-bulb "green")
                                           (/ WIDTH 2)
                                           (/ HEIGHT 2)
                                           MTS)]
        [(string=? t "yellow") (place-image (make-bulb "yellow")
                                            (/ WIDTH 2)
                                            (/ HEIGHT 2)
                                            MTS)]))


; String -> Image
; make a one-colour bulb
(check-expect (make-bulb "red") (beside (circle BULB-SIZE "solid" "red")
                                        (circle BULB-SIZE "outline" "yellow")
                                        (circle BULB-SIZE "outline" "green")))

(define (make-bulb t)
  (cond [(string=? t "red") (beside (circle BULB-SIZE "solid" "red")
                                    (circle BULB-SIZE "outline" "yellow")
                                    (circle BULB-SIZE "outline" "green"))]
        [(string=? t "green") (beside (circle BULB-SIZE "outline" "red")
                                      (circle BULB-SIZE "outline" "yellow")
                                      (circle BULB-SIZE "solid" "green"))]
        [(string=? t "yellow") (beside (circle BULB-SIZE "outline" "red")
                                       (circle BULB-SIZE "solid" "yellow")
                                       (circle BULB-SIZE "outline" "green"))]))
                                             