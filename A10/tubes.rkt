;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname tubes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "lib-tubes.rkt")

;; A Game is (make-game Nat Nat (listof (listof Sym)))
(define-struct game (tubesize maxcolours tubes))

;;; Constants

(define emptygame
  (make-game 0 5
             (list empty empty empty empty empty)))

(define emptygame2
  (make-game 10 3 empty))

(define emptygame3
  (make-game 10 3 (list empty empty)))

(define smallgame1nextmoves (list
                                           (make-game 2 2
             (list (list 'blue 'blue 'red)
                   (list 'red)
                   (list)))
                                           (make-game 2 2
             (list (list 'red)
                   (list 'blue 'blue 'red)))
                                           (make-game 2 2
             (list (list 'red)
                   (list 'blue 'red)
                   (list 'blue)))
                                           (make-game 2 2
             (list (list 'blue 'red)
                   (list 'red)
                   (list 'blue)))))

(define smallgame1
  (make-game 2 2
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))

(define smallgame2
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))

(define smallinvalidgame1
  (make-game 2 1
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))


(define smallinvalidgame2
  (make-game 2 2
             (list (list 'blue 'red)
                   (list 'blue 'blue)
                   (list))))

(define smallinvalidgame3
  (make-game 2 2
             (list (list 'blue 'red 'blue)
                   (list 'red)
                   (list))))


(define smallgamefinal
  (make-game 2 2
             (list (list)
                   (list 'blue 'blue)
                   (list 'red 'red))))


(define mediumgame
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'red 'yellow)
                   (list 'yellow 'blue)
                   (list))))

(define mediumgamestuck
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'red 'yellow)
                   (list 'yellow 'blue)
                   )))

(define largergame
  (make-game 3 3
             (list (list 'blue 'red 'red)
                   (list 'yellow 'blue 'yellow)
                   (list 'red 'yellow 'blue)
                   (list))))

(define biggame
  (make-game 5 3
             (list (list 'blue 'blue 'red 'red 'yellow)
                   (list 'red 'red 'yellow 'blue 'red)
                   (list 'yellow 'blue 'blue 'yellow 'yellow)
                   (list)
                   (list))))

(define biggame2
  (make-game 5 3
             (list (list 'yellow 'blue 'blue 'yellow 'yellow)
                   (list 'red 'red 'yellow 'blue 'red)
                   (list)
                   (list 'blue 'blue 'red 'red 'yellow)
                   (list))))

(define biggamesolve
  (make-game 5 3
             (list (list 'blue 'blue 'blue 'blue 'blue)
                   (list 'red 'red 'red 'red 'red)
                   (list 'yellow 'yellow 'yellow 'yellow 'yellow)
                   (list)
                   (list))))

(define hugegame
  (make-game 4 9
             (list (list 'purple 'pink 'yellow 'blue)
                   (list 'blue 'green 'purple 'white)
                   (list 'orange 'yellow 'black 'blue)
                   (list 'white 'orange 'orange 'pink)
                   (list 'pink 'red 'red 'black)
                   (list 'yellow 'green 'orange 'blue)
                   (list 'white 'purple 'red 'yellow)
                   (list 'green 'red 'green 'black)
                   (list 'purple 'black 'white 'pink)
                   (list)
                   (list))
             ))

;; (check-colour? size num los) consumes two natural numbers,
;;   size and num, and a list of symbols, los, and produces
;;   true if each symbol in the list appears exactly size
;;   times and if there are at most num different symbols;
;;   otherwise, check-colour? will produce false
;; check-colour?: Nat Nat (listof Sym) -> Bool
;; Examples:
(check-expect (check-colour? 1 1 '(symbol)) true)
(check-expect (check-colour? 1 1 '(symbol another-symbol)) false)

(define (check-colour? size num los)
  (and (symbol-occurence size los) (>= num (different-symbol/acc los 0))))

(define (different-symbol/acc los counter)
  (cond
    [(empty? los) counter]
    [else (different-symbol/acc
           (filter (lambda (symbol) (not (symbol=? symbol (first los)))) los)
           (add1 counter))]))

(define (symbol-occurence size los)
  (local
    [(define removed (filter (lambda (symbol) (not (symbol=? symbol (first los)))) los))]
  (cond
    [(empty? los) true]
    [(= (- (length los) (length removed)) size)
     (symbol-occurence size removed)]
    [else false])))

;; Tests:
(check-expect (check-colour?  1 1 '(test)) true)
(check-expect (check-colour? 1 1 '(test another-test)) false)
(check-expect (check-colour? 2 1 '(test)) false)
(check-expect (check-colour? 1 100 '(test)) true)

;; (valid-game? gm) consumes a Game, gm, and produces true if
;;   gm is a valid game, and false otherwise
;; valid-game?: Game -> Bool
;; Examples:
(check-expect (valid-game? emptygame) true)
(check-expect (valid-game? smallinvalidgame1) false)

(define (valid-game? gm)
  (...))

;; Tests:

;; (remove-completed gm) consumes a Game, gm, and produces a
;;   Game which is similar to gm but has any completed tubes
;;   removed
;; remove-completed: Game -> Game
;; Examples:
(check-expect (remove-completed smallgame1) smallgame1)
(check-expect (remove-completed smallgame2) smallgame1)

(define (remove-completed gm)
  (...))

;; Tests:

;; (finished-game? gm) consumes a Game, gm, and produces true
;;   if the game is finished, and false otherwise
;; finished-game?: Game -> Bool
;; Examples:
(check-expect (finished-game? smallgame1) false)
(check-expect (finished-game? smallgame2) false)

(define (finished-game? gm)
  (...))

;; Tests:

;; (num-blocks llos) consumes a list of lists of symbols,
;;   llos, and produces the number of “blocks” contained in
;;   llos
;; num-blocks: (listof (listof Sym)) -> Nat
;; Examples:
(check-expect (num-blocks empty) 0)
(check-expect (num-blocks (list '(a a a) '(a a b a a))) 4)

(define (num-blocks llos)
  (...))

;; Tests:

;; (equiv-game? gm1 gm2) consumes two Games, gm1 and gm2, and
;;   produces true if gm1 and gm2 are equivalent, and false
;;   otherwise
;; equiv-game?: Game Game -> Bool
;; Examples:
(check-expect (equiv-game? smallgame1 smallgame1) true)
(check-expect (equiv-game? smallgame1 hugegame) false)

(define (equiv-game? gm1 gm2)
  (...))

;; Tests:

;; (all-equiv? log1 log2) consumes two lists of Games, log1
;;   and log2, and produces true if every game in log1 has one
;;   equivalent game in log2, and every game in log2 has one
;;   equivalent game in log1, and otherwise produces false
;; all-equiv?: (listof Game) (listof Game) -> Bool
;; Examples:
(check-expect (all-equiv? (list smallgame1) (list smallgame1)) true)
(check-expect (all-equiv? (list smallgame1) (list hugegame)) false)

(define (all-equiv? log1 log2)
  (...))

;; Tests:

(define (test-next-games gm expected) (all-equiv? (next-games gm) expected))

;; (next-games gm) consumes a Game, gm, and produces a list of
;;   Games that can happen by moving one ball from gm
;; next-games: Game -> (listof Game)
;; Examples:
(check-expect (test-next-games smallgame1 smallgame1nextmoves)
              true)

(define (next-games gm)
  (...))

;; Tests:

;;;;;

;; (solve gm draw-option) determines if the game gm is solveable,
;; and will also draw each possible move depending on the draw-option

;; Examples:
;; students should provide some here, or just in tests

;; solve: Game (anyof 'off 'norm 'slow 'fast) -> Bool

(define (solve gm draw-option)
  (local
    [(define setup (puzzle-setup gm draw-option))                
     (define (solve-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [else
          (local
            [(define draw (draw-board (first to-visit) draw-option))] 
            (cond
              [(finished-game? (first to-visit)) true]
              [(member? (first to-visit) visited)
               (solve-helper (rest to-visit) visited)]
              [else
               (local [(define nbrs (next-games (first to-visit)))
                       (define new (filter (lambda (x) (not (member? x visited))) nbrs))
                       (define new-to-visit (append new (rest to-visit)))
                       (define new-visited (cons (first to-visit) visited))]
                 (solve-helper new-to-visit new-visited))]))]))]
    (solve-helper (list gm) empty)))

;; Test cases that can be uncommented as the solution is completed

;(check-expect (solve smallgame1 'slow) true)
;(check-expect (solve mediumgamestuck 'slow) false)

;; Below is the format for testing and timing the solution:
;; be sure to remove any other check-expects when measuring your timing

;(check-expect (time (solve mediumgame 'off)) true)
;(check-expect (time (solve largergame 'off)) true)
;(check-expect (time (solve biggame 'off)) true)
;(check-expect (time (solve hugegame 'off)) true)