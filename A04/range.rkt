;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname range) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (in-range) produces the number of elements in the list between interval a and b inclusive
;; Examples
(check-expect (in-range 0 100 (list 1 2 3)) 3)
(check-expect (in-range 0 5 (list 6 7 8)) 0)
;; in-range: NUM NUM LIST -> NUM
(define (in-range a b nums)
    (cond
        [(empty? nums) 0]
        [(and (<= a (first nums)) (<= (first nums) b))
            (add1 (in-range a b (rest nums)))]
        [else (in-range a b (rest nums))]))
;; Test
(check-expect (in-range -100 100 (list -1 0.5 3)) 3)
(check-expect (in-range 0 5 (list 0 5 1)) 3)

;; (spread) produces the absolute difference between max and min of a list
;; Examples
(check-expect (spread (list 10 20 30)) 20)
(check-expect (spread (list 1 2 3)) 2)

;; spread: LIST -> NUM
(define (spread nums)
    (- (max_list nums) (min_list nums)))

;; Test
(check-expect (spread (list 0 0 0)) 0)
(check-expect (spread (list -1 0 1)) 2)

(define (max_list nums)
    (cond
        [(< (length nums) 2) (first nums)]
        [(= (length nums) 2) (cond
            [(> (first nums) (second nums)) (first nums)]
            [else (second nums)])]
        [(> (first nums) (second nums)) (max_list (cons (first nums) (rest (rest nums))))]
        [else (max_list (cons (second nums) (rest (rest nums))))]))

(define (min_list nums)
    (cond
        [(< (length nums) 2) (first nums)]
        [(= (length nums) 2) (cond
            [(> (first nums) (second nums)) (second nums)]
            [else (first nums)])]
        [(< (first nums) (second nums)) (min_list (cons (first nums) (rest (rest nums))))]
        [else (min_list (cons (second nums) (rest (rest nums))))]))