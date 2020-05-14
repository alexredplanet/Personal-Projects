;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; 04/03/2020
;; Weak points in this program
;; - Didn't write tests for functions whose output involved random generation as I was not sure how to..
;; - Could have put explanations for purpose of every test, only had for simple cases

;; Space Invaders
;; Stop invaders from reaching the bottom of the screen.
;; You control the tank with the left and right arrow keys
;; Destroy invaders by striking them with missiles (spacebar to fire missiles)
;; There are no levels/progression in difficulty in this version (yet)

;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define Transparent-BACKGROUND (rectangle WIDTH HEIGHT "outline" "black"))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))
(define TANK-HEIGHT (image-height TANK))

(define MISSILE (ellipse 5 15 "solid" "red"))



;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game g)
  (... (fn-for-loinvader (game-invaders g))
       (fn-for-lom (game-missiles g))
       (fn-for-tank (game-tank g))))

(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))



(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right
(define I4 (make-invader 100 150 -12))          ;not landed, moving left
(define I5 (make-invader 200 75 12))            ;not landed, moving right


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit I1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit I1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit I1
(define M4 (make-missile (invader-x I4) (+ (invader-y I4) 10)))  ;exactly hit I4
(define M5 (make-missile (invader-x I5) (+ (invader-y I5) 20)))  ;not hit I5

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))



(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))

;; ListOfInvader is one of:
;; - empty
;; - (cons Invader ListOfInvader)
(define loi1 empty)
(define loi2 (cons I1 empty))
(define loi3 (cons I2 (cons I1 empty)))
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi))
              (fn-for-loi (rest loi)))]))

;; Template Rules Used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Invader ListOfInvader)
;; - reference: (first loi) is Invader
;; - self-reference (rest loi) is ListOfInvader

;; ListOfMissile is one of:
;; - empty
;; - (cons Missile ListOfMissile)
(define lom1 empty)
(define lom2 (cons M1 empty))
(define lom3 (cons M2 (cons M1 empty)))
#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom))
              (fn-for-lom (rest lom)))]))

;; Template Rules Used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Missile ListOfMissile)
;; - reference: (first loi) is Missile
;; - self-reference (rest loi) is ListOfMissile



;; Functions

;; Main Function

;; Game -> Game
;; start the world with (main G0)
;; 
(define (main g)
  (big-bang g                         ; Game
            (on-tick   next-game)     ; Game -> Game
            (to-draw   render)        ; Game -> Image
       ;    (stop-when end-game)      ; Game -> Boolean
            (on-key    key-pressed))) ; Game KeyEvent -> Game

;; Game -> Game
;; Advance and update the game state
;; WRITE CHECKS LATER

;(define (next-game g) G0) ;stub

;; FUNCTION COMPOSITION RULE
(define (next-game g)
  (update-game (advance-game g)))

;; Game -> Game
;; Remove invaders that are hit, randomly generate new invaders
;; WRITE CHECKS LATER

;(define (update-game g) G0) ;stub

;; FUNCTION COMPOSITION RULE
(define (update-game g)
  (create-invaders (remove-invaders g)))

;; Game -> Game
;; Randomly generate new invaders at the top of the screen

;(define (create-invaders g) G0) ;stub

(define (create-invaders g)
  (make-game (generate-invaders (game-invaders g) INVADE-RATE)
             (game-missiles g)
             (game-tank g)))

;; ListOfInvader Integer -> ListOfInvader
;; Randomly add new invaders to the current list of invaders

;(define (generate-invaders loi i) empty) ;stub

;; UNIQUE FUNCTION - whether empty or not, add a new invader to current list of invaders

(define (generate-invaders loi i)
  (cons (add-invader i) loi))

;; Integer -> Invader or Empty
;; If random generator matches a number in the interval [0, INVADE-RATE], create a new invader

;(define (add-invader i) (make-invader 0 0 0)) ;stub

(define (add-invader i)
  (if (= (random i) (/ i 2))
      (make-invader (random WIDTH) -10 (choose-velocity 2))
      empty))

;; Integer (always 2) -> Integer (1.5 or -1.5)
;; Randomly select between a positive and negative integer based on 50/50 odds
;; Controls the initial direction of movement of the invader after spawning
;; I.e. Sometimes moving diagonally right, sometimes moving diagonally left. 

