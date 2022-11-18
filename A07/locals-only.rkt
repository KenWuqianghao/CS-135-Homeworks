;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname locals-only) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (normalize lon) consumes a non-empty list of numbers, lon, and
;; produces a normalized list of those numbers.
;; Examples
(check-expect (normalize '(2 4 6)) '(0 0.5 1))
(check-expect (normalize '(1 2 3)) '(0 0.5 1))

;; normalize: (listof Num) -> (listof Num)
(define (normalize lon)
  (local
    [(define (max-list lon)
        (cond
          [(empty? (rest lon)) (first lon)]
          [else (max (first lon) (max-list (rest lon)))]))
     (define (min-list lon)
       (cond
         [(empty? (rest lon)) (first lon)]
         [else (min (first lon) (min-list (rest lon)))]))
     
     (define (equation num max min)
       (/ (- num min) (- max min)))
     
     (define (normalize-local lon max min)
       (cond
         [(= min max) lon]
         [ (empty? lon) empty]
         [else (cons (equation (first lon) max min) (normalize-local (rest lon) max min))]))]
    
    (normalize-local lon (max-list lon) (min-list lon))))

;; Tests
(check-expect (normalize '(1)) '(1))
(check-expect (normalize '(1 1 1)) '(1 1 1))
(check-expect (normalize '(1 3 5 7 9)) '(0 0.25 0.5 0.75 1))
(check-expect (normalize '(-1 0 1)) '(0 0.5 1))