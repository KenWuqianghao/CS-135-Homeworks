;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname waterloo2-poker) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define suits
    (cons 'C (cons 'D (cons 'H (cons 'S empty)))))

(define ranks
    (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 (cons 7 (cons 8 (cons 9 (cons 10 
    (cons 'J (cons 'Q (cons 'K (cons 'A empty))))))))))))))

(define (card Rank suit)
  (cons Rank (cons suit empty)))

(define (hand card_1 card_2)
  (cons card_1 (cons card_2 empty)))

(define (rank card)
  (first card))

(define (suit card)
  (second card))

(define flush_hand
  (cons (cons 3 (cons 'H empty)) (cons (cons 'J (cons 'H empty)) empty)))

(define straight_hand
  (cons (cons 'J (cons 'S empty)) (cons (cons 'Q (cons 'D empty)) empty)))

(define straight_flush_hand
  (cons (cons 'J (cons 'H empty)) (cons (cons 10 (cons 'H empty)) empty)))

(define pair_hand
  (cons (cons 10 (cons 'H empty)) (cons (cons 10 (cons 'H empty)) empty)))

;; (ordinality card) produces the ordinality of a card
;; Examples
(check-expect (ordinality (cons 'A (cons 'S empty))) 14)
(check-expect (ordinality (cons 8 (cons 'D empty))) 8)
(check-expect (ordinality (cons 4 (cons 'D empty))) 4)
;; ordinality: Card -> Nat
(define (ordinality card)
  (cond
    [(number? (rank card)) (rank card)]
    [(symbol=? (rank card) 'J) 11]
    [(symbol=? (rank card) 'Q) 12]
    [(symbol=? (rank card) 'K) 13]
    [(symbol=? (rank card) 'A) 14]))

;; Tests
(check-expect (ordinality (cons 'Q (cons 'S empty))) 12)
(check-expect (ordinality (cons 4 (cons 'D empty))) 4)
(check-expect (ordinality (cons 10 (cons 'D empty))) 10)

(define (straight_flush hand)
  (cond 
    [(and (straight hand) (flush hand)) true]
    [else false]))

(define (pair hand)
  (cond
    [(= (ordinality (first hand)) (ordinality (second hand))) true]
    [else false]))

(define (straight hand)
  (cond
    [(= 1 (abs (- (ordinality (first hand)) (ordinality (second hand))))) true]
    [else false]))

(define (flush hand)
  (cond
    [(symbol=? (suit (first hand)) (suit (second hand))) true]
    [else false]))

;; (strength hand) produces the strength of a hand
;; Examples
(check-expect (strength flush_hand) 1)
(check-expect (strength straight_hand) 2)
(check-expect (strength (cons (cons 3 (cons 'Q empty)) (cons (cons 'J (cons 'H empty)) empty))) 0)
;; strength: Hand -> Nat
(define (strength hand)
  (cond
    [(straight_flush hand) 4]
    [(pair hand) 3]
    [(straight hand) 2]
    [(flush hand) 1]
    [else 0]))

;; Tests
(check-expect (strength straight_flush_hand) 4)
(check-expect (strength pair_hand) 3)

;; (hand<? hand_1 hand_2) produces true if hand_2 is stronger than hand_1, otherwise false
;; Examples
(check-expect (hand<? flush_hand straight_hand) true)
(check-expect (hand<? straight_hand straight_flush_hand) true)
(check-expect (hand<? flush_hand straight_flush_hand) true)
;; hand<?: Hand Hand -> Bool
(define (hand<? hand_1 hand_2)
  (cond 
    [(> (strength hand_2) (strength hand_1)) true]
    [else false]))

;; Tests
(check-expect (hand<? straight_hand flush_hand ) false)
(check-expect (hand<? straight_flush_hand straight_hand) false)
(check-expect (hand<? flush_hand flush_hand) false)

;; (winner hand_1 hand_2) produces the winner of the two hands
;; Examples
(check-expect (winner straight_hand flush_hand) 'hand1)
(check-expect (winner straight_hand straight_flush_hand) 'hand2)
(check-expect (winner straight_flush_hand straight_flush_hand) 'tie)
;; (winner hand_1 hand_2): Hand Hand -> Hand
(define (winner hand_1 hand_2)
   (cond 
    [(> (strength hand_2) (strength hand_1)) 'hand2]
    [(< (strength hand_2) (strength hand_1)) 'hand1]
    [else 'tie]))

;; Tests
(check-expect (winner flush_hand straight_hand) 'hand2)
(check-expect (winner straight_flush_hand straight_hand) 'hand1)
(check-expect (winner flush_hand flush_hand) 'tie)

(define (valid_suit? suit)
    (cond
        [(member? suit suits) true]
        [else false]))

(define (valid_rank? rank)
    (cond
        [(member? rank ranks) true]
        [else false]))

(define (card_valid? card)
    (cond
        [(and (valid_suit? (second card)) (valid_rank? (first card)) 
        (= (length card) 2)) true]
        [else false]))

(define (two_card_valid? card_1 card_2)
    (cond
        [(and (card_valid? card_1) (card_valid? card_2)) true]
        [else false]))

(define (valid_card_list? hand)
    (cond
        [(and (cons? (first hand)) (cons? (second hand))
        (= (length hand) 2) (two_card_valid? (first hand) (second hand))) true]
        [else false]))

;; (valid_hand? hand) produces true if provided hand is a valid hand, otherwise false
;; Examples
(check-expect (valid-hand? flush_hand) true)
(check-expect (valid-hand? straight_hand) true)
;; (valid-hand? hand): Any -> Bool
(define (valid-hand? hand)
    (cond
        [(cons? hand) (valid_card_list? hand)]
        [else false]))

;; Tests
(check-expect (valid-hand? '()) false)
(check-expect (valid-hand? 0) false)
(check-expect (valid-hand? "test") false)