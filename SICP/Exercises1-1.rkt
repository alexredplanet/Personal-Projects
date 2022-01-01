#lang sicp

;; Exercise 1.1
;; Write the evaluations below the following expressions
10
10

(+ 5 3 4)
12

(- 9 1)
8

(/ 6 2)
3

(+ (* 2 4) (- 4 6))
6

(define a 3)
(define b (+ a 1))

(+ a b (* a b))
19

(= a b)
#false

(if (and (> b a) (< b (* a b)))
    b
    a)
4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
16

(+ 2 (if (> b a) b a))
6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
16

;; Exercise 1.2
;; Translating an expression into prefix form
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

;; Exercise 1.3
;; Define a procedure that takes three numbers as arguments
;; and returns the sum of the squares of the two larger numbers.
(define (f a b c)
  (cond ((and (> a b) (> a c) (> b c)) (+ (* a a) (* b b)))
        ((and (> a b) (> a c) (> c b)) (+ (* a a) (* c c)))
        (else (+ (* b b) (* c c)))))

;; Exercise 1.4
;; Observe that our model of evaluation allows for combinations
;; whose operators are compound expres- sions.
;; Use this observation to describe the behavior of the following procedure:
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; If b > 0, the + operator is used to combine a and b, otherwise the - operator is used

;; Exercise 1.5
(define (p) (p))
(define (test x y)
(if (= x 0) 0 y))

; Applicative-order: sub-expressions are evaluated first, thus program is stuck in loop
; as (p) evaluates to (p), so an error will occur
; Normal-order: sub-expressions are ignored until actually needed, so (p) will be substituted for y
; without being evaluated, meaning the 3rd line will return 0.

;; Exercise 1.6
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y) (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (square x) (* x x))
(define (sqrt x)
  (sqrt-iter 1.0 x))

;; Why can't we use new-if to replace the special form if in the sqrt program (above)?
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;; On evaluation, scheme functions evaluate all arguments first,
;; thus in the sqrt procedure, the else clause of the cond will be recursively
;; evaluated using the new-if definition, leading to an infinite loop.

;; Exercise 1.7
;; The good-enough? test will fail for small numbers due to floating point imprecision
;; This makes it inaccurate for small numbers
(square (sqrt 0.00000001))
;; For large numbers, the result may never fall within the threshold
; (sqrt 100000000000000000000000000000000000) won't finish
; this is due to the rounding error associated with storing large numbers
; if a number is too large, the difference between subsequent guesses will never
; be less than 0.001 due to the rounding error in thier representations.

; Alternative good-enough?:
; stop when the change in guess is a very small fraction of the guess
(define (sqrt-iter2 guess x)
  (if (good-enough?2 (improve guess x) guess x)
      guess
      (sqrt-iter2 (improve guess x) x)))

(define (good-enough?2 guess previous x)
  (< (abs (- guess previous)) (* guess 0.001)))

(define (sqrt2 x)
  (sqrt-iter2 1.0 x))

(square (sqrt2 0.00000001)) ; returns a much more accurate answer
; sqrt2 also finishes with a more accurate answer

; Exercise 1.8 Newton's Method for cube roots
(define (cube-root-iter guess x)
  (if (good-enough?2 (improve-cube guess x) guess x)
      guess
      (cube-root-iter (improve-cube guess x) x)))

(define (improve-cube guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(cube-root 27)