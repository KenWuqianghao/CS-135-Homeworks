;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname or-map) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (my-ormap pred? lox) produces true if pred? is true for any
;;   of the elements in the lox (and false otherwise)
;; my-ormap: (X -> Bool) (listof Num) -> Bool
;; Examples:
(check-expect (my-ormap zero? '(8 6 7 5 3 0 9)) true)
(check-expect (my-ormap empty? '(8 6 7 5 3 0 9)) false)

(define (my-ormap pred? lox)
  (cond
    [(empty? lox) false]
    [(pred? (first lox)) true]
    [else (my-ormap pred? (rest lox))]))

;; Tests:

;; (pred?-ormap val lox) consumes a value (of type X) and a
;;   list of type (listof (X -> Bool)) (in that order) and
;;   produces true if any of the elements in the list are true
;;   when passed the value (and false otherwise).
;; pred?-ormap: X (listof (X -> Bool)) -> Bool
;; Examples:
(check-expect (pred?-ormap 5 (list zero? even? negative? posn? inexact?)) false)
(check-expect (pred?-ormap 0 (list zero? even? negative? posn? inexact?)) true)

(define (pred?-ormap val lox)
  (local
    [(define op (cond
                  [(empty? lox) false]
                  [else (first lox)]))]
  (cond
    [(empty? lox) false]
    [(op val) true]
    [else (pred?-ormap val (rest lox))])))

;; Tests: