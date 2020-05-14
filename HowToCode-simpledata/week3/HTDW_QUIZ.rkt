;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HTDW_QUIZ) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Grow-Ball
;; Click anywhere on the screeen to make a growing ball
;; Only one growing ball is present on the screen at a time
;; The ball will grow past the edge of the screen if left long enough
;==========================;

;; Constants
(define HEIGHT 300)
(define WIDTH 500)
(define MTS (empty-scene WIDTH HEIGHT))
(define GROWTH-RATE 5)
(define ball-colour "blue")
(define ball-type "solid")

;==========================;

;; Data Definitions
(define-struct ball (x y d))
;; Ball is (make-ball number number integer)
;; interp. a ball at position x, y, with a diameter of d
(define Ball-1 (make-ball 5 45 3))
(define Ball-2 (make-ball 5 45 100))
(define Ball-3 (make-ball 67 184 100))

#;
(define (fn-for-ball b)
  (... (ball-x b)
       (ball-y b)
       (ball-d b)))

;; =================

;; Functions:

;; Ball -> Ball
;; start the world with (main (make-ball (/ WIDTH 2) (/ HEIGHT 2) 1))
;; 
(define (main b)
  (big-bang b                             ; Ball
            (on-tick   tock)              ; Ball -> Ball
            (to-draw   render)            ; Ball -> Image
            (on-mouse  click)))           ; Ball Integer Integer MouseEvent -> Ball
            

;; Ball -> Ball
;; Grow the ball i.e. increase diameter of ball by growth-rate, leaving x and y the same
(check-expect (tock Ball-1)
              (make-ball (ball-x Ball-1) (ball-y Ball-1) (+ (ball-d Ball-1) GROWTH-RATE)))
(check-expect (tock Ball-3)
              (make-ball (ball-x Ball-3) (ball-y Ball-3) (+ (ball-d Ball-3) GROWTH-RATE)))


;(define (tock b) (make-ball 0 0 0)) ;stub

;; Took function from template

(define (tock b)
  (make-ball (ball-x b) (ball-y b) (+ (ball-d b) GROWTH-RATE)))


;; Ball -> Image
;; Place the appropriately sized ball on the screen
(check-expect (render Ball-1)
              (place-image (circle (ball-d Ball-1) ball-type ball-colour)
                           (ball-x Ball-1)
                           (ball-y Ball-1)
                           MTS))
(check-expect (render Ball-2)
              (place-image (circle (ball-d Ball-2) ball-type ball-colour)
                           (ball-x Ball-2)
                           (ball-y Ball-2)
                           MTS))
(check-expect (render Ball-3)
              (place-image (circle (ball-d Ball-3) ball-type ball-colour)
                           (ball-x Ball-3)
                           (ball-y Ball-3)
                           MTS))

;;(define (render b) MTS) ;stub

;; Took function from template
(define (render b)
  (place-image (circle (ball-d b) ball-type ball-colour)
                           (ball-x b)
                           (ball-y b)
                           MTS))


;; Ball Integer Integer MouseEvent -> Ball
;; create a new ball with diameter of 1 at the position of the mouse click
(check-expect (click Ball-1 25 30 "button-down")
              (make-ball 25 30 1))
(check-expect (click Ball-3 WIDTH HEIGHT "button-down")
              (make-ball WIDTH HEIGHT 1))
(check-expect (click Ball-2 0 0 "button-down")
              (make-ball 0 0 1))

;; Took template from Function Design Recipes
(define (click b x y me)
  (cond [(mouse=? me "button-down")
         (make-ball x y 1)]
        [else b]))
