#lang sicp

; Exercises 1.11
; A function f is defined by the rule that
; f(n) = n if n < 3
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3
; write a recursive and iterative procedure that computes f

; Recursive
(define (recursive-f n)
  (if (< n 3)
      n
      (+ (recursive-f (- n 1)) (* 2 (recursive-f (- n 2))) (* 3 (recursive-f (- n 3))))))

; Iterative
(define (iter-f n)
  (iterative 2 1 0 n))
(define (iterative a b c count)
  (if (= count 0)
      c
      (iterative (+ a (* 2 b) (* 3 c)) a b (- count 1))))

(recursive-f 10)
(iter-f 10)

; Exercise 1.12
; Write a function that computes the elements of Pascal's triangle
; (top down and left to right ordering)
(define (pascal row col)
  (if (or (= row col) (= col 0))
      1
      (+ (pascal (- row 1) (- col 1))
         (pascal (- row 1) col))))

(pascal 4 2) ; should return 6

; Exercise 1.14
; What are the orders or growth of the space and number of steps used by the counting change
; procedure defined in 1.2.2?

; The number of steps will grow at an exponential rate with increasing input (exponential process)
; Space required will increase linearly with the size of the input (exponential process)

; Exercise 1.15
; Consider the following procedure for approximating sin x
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))
; a) How many times is the procedure evaluated when sin 12.15 is evaluated?
; sine 12.15
; Each time p is called, the input is divided by 3, and no further calls are made
; when the input is < 0.1.
; This requires 6 calls

; b) What is the order of growth  in space and number of steps as a function of a
; when sine a is evaluated?
; The function stops when a/3^n < 0.1 where n is the number of steps
; 10a < 3^n - we can use change of base rule to get that log (a) < n (roughly)
; Thus the order of growth is log (a)

; Exercise 1.16
; Create an iterative procedure for the fast-expt process:
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

; Iterative version
(define (fast-expt2 b n)
  (fast-expt-iter b n 1))
(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* a b)))))

(fast-expt2 2 2)