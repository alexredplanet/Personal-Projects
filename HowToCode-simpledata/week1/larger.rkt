;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname larger) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image Image -> Boolean
;; Produces true if the first image is larger than the second
(check-expect (larger? (square 5 "solid" "red")
                       (square 10 "solid" "red"))
              false)
(check-expect (larger? (square 5 "solid" "red")
                       (rectangle 4 5 "solid" "red"))
              true)
(check-expect (larger? (square 5 "solid" "red")
                       (rectangle 6 5 "solid" "red"))
              false)
(check-expect (larger? (circle 5 "solid" "red")
                       (rectangle 4 5 "solid" "red"))
              true)
                      

;(define (larger? img1 img2) false) ;stub

(define (larger? img1 img2)
  (> (* (image-height img1) (image-width img1))
     (* (image-height img2) (image-width img2))))