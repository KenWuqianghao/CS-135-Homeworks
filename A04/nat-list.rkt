;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname nat-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (nat->list) produces a list of reversely ordered digits from a naturla number
;; Examples
(check-expect (nat->list 101) (list 1 0 1))
(check-expect (nat->list 100) (list 0 0 1))

;; nat->list: NAT -> LIST
(define (nat->list num)
    (cond
        [(= 0 num) (cons 0 empty)]
        [(and (> num 0) (< num 10)) (cons num empty)]
        [else
            (cons (remainder num 10) (nat->list (/ (- num (remainder num 10)) 10)))]))

;; Tests
(check-expect (nat->list 0) (list 0))
(check-expect (nat->list 13579) (list 9 7 5 3 1))

(define (recurse_list arr counter length)
    (cond
        [(= (sub1 length) counter) (* (first arr) (expt 10 counter))]
        [else (+ (* (first arr) (expt 10 counter)) (recurse_list (rest arr) (add1 counter) length))]
        ))

;; (list->nat) produces a natural number from a list of reversly ordered list
;; Examples
(check-expect (list->nat (list 1 0 1)) 101)
(check-expect (list->nat (list 0 0 1)) 100)

;; list->nat: LIST -> NAT
(define (list->nat arr)
    (recurse_list arr 0 (length arr)))

;; Tests
(check-expect (list->nat (list 0)) 0)
(check-expect (list->nat (list 9 7 5 3 1)) 13579)