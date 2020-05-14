;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname listofstring) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)

(define LOI1 empty)
(define LOI2 (cons "solid" empty))
(define LOI3 (cons "pink" LOI2))

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; Template Rules Used
;; - one of: 2 cases
;; - atomic distinct: empty
;; - Compound: 2 fields
;; - atomic distinct: (first loi) is Image
;; - self-reference: (rest loi) is ListOfImage