(define (choose-velocity i)
  (if (= (random i) 0)
      INVADER-X-SPEED
      (* -1 INVADER-X-SPEED)))

;; Game -> Game
;; Remove invaders that have been hit by a missile, remove successful missiles
(check-expect (remove-invaders G0) G0) ; no invaders or missiles
(check-expect (remove-invaders G2) G2) ; missile not hit invader
(check-expect (remove-invaders G3)
              (make-game (list I2) (list M1) T1)) ; M2 hit I1 in G3

;(define (remove-invaders g) G0) ;stub

(define (remove-invaders g)
  (make-game (remaining-invaders (game-invaders g) (game-missiles g))
             (remaining-missiles (game-missiles g) (game-invaders g))
             (game-tank g)))

;; ListOfInvader ListOfMissile -> ListOfInvader
;; Returns a list of invaders that have not been hit by missiles
(check-expect (remaining-invaders empty empty) empty)
(check-expect (remaining-invaders (list I1) (list M1))
              (list I1)) ;I1 not hit by M1
(check-expect (remaining-invaders (list I1 I2 I4 I5) (list M2 M4 M5))
              (list I2 I5)) ;I5 not hit by M5
(check-expect (remaining-invaders (list I1 I5 I4) (list M2 M4 M5))
              (list I5)) ;I5 not hit by M5 - checking loi is searched properly
(check-expect (remaining-invaders (list I5 I1 I4) (list M2 M4 M5))
              (list I5)) ;I5 not hit by M5 - checking loi is searched properly

;(define (remaining-invaders loi lom) empty) ;stub

(define (remaining-invaders loi lom)
  (cond [(empty? loi) empty]
        [else
         (if (invader-hit? lom (first loi))
             (remaining-invaders (rest loi) lom)
             (cons (first loi) (remaining-invaders (rest loi) lom)))]))

;; ListOfMissile Invader -> Boolean
;; Produce true if Invader has been hit by any missiles in ListOfMissile
(check-expect (invader-hit? empty I1) false)           ;no missiles
(check-expect (invader-hit? (list M2 M4 M5) I5) false) ;no hit for I5
(check-expect (invader-hit? (list M2 M4 M5) I2) false) ;I2 not hit by any
(check-expect (invader-hit? (list M2 M4 M5) I1) true)  ;M2 (first) hits I1
(check-expect (invader-hit? (list M4 M2 M5) I1) true)  ;M2 (middle) hits I1
(check-expect (invader-hit? (list M4 M5 M2) I1) true)  ;M2 (last) hits I1

;(define (invader-hit? lom i) false) ;stub

(define (invader-hit? lom i)
  (cond [(empty? lom) false]
        [else
         (if (hit? (first lom) i)
             true
             (invader-hit? (rest lom) i))]))

;; ListOfMissile ListOfInvader -> ListOfMissile
;; Returns a list of missiles that have not hit invaders
(check-expect (remaining-missiles empty empty) empty)
(check-expect (remaining-missiles (list M1) (list I1))
              (list M1)) ;I1 not hit by M1
(check-expect (remaining-missiles (list M2 M4 M5) (list I1 I4 I5))
              (list M5)) ;I5 not hit by M5
(check-expect (remaining-missiles (list M2 M5 M4) (list I1 I4 I5))
              (list M5)) ;I5 not hit by M5 - check to see if lom searched properly
(check-expect (remaining-missiles (list M5 M4 M2 (make-missile 10 0)) (list I1 I4 I5))
              (list M5 (make-missile 10 0))) ;I5 not hit by M5 - check to see if lom searched properly
(check-expect (remaining-missiles (list M5 M4 M2 (make-missile 10 -5)) (list I1 I4 I5))
              (list M5))                     ; missiles past edge should be removed

;(define (remaining-missiles lom loi) empty) ;stub

(define (remaining-missiles lom loi)
  (cond [(empty? lom) empty]
        [else
         (if (or (missile-hit? loi (first lom))
                 (missile-too-far? (first lom)))
             (remaining-missiles (rest lom) loi)
             (cons (first lom) (remaining-missiles (rest lom) loi)))]))

;; Missile -> Boolean
;; Return true if Missile has gone past the edge of the screen
(check-expect (missile-too-far? (make-missile 100 200)) false)
(check-expect (missile-too-far? (make-missile 100 0)) false)
(check-expect (missile-too-far? (make-missile 100 -5)) true) ;past top edge of screen = true

;(define (missile-too-far? m) false)

(define (missile-too-far? m)
  (<= (missile-y m) -5))

;; ListOfInvaders Missile -> Boolean
;; Return true if the missile has hit any invader in the loi
(check-expect (missile-hit? empty M1) false)           ;no invaders
(check-expect (missile-hit? (list I1 I4 I5) M1) false) ;no hit
(check-expect (missile-hit? (list I1 I4 I5) M4) true)  ;hit - I4 middle of list
(check-expect (missile-hit? (list I4 I1 I5) M4) true)  ;hit - I4 first of list
(check-expect (missile-hit? (list I1 I5 I4) M4) true)  ;hit - I4 last of list

;(define (missile-hit? loi m) false) ;stub

(define (missile-hit? loi m)
  (cond [(empty? loi) false]
        [else
         (if (hit? m (first loi))
             true
             (missile-hit? (rest loi) m))]))

;; Missile Invader -> Boolean
;; Return true if the missile has hit the invader
(check-expect (hit? M1 I1) false) ;no hit
(check-expect (hit? M2 I1) true)  ;hit

;(define (hit? m i) false) ;stub

(define (hit? m i)
  (and (= (missile-x m) (invader-x i))
       (<= (abs (- (missile-y m) (invader-y i))) HIT-RANGE)))

;; Game -> Game
;; Increase xy of invader and reflect invaders on left/right edge, decrease y of missile
(check-expect (advance-game (make-game empty empty T0))
              (make-game empty empty
                         (make-tank (+ (tank-x T0) TANK-SPEED)
                                    (tank-dir T0)))) ;Invaders and Missiles list empty
(check-expect (advance-game (make-game (list I1 I2 I3) (list M1 M2 M3) T0))
              (make-game (cons (make-invader (+ (invader-x I1) (invader-dx I1))
                                             (+ (invader-y I1) INVADER-Y-SPEED)
                                             (invader-dx I1))
                               (cons (make-invader (+ (invader-x I2) (invader-dx I2))
                                             (+ (invader-y I2) INVADER-Y-SPEED)
                                             (invader-dx I2))
                                     (cons (make-invader (+ (invader-x I3) (invader-dx I3))
                                             (+ (invader-y I3) INVADER-Y-SPEED)
                                             (invader-dx I3)) empty)))
                         (cons (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))
                               (cons (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED))
                                     (cons (make-missile (missile-x M3) (- (missile-y M3) MISSILE-SPEED)) empty)))
                         (make-tank (+ (tank-x T0) TANK-SPEED)
                                    (tank-dir T0)))) ; list of > 2 for Invaders and missiles, tank centred
(check-expect (advance-game (make-game
                             (cons (make-invader WIDTH 50 2) empty)
                             (list M1) T1))
              (make-game (cons (make-invader WIDTH 50 -2) empty)
                         (cons (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)) empty)
                         (make-tank (+ (tank-x T1) TANK-SPEED)
                                    (tank-dir T1)))) ;reflect invader at right edge, tank not centred
(check-expect (advance-game (make-game
                             (cons (make-invader 0 50 -2) empty)
                             (list M1) T2))
              (make-game (cons (make-invader 0 50 2) empty)
                         (cons (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)) empty)
                         (make-tank (- (tank-x T2) TANK-SPEED)
                                    (tank-dir T2)))) ;reflect invader at left edge, tank going left

;(define (advance-game g) G0) ;stub

(define (advance-game g)
  (make-game (advance-invaders (game-invaders g))
             (advance-missiles (game-missiles g))
             (advance-tank (game-tank g))))

;; ListOfInvader -> ListOfInvader
;; Increase the xy of each invader, and reflect invaders on the wall
(check-expect (advance-invaders (list I1 I2 I3))
              (cons (make-invader (+ (invader-x I1) (invader-dx I1))
                                             (+ (invader-y I1) INVADER-Y-SPEED)
                                             (invader-dx I1))
                               (cons (make-invader (+ (invader-x I2) (invader-dx I2))
                                             (+ (invader-y I2) INVADER-Y-SPEED)
                                             (invader-dx I2))
                                     (cons (make-invader (+ (invader-x I3) (invader-dx I3))
                                             (+ (invader-y I3) INVADER-Y-SPEED)
                                             (invader-dx I3)) empty))))
