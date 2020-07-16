;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.7-door-prog) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Door world program
; Author: Alex
; 28/05/2020
(require 2htdp/image)
(require 2htdp/universe)

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; DoorState -> DoorState
; Simulates the a door that can be locked and unlocked,
; and closes by it-self over time
(define (main ds)
  (big-bang ds
    [on-tick door-closer 3]
    [to-draw door-render]
    [on-key door-action]))

; DoorState -> DoorState
; Closes an open door over the period of one tick
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)

;(define (door-closer ds) "closed") ;stub

(define (door-closer ds)
  (cond
    [(string=? LOCKED ds) LOCKED]
    [(string=? CLOSED ds) CLOSED]
    [(string=? OPEN ds) CLOSED]))

; DoorState -> Image
; Render the correct door on the scene
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(check-expect (door-render LOCKED) (text LOCKED 40 "red"))
(check-expect (door-render OPEN) (text OPEN 40 "red"))

;(define (door-render ds) (square 0 "solid" "white")) ;stub

(define (door-render ds)
  (text ds 40 "red"))

; DoorState KeyEvent -> DoorState
; Unlock a door when 'u' is pressed
; Lock the door when 'l' is pressed
; Open the door when ' ' is pressed
(check-expect (door-action LOCKED "l") LOCKED)
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action LOCKED " ") LOCKED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "l") OPEN)
(check-expect (door-action OPEN "u") OPEN)
(check-expect (door-action OPEN " ") OPEN)


;(define (door-action ds ke) "closed") ;stub

(define (door-action ds ke)
  (cond
    [(and (string=? LOCKED ds) (key=? ke "u")) CLOSED]
    [(and (string=? CLOSED ds) (key=? ke "l")) LOCKED]
    [(and (string=? CLOSED ds) (key=? ke " ")) OPEN]
    [else ds]))


   

