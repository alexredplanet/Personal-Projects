;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ball_program) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Flying ball

;; =================
;; Constants:
(define HEIGHT 300)
(define WIDTH 500)
(define MTS (empty-scene WIDTH HEIGHT))
(define ball-colour "red")

;; =================
;; Data definitions:

(define-struct ball (x y dx dy size))
;; Ball is (make-cow Natural[0, WIDTH] Natural[0, HEIGHT] Integer Integer Natural)
;; interp. x is x-coordinate of the ball
;;         y is y-coordinate of the ball
;;         dx is velocity of ball in x direction
;;         dy is velocity of ball in y direction
;;         size is the diameter/radius of the ball
;;         x, y are in the center of the ball
;;         dx, dy are in pixels per tick

(define B1 (make-ball 10 45 3 -2 5))             ;at pos (10, 45) moving to bottom right, ball of diameter 5
(define B2 (make-ball 20 50 -4 10 12))           ;at pos (20, 50) moving to top left, ball of diameter 12

#;
(define (fn-for-ball b)
  (... (ball-x b)       ;Natural[0, WIDTH]
       (ball-y b)       ;Natural[0, HEIGHT]
       (ball-dx b)      ;Integer
       (ball-dy b)      ;Integer
       (ball-size b)))  ;Natural            

;; Template Rules Used:
;; Compound: 5 Fields

;; =================
;; Functions:

;; Ball -> Ball
;; start the world with (main (make-ball 0 0 5 5 5))
;; 
(define (main b)
  (big-bang b                      ; Ball
            (on-tick   next-ball)  ; Ball -> Ball
            (to-draw   render)     ; Ball -> Image
            (on-mouse  new-ball))) ; Ball Integer Integer MouseEvent -> Ball

;; Ball -> Ball
;; Change the x and y of the ball (position) by dx and dy respectively (speed)
;; Keep the ball within the boundary of MTS
;;!!!
;; Cases to write tests for:
;; ball > WIDTH but within height limit
;; ball < WIDTH but within height limit
;; ball > HEIGHT but within width limit
;; ball < height but within width limit
;; Ball > HEIGHT and WIDTH (bottom right)
;; Ball HEIGHT < 0 and > WIDTH (top right)
;; Ball WIDTH < 0 and > HEIGHT (bottom left)
;; Ball WIDTH < 0 and < HEIGHT (top left)

(define (next-ball b) C1) ;stub

;Took function from Data Definition for Ball

 
;; Ball -> Image
;; render the image of the ball at the correct x and y position 
(check-expect (render (make-ball 100 23 4 2 12))
              (place-image (circle 12 "solid" "blue") 100 23 MTS))

; Took template from Data Definition
(define (render b)
  (place-image (circle (ball-size b) "solid" "blue")
               (ball-x b) (ball-y b) MTS))


;; Ball Integer Integer MouseEvent -> Ball
;; Increase dx and dy by 5, reduce size by 1 if user clicks the ball
;; if user clicks elsewhere, reduce dx, dy by 3, increase size by 1
(check-expect (new-ball (make-ball 10 10 20 20 10) 10 10 "button-down")
              (make-ball 10 10 25 25 9))
(check-expect (new-ball (make-ball 10 10 20 20 10) 15 15 "button-down")
              (make-ball 10 10 17 17 11))

;(define (new-ball b x y me) ;stub

(define (new-ball b x y me)
  (cond [(and (mouse=? me "button-down") (eq? x (ball-x b)) (eq? y (ball-y b)))
         (make-ball (ball-x b) (ball-y b) (+ (ball-dx b) 5) (+ (ball-dy b) 5) (- (ball-size b) 1))]
        [(mouse=? me "button-down")
         (make-ball (ball-x b) (ball-y b) (- (ball-dx b) 3) (- (ball-dy b) 3) (+ (ball-size b) 1))]
        [else b]))