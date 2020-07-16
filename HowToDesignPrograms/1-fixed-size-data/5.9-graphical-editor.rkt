;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.9-graphical-editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 5.9 Designing Worlds with Structre

; Simple graphical text editor program
; Author: Alex
; Date 02/06/2020

(require 2htdp/image)
(require 2htdp/universe)

; Constants
(define HEIGHT 20)
(define WIDTH 200)
(define MTS (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 2 20 "solid" "red"))
(define TEXT-SIZE 11)

; Data Definitions
(define-struct editor [pre post])
; An Editor is (make-editor String String)
; interp.
; - pre is the text before the cursor
; - post is the text after the cursor

; Editor Examples:
(define E1 (make-editor "hello " "world"))
(define E2 (make-editor "" ""))
(define E3 (make-editor "hello, welcome to the " "underworld"))

; World Examples
(define W1 (overlay/align "left" "center"
                          (beside
                           (text (editor-pre E1) TEXT-SIZE "black")
                           CURSOR
                           (text (editor-post E1) TEXT-SIZE "black"))
                          MTS))
(define W2 (overlay/align "left" "center"
                          (beside
                           (text (editor-pre E2) TEXT-SIZE "black")
                           CURSOR
                           (text (editor-post E2) TEXT-SIZE "black"))
                          MTS))
(define W3 (overlay/align "left" "center"
                          (beside
                           (text (editor-pre E3) TEXT-SIZE "black")
                           CURSOR
                           (text (editor-post E3) TEXT-SIZE "black"))
                          MTS))

; Main Function

(define (run e)
  (big-bang e
    [to-draw render]
    [on-key edit]))

; Functions

; Editor -> Image
; Render the editor as a graphical interface
(check-expect (render E1) W1)
(check-expect (render E2) W2)
(check-expect (render E3) W3)

;(define (render e) MTS) ;stub

(define (render e)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre e) TEXT-SIZE "black")
                  CURSOR
                  (text (editor-post e) TEXT-SIZE "black"))
                 MTS))

; Editor KeyEvent -> Editor
; Edit the text according to the given keyevent
(check-expect (edit E1 "\b") (make-editor "hello" "world"))         ;delete char
(check-expect (edit E1 "left") (make-editor "hello" " world"))      ;move left through word
(check-expect (edit E1 "right") (make-editor "hello w" "orld"))     ;move right through word
(check-expect (edit E1 "up") E1)                                    ;up
(check-expect (edit E1 "down") E1)                                  ;down
(check-expect (edit E1 "a") (make-editor "hello a" "world"))        ;add char in middle
(check-expect (edit E2 "a") (make-editor "a" ""))                   ;add char to empty
(check-expect (edit E2 "\b") (make-editor "" ""))                   ;delete char from empty
(check-expect (edit E2 "left") (make-editor "" ""))                 ;move left on empty
(check-expect (edit E2 "right") (make-editor "" ""))                ;move right on empty
(check-expect (edit (make-editor "" "hello world") "left")
              (make-editor "" "hello world"))                       ;move left at beginning of word
(check-expect (edit (make-editor "hello world" "") "right")
              (make-editor "hello world" ""))                       ;move right at end of word
(check-expect (edit (make-editor "a" " dog") "\b")
              (make-editor "" " dog"))                              ;delete first char
(check-expect (edit (make-editor "howdy " "") "y")
              (make-editor "howdy y" ""))                           ;add to end of word

; Insert chars to end of pre
; Delete char at end of pre when "\b" 
; Move right or left until end or start of word
  
;(define (edit e ke) E2) ;stub

(define (edit e ke)
  (cond [(key=? ke "\b") (delete e)]
        [(> (string-length ke) 2) (shift-cursor e ke)]    ;The only ke longer than 2 is right/left/down
        [(< (string-length ke) 2) (insert e ke)]
        [else e]))


; AUXILLARY FUNCTIONS

; Editor -> Editor
; Delete the last char in editor-pre if there is any
(check-expect (delete E1) (make-editor "hello" "world"))
(check-expect (delete E2) (make-editor "" ""))
(check-expect (delete (make-editor "a" " dog"))
              (make-editor "" " dog"))
(check-expect (delete (make-editor "a dog" ""))
              (make-editor "a do" ""))

;(define (delete e) (make-editor "" "")) ;stub

(define (delete e)
  (make-editor (string-remove-last (editor-pre e)) (editor-post e)))

; Editor -> Editor
; Shift a char from pre to post or vice versa depending on ke
(check-expect (shift-cursor E1 "right") (make-editor "hello w" "orld"))
(check-expect (shift-cursor E1 "left") (make-editor "hello" " world"))
(check-expect (shift-cursor (make-editor "" "world") "left") (make-editor "" "world"))
(check-expect (shift-cursor (make-editor "hello world" "") "right") (make-editor "hello world" ""))

(define (shift-cursor e ke)
  (cond [(key=? ke "right") (make-editor (string-append (editor-pre e) (string-first (editor-post e)))
                                        (string-rest (editor-post e)))]
        [(key=? ke "left")  (make-editor (string-remove-last (editor-pre e))
                                         (string-append (string-last (editor-pre e)) (editor-post e)))]
        [else e]))

; Editor KeyEvent -> Editor
; Insert the char correctly into the editor
(check-expect (insert E1 "a") (make-editor "hello a" "world"))        ;add char in middle
(check-expect (insert E2 "a") (make-editor "a" ""))                   ;add char to empty
(check-expect (insert (make-editor "howdy " "") "y")
              (make-editor "howdy y" "")) 

;(define (insert e ke) E2) ;stub

(define (insert e ke)
  (if (text-at-edge? e)
      e
      (make-editor (string-append (editor-pre e) ke) (editor-post e))))


; SECONDARY AUXILLARY FUNCTIONS

; String -> String
; Remove the last character from a given string
(check-expect (string-remove-last "hello") "hell")
(check-expect (string-remove-last "") "")

;(define (string-remove-last s) "") ;stub

(define (string-remove-last s)
  (if (string=? "" s)
      s
      (substring s 0 (- (string-length s) 1))))

; String -> String
; Extract the first character from a given string
(check-expect (string-first "hello") "h")
(check-expect (string-first "") "")

;(define (string-first s) "") ;stub

(define (string-first s)
  (if (string=? "" s)
      s
      (substring s 0 1)))

; String -> String
; Remove the first character of supplied string
(check-expect (string-rest "hello") "ello")
(check-expect (string-rest "") "")

;(define (string-rest s) "") ;stub

(define (string-rest s)
  (if (string=? "" s)
      s
      (substring s 1)))

; String -> String
; Extract the last character from a given string
(check-expect (string-last "hello") "o")
(check-expect (string-last "") "")

;(define (string-last s) "") ;stub

(define (string-last s)
  (if (string=? "" s)
      s
      (substring s (- (string-length s) 1) (string-length s))))

; Editor -> Boolean
; Returns true if the rendered text would exceed the width of the display
(define WIDE-EDITOR (make-editor "This is a sample text that is too long for the editor" ""))

(check-expect (text-at-edge? WIDE-EDITOR) true)
(check-expect (text-at-edge? (make-editor "This is a sample text that" "")) false)
(check-expect (text-at-edge? (make-editor "This is a sample text that is too long for " "")) false)

;(define (text-at-edge? e) false) ;stub

(define (text-at-edge? e)
  (<= (- WIDTH (image-width (beside CURSOR
                       (text (string-append (editor-pre e)
                                      (editor-post e))
                             TEXT-SIZE
                             "black"))))
  3))

