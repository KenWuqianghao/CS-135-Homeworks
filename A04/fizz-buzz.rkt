;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fizz-buzz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (fizz-buzz) produces a list containing fizz, buzz, honk and numbers depending n
;; divisibility of the numbers in a certain range
;;Examples
(check-expect (fizz-buzz 1 5 10 20) (list 1 2 3 4 5))
(check-expect (fizz-buzz 8 15 3 5) (list 8 'fizz 'buzz 11 'fizz 13 14 'honk))

;; fizz-buzz: INT INT INT INT -> LIST
(define (fizz-buzz start end fizz buzz)
    (cond
        [(= start end) (cons (fizz-buzz-cond start fizz buzz) empty)]
        [else (cons (fizz-buzz-cond start fizz buzz)
            (fizz-buzz (add1 start) end fizz buzz))]))

;; Tests
(check-expect (fizz-buzz -1 -1 1 2) (list 'fizz 'fizz 'fizz))
(check-expect (fizz-buzz 1 3 1 3) (list 'fizz 'fizz 'honk))

(define (fizz-buzz-cond num fizz buzz)
    (cond
        [(and (= (remainder num fizz) 0)
            (= (remainder num buzz) 0)) 'honk]
        [(= (remainder num fizz) 0) 'fizz]
        [(= (remainder num buzz) 0) 'buzz]
        [else num]))