;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname median) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (median-of-3-simple) produce the median of a, b, and c
;; Examples:
(check-expect (median-of-3-simple 1 2 3) 2)
(check-expect (median-of-3-simple 10 15 20) 15)

;; median-of-3: Num Num Num -> Num
(define (median-of-3-simple a b c)
    (cond
        [(< a b c) b]
        [(< a c b) c]
        [(< b a c) a]
        [(< b c a) c]
        [(< c a b) a]
        [(< c b a) b]
        [else a]))

;; Tests
(check-expect (median-of-3-simple -1 -2 -3) -2)
(check-expect (median-of-3-simple 10 100 1000) 100)
(check-expect (median-of-3-simple 1/5 1/3 1/2) 1/3)
(check-expect (median-of-3-simple 1.5 2.5 3.5) 2.5)
(check-expect (median-of-3-simple 0 0 0) 0)