;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.1-vehicles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 6.1 Vehicles

; Data Definition

(define-struct vehicle [type passengers plate consumption])
; A vehicle is (make-vehicle String Natural String Natural)
; Interp.
; Type: The type of vehicle e.g. "SUV"
; Passengers: The number of passengers that can be carried
; Plate: The license plate E.g. "CPY63D"
; Consumption: The fuel consumption in miles/gallon

;Examples
(define V1 (make-vehicle "SUV" 4 "XYZ23D" 10))
(define V2 (make-vehicle "Van" 6 "HTD45S" 12))
(define V3 (make-vehicle "Bus" 15 "BUS142" 15))

#;
(define (fn-for-vehicle v)
  (... (vehicle-type v)
       (vehicle-passengers v)
       (vehicle-plate v)
       (vehicle-consumption v)))