(check-expect (advance-invaders (cons (make-invader WIDTH 50 2)
                                      (cons (make-invader 0 25 -2)
                                            (cons (make-invader 70 70 3) empty))))
              (cons (make-invader WIDTH 50 -2)
                                      (cons (make-invader 0 25 2)
                                            (cons (make-invader 73 71.5 3) empty)))) ;checking list of 3 long with middle, and each reflection case
                        
;(define (advance-invaders loi) empty) ;stub

(define (advance-invaders loi)
  (cond [(empty? loi) empty]
        [else
         (cons (advance-invader (first loi))
               (advance-invaders (rest loi)))]))

;; Invader -> Invader
;; Increase the x, y of an individual invader, reflect dx of invader on the edge
(check-expect (advance-invader I1)
              (make-invader (+ (invader-x I1) (invader-dx I1))
                            (+ (invader-y I1) INVADER-Y-SPEED)
                            (invader-dx I1))) ; advance invader in middle
(check-expect (advance-invader (make-invader WIDTH 50 2))
              (make-invader WIDTH 50 -2))     ; reflect invader at right edge
(check-expect (advance-invader (make-invader 0 25 -2))
              (make-invader 0 25 2))          ; reflect invader at left edge

;(define (advance-invader i) (make-invader 0 0 0)) ;stub

(define (advance-invader i)
  (if (or (= (invader-x i) WIDTH)
          (= (invader-x i) 0))
      (make-invader (invader-x i) (invader-y i) (* -1 (invader-dx i)))
      (make-invader (+ (invader-dx i) (invader-x i))
                    (+ INVADER-Y-SPEED (invader-y i))
                    (invader-dx i))))

;; ListOfMissile -> ListOfMissile
;; Decrease the y of each missile
(check-expect (advance-missiles (list M1 M2 M3))
              (cons (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))
                    (cons (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED))
                          (cons (make-missile (missile-x M3) (- (missile-y M3) MISSILE-SPEED)) empty)))) ;checking list of 3 long

;(define (advance-missiles lom) empty) ;stub

(define (advance-missiles lom)
  (cond [(empty? lom) empty]
        [else
         (cons (advance-missile (first lom))
               (advance-missiles (rest lom)))]))

;; Missile -> Missile
;; Decrease the Y value of the given missile
(check-expect (advance-missile M1)
              (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)))

;(define (advance-missile m) (make-missile 0 0))

(define (advance-missile m)
  (make-missile (missile-x m)
                (- (missile-y m) MISSILE-SPEED)))

;; Tank -> Tank
;; Increase/Decrease tank-x by TANK-SPEED depending on whether tank-dir is +/-
(check-expect (advance-tank T1)
              (make-tank (+ (tank-x T1) TANK-SPEED) (tank-dir T1))) ;moving right
(check-expect (advance-tank T2)
              (make-tank (- (tank-x T2) TANK-SPEED) (tank-dir T2))) ;moving left
              
;(define (advance-tank t) (make-tank 0 0)) ;stub

(define (advance-tank t)
  (cond [(> (tank-dir t) 0)
         (make-tank (+ (tank-x t) TANK-SPEED)
                    (tank-dir t))]
        [(< (tank-dir t) 0)
         (make-tank (- (tank-x t) TANK-SPEED)
                    (tank-dir t))]))

;; Game -> Image
;; render the current game state - including invaders, missiles, and tank
(check-expect (render G2)
              (place-image INVADER (invader-x I1) (invader-y I1)
                           (place-image MISSILE (missile-x M1) (missile-y M1)
                                        (place-image TANK (tank-x T1) (- HEIGHT TANK-HEIGHT/2)
                                                     BACKGROUND))))
                           
;(define (render g) (square 0 "solid" "white")) ;stub

(define (render g)
  (overlay (invaders-image (game-invaders g))
           (missiles-image (game-missiles g))
           (tank-image (game-tank g))
           BACKGROUND))

;; ListOfInvader -> Image
;; Create an image of all the invaders on the screen
(check-expect (invaders-image empty) Transparent-BACKGROUND)
(check-expect (invaders-image (list I1 I4 I5))
              (place-image INVADER (invader-x I1) (invader-y I1)
                           (place-image INVADER (invader-x I4) (invader-y I4)
                                        (place-image INVADER (invader-x I5) (invader-y I5)
                                                     Transparent-BACKGROUND))))

