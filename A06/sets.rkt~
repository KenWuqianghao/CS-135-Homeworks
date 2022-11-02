;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sets) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (union) produces a set of NAT from union of two sets of NAT
;; Examples
(check-expect (union (list 1 2 3) (list 1 2 3)) (list 1 2 3))
(check-expect (union (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6))

;; union: (listof Nat) (listof Nat) -> (listof Nat)
(define (union s1 s2)
  (sel-sort (unsorted-union/acc s1 s2 s2)))

;; Tests

(define (unsorted-union/acc s1 s2 unsorted-union)
  (cond
    [(empty? s1) unsorted-union]
    [(in-set? s2 (first s1)) (unsorted-union/acc (rest s1) s2 unsorted-union)]
    [else (unsorted-union/acc (rest s1) s2 (append unsorted-union (list (first s1))))]))
  
(define (in-set? set num)
  (cond
    [(empty? set) false]
    [(= (first set) num) true]
    [else (in-set? (rest set) num)]))

(define (sel-sort nums)
    (cond
      [(empty? nums) empty]
      [else (sel-sort/sf nums)]))

(define (sel-sort/sf sf)
    (cond
      [(empty? sf) empty]
      [else (cons (first (smallest-first sf)) (sel-sort/sf (rest (smallest-first sf))))]))

(define (smallest-first nums)
    (smallest-first/acc nums (first nums) empty))

(define (smallest-first/acc nums min min-list)
    (cond
      [(empty? nums) min-list]
      [(< (first nums) min) (smallest-first/acc (rest nums) (first nums)
                                               (append (list (first nums)) min-list))]
      [else (smallest-first/acc (rest nums) min (append min-list (list (first nums))))]))

;; (intersection) produces a set of NAT from intersection of two sets of NAT
;; Examples
(check-expect (intersection (list 1 2 3) (list 4 5 6)) empty)
(check-expect (intersection (list 1 2 3) (list 1 2 3)) (list 1 2 3))

;; intersection:  (listof Nat) (listof Nat) -> (listof Nat)
(define (intersection s1 s2)
    (cond
      [(empty? s1) empty]
      [(in-set? s2 (first s1)) (cons (first s1) (intersection (rest s1) s2))]
      [else (intersection (rest s1) s2)]))

;; Tests
