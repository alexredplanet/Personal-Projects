;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.1-zoo-animals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 6.1-Zoo-Animals

; Data Definitions

(define-struct zoo [spider elephant boa armadillo])
; A zoo is (make-zoo Spider Elephant Boa Armadillo)
; - interp. a zoo contains a number of animals
; - Any animal may be false, meaning it is not in the zoo

#;
(define (fn-for-zoo z)
  (... (zoo-spider z)
       (zoo-elephant z)
       (zoo-boa z)
       (zoo-armadillo z)))

(define-struct dimension [x y z])
; A dimension is (make-dimension x y z)
; interp.
; - x, y, and z are Natural and describe a 3D volume
(define D0 (make-dimension 10 10 10))
(define D1 (make-dimension 1 10 10))
(define D2 (make-dimension 10 5 10))

(define-struct spider [legs dimension])
; A Spider is one of;
; - (make-spider Natural Dimension)
; - false
; interp.
; - Legs: Natural is the number of legs the spider has left
; - Dimension: The size of the Spider
(define S0 false)
(define S1 (make-spider 8 (make-dimension 1 1 2)))

(define-struct elephant [dimension])
; An Elephant is one of:
; - (make-elephant Dimension)
; - false
; interp.
; - Dimension: Size of the elephant
(define E0 false)
(define E1 D0)
(define E2 D1)
(define E3 D2)

(define-struct boa [length girth])
; A Boa is one of:
; - (make-boa Natural Natural)
; - false
; interp.
; - Length: Length of the Boa
; - Girth: Diameter of the Boa
(define B0 false)
(define B1 (make-boa 10 5))
(define B2 (make-boa 3 6))

(define-struct armadillo [bands dimension])
; An Armadillo is one of:
; - (make-armadillo Natural Dimension)
; - false
; interp.
; - Bands: Number of bands the Armadillo has
; - Dimension: Size of the armadillo
(define A0 false)
(define A1 (make-armadillo 3 (make-dimension 3 2 4)))


; Zoo-Animal Dimension -> Boolean
; Consumes a zoo animal and a cage size, determines whether the animal can fit in the cage
(check-expect (fits? false D1) true)
(check-expect (fits? (make-spider 10 (make-dimension 1 1 1)) (make-dimension 1 1 2)) true)
(check-expect (fits? (make-spider 10 (make-dimension 1 3 1)) (make-dimension 1 1 2)) false)
(check-expect (fits? (make-spider 10 (make-dimension 1 3 1)) (make-dimension 3 1 1)) false)
(check-expect (fits? false D2) true)
(check-expect (fits? (make-elephant (make-dimension 10 12 7)) (make-dimension 10 12 9)) true)
(check-expect (fits? (make-elephant (make-dimension 15 12 7)) (make-dimension 10 12 9)) false)
(check-expect (fits? false (make-dimension 4 5 7)) true)
(check-expect (fits? (make-boa 10 4) (make-dimension 3 5 3)) true)
(check-expect (fits? (make-boa 15 6) (make-dimension 4 4 2)) false)
(check-expect (fits? false D2) true)
(check-expect (fits? (make-armadillo 4 D0) D1) false)
(check-expect (fits? (make-armadillo 4 D1) D0) true)

;(define (fits? a d) false) ;stub

(define (fits? a d)
  (cond [(false? a) true]
        [(boa? a) (< (* (boa-length a) (boa-girth a)) (* (dimension-x d)
                                                          (dimension-y d)
                                                          (dimension-z d)))]
        [else (< (size a)
                  (* (dimension-x d) (dimension-y d) (dimension-z d)))]))

; Elephant/Spider/Armadillo -> Natural
; Returns the size of the animal
(check-expect (size (make-elephant (make-dimension 5 5 5))) 125)
(check-expect (size (make-spider 5 (make-dimension 5 1 2))) 10)
(check-expect (size (make-armadillo 4 (make-dimension 2 7 4))) 56)

(define (size a)
  (cond [(elephant? a) (* (dimension-x (elephant-dimension a))
                          (dimension-y (elephant-dimension a))
                          (dimension-z (elephant-dimension a)))]
        [(spider? a) (* (dimension-x (spider-dimension a))
                        (dimension-y (spider-dimension a))
                        (dimension-z (spider-dimension a)))]
        [(armadillo? a) (* (dimension-x (armadillo-dimension a))
                           (dimension-y (armadillo-dimension a))
                           (dimension-z (armadillo-dimension a)))]))