;(define (invaders-image loi) (square 0 "solid" "white")) ;stub

(define (invaders-image loi)
  (cond [(empty? loi) Transparent-BACKGROUND]
        [else
         (place-image INVADER
                      (invader-x (first loi))
                      (invader-y (first loi))
                      (invaders-image (rest loi)))]))

;; ListOfMissile -> Image
;; Create an image of all the missiles on the screen
(check-expect (missiles-image empty) Transparent-BACKGROUND)
(check-expect (missiles-image (list M1 M3 M4))
              (place-image MISSILE (missile-x M1) (missile-y M1)
                           (place-image MISSILE (missile-x M3) (missile-y M3)
                                        (place-image MISSILE (missile-x M4) (missile-y M4)
                                                     Transparent-BACKGROUND))))
                              
;(define (missiles-image lom) (square 0 "solid" "white")) ;stub

(define (missiles-image lom)
  (cond [(empty? lom) Transparent-BACKGROUND]
        [else
         (place-image MISSILE
                      (missile-x (first lom))
                      (missile-y (first lom))
                      (missiles-image (rest lom)))]))

;; Tank -> Image
;; Produce an image of the tank on the screen
(check-expect (tank-image T1)
              (place-image TANK (tank-x T1)
                           (- HEIGHT TANK-HEIGHT/2)
                           Transparent-BACKGROUND))

;(define (tank-image t) (square 0 "solid" "white"))

(define (tank-image t)
  (place-image TANK (tank-x t)
               (- HEIGHT TANK-HEIGHT/2)
               Transparent-BACKGROUND))
               
;; Game KeyEvent -> Game
;; When right arrow key pressed move Tank to the right (left for left arrow key)
;; When space key pressed, fire a missile
(check-expect (key-pressed G0 "right")
              (make-game empty empty (make-tank (tank-x T0) 1)))
(check-expect (key-pressed G0 "left")
              (make-game empty empty (make-tank (tank-x T0) -1)))
(check-expect (key-pressed G0 " ")
              (make-game empty (cons (make-missile (tank-x T0)
                                                   (- HEIGHT TANK-HEIGHT)) empty) T0))

;(define (key-pressed g ke) (make-game empty empty T0)) ;stub

(define (key-pressed g ke)
  (cond [(key=? "right" ke) (make-game (game-invaders g)
                                       (game-missiles g)
                                       (make-tank (tank-x (game-tank g)) 1))]
        [(key=? "left" ke) (make-game (game-invaders g)
                                       (game-missiles g)
                                       (make-tank (tank-x (game-tank g)) -1))]
        [else
         (make-game (game-invaders g)
                    (cons (make-missile (tank-x (game-tank g))
                                        (- HEIGHT TANK-HEIGHT))
                          (game-missiles g))
                    (game-tank g))]))

;; Game -> Boolean
;; Return true when invader reaches bottom of screen (stops the game)
(check-expect (end-game G0) false) ;invader not landed
(check-expect (end-game G3) true)  ;invader landed

;(define (end-game g) false) ;stub

(define (end-game g)
  (any-landed? (game-invaders g)))

;; ListOfInvader -> Boolean
;; Return true if any of the invaders have landed
(check-expect (any-landed? empty) false)
(check-expect (any-landed? (list I1 I4 I5)) false) ;None landed
(check-expect (any-landed? (list I2 I4 I5)) true) ;I2 landed (1st pos in list)
(check-expect (any-landed? (list I4 I2 I5)) true) ;I2 landed (2nd pos in list)
(check-expect (any-landed? (list I4 I5 I2)) true) ;I2 landed (3rd pos in list)

;(define (any-landed? loi) false) ;stub

(define (any-landed? loi)
  (cond [(empty? loi) false]
        [else
         (if (landed? (first loi))
             true
             (any-landed? (rest loi)))]))

;; Invader -> Boolean
;; Return true if an individual invader has landed i.e. Invader-Y >= HEIGHT - 10
(check-expect (landed? I1) false)
(check-expect (landed? I2) true)

(define (landed? i)
  (cond [(empty? i) false]
        [else
         (>= (invader-y i) (- HEIGHT 10))]))
