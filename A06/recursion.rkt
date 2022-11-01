;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname recursion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (in-range) produces the number of elements in the list between interval a and b inclusive
;; Examples
(check-expect (in-range 0 100 (list 1 2 3)) 3)
(check-expect (in-range 0 5 (list 6 7 8)) 0)
;; in-range: Num Num (listof Num) -> Num
(define (in-range a b nums)
    (length (in-range/acc empty nums a b)))

;; Test

(define (in-range/acc in_range nums a b)
    (cond
        [(empty? nums) in_range]
        [(and (<= a (first nums)) (>= b (first nums)))
        (in-range/acc (cons (first nums) in_range) (rest nums) a b)]
        [else (in-range/acc in_range (rest nums) a b)]))

;; (spread) produces the absolute difference between max and min of a list
;; Examples
(check-expect (spread (list 10 20 30)) 20)
(check-expect (spread (list 1 2 3)) 2)

;; spread: (listof Num) -> Num
(define (spread nums)
    (- (first (spread/acc nums (first nums) (first nums)))
       (second (spread/acc nums (first nums) (first nums)))))

;; Test
(check-expect (spread (list 0 0 0)) 0)
(check-expect (spread (list -1 0 1)) 2)

(define (spread/acc nums max min)
    (cond
      [(empty? nums) (list max min)]
      [(> (first nums) max) (spread/acc nums (first nums) min)]
      [(< (first nums) min) (spread/acc nums max (first nums))]
      [else (spread/acc (rest nums) max min)]))

;; (sel-sort) produces a list of sorted numnbers
;; Examples
(check-expect (sel-sort (list 1 2 3)) (list 1 2 3))
(check-expect (sel-sort (list 7 6 8)) (list 6 7 8))
;; sel-sort: (listof Num) -> (listof Num)
(define (sel-sort nums)
    (cond
      [(empty? nums) empty]
      [else (sel-sort/sf nums)]))

;; (sel-sort/sf) produces a list of sorted numbers from a given list
;; Examples
(check-expect (sel-sort/sf (list 1 2 3)) (list 1 2 3))
(check-expect (sel-sort/sf (list 7 6 8)) (list 6 7 8))
;; sel-sort/sf: (listof Num) -> (listof Num)
(define (sel-sort/sf sf)
    (cond
      [(empty? sf) empty]
      [else (cons (first (smallest-first sf)) (sel-sort/sf (rest (smallest-first sf))))]))

;; (smallest-first) produces a list of numnbers with the smallest in the first place
;; Examples
(check-expect (smallest-first (list 1 2 3)) (list 1 2 3))
(check-expect (smallest-first (list 7 6 8)) (list 6 7 8))
;; smallest-first (listof Num) -> (listof Num)
(define (smallest-first nums)
    (smallest-first/acc nums (first nums) empty))

;; (smallest-first/acc) produces a list of numnbers with the smallest in the first place
;; Examples
(check-expect (smallest-first/acc (list 1 2 3) 3 empty) (list 1 2 3))
(check-expect (smallest-first/acc (list 7 6 8) 8 empty) (list 6 7 8))
;; smallest-first/acc (listof Num) -> (listof Num)
(define (smallest-first/acc nums min min-list)
    (cond
      [(empty? nums) min-list]
      [(< (first nums) min) (smallest-first/acc (rest nums) (first nums)
                                               (append (list (first nums)) min-list))]
      [else (smallest-first/acc (rest nums) min (append min-list (list (first nums))))]))