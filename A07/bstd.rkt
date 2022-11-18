;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname bstd) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (key val left right))
;; A Node is a (make-node Nat String BSTD BSTD)
;; requires: key > every key in left BSTD
;; key < every key in right BSTD
;; A binary search tree dictionary (BSTD) is one of:
;; * empty
;; * Node

;; A sorted association list (SAL) is one of:
;; * empty
;; * (cons (list Nat Str) SAL)
;;
;; Requires: each key (Nat) is unique
;;
;; list elements in SAL are sorted by key (Nat)
;; in increasing order

(define sal-top-songs
(list (list 1 "Respect")
(list 3 "A Change is Gonna Come")
(list 7 "Strawberry Fields Forever")
(list 9 "Dreams")
(list 12 "Superstition")
(list 17 "Bohemian Rhapsody")
(list 19 "Imagine")
(list 21 "Strange Fruit")
(list 25 "Runaway")
(list 33 "Johnny B. Goode")))

(define bstd-top-songs
(make-node 12 "Superstition"
(make-node 3 "A Change is Gonna Come"
(make-node 1 "Respect" empty empty)
(make-node 7 "Strawberry Fields Forever"
empty
(make-node 9 "Dreams" empty empty)))
(make-node 21 "Strange Fruit"
(make-node 17 "Bohemian Rhapsody"
empty
(make-node 19 "Imagine" empty empty))
(make-node 25 "Runaway"
empty
(make-node 33 "Johnny B. Goode" empty empty)))))

;; (build-bstd sal) consumes a SAL and produces a BSTD
;; Examples
(check-expect (build-bstd sal-top-songs) bstd-top-songs)

;; build-bstd: SAL -> BSTD
(define (build-bstd sal)
    (cond
      [(empty? sal) empty]
      [else
       (make-node (first (list-ref sal (center sal)))
                  (second (list-ref sal (center sal)))
                  (build-bstd (left-subtree sal (list-ref sal (center sal))))
                  (build-bstd (right-subtree sal (list-ref sal (center sal)))))]))

;; Tests
(check-expect (build-bstd empty) empty)
(check-expect (build-bstd empty) empty)
(check-expect (build-bstd (list (list 1 "Respect"))) (make-node 1 "Respect" empty empty))
(check-expect (build-bstd (list (list 1 "Respect") (list 3 "A Change is Gonna Come")))
              (make-node 1 "Respect" empty (make-node 3 "A Change is Gonna Come" empty empty)))

(define (center sal)
  (cond
    [(= 0 (remainder (length sal) 2)) (sub1 (quotient (length sal) 2))]
    [(= 1 (remainder (length sal) 2)) (quotient (length sal) 2)]))
  
(define (left-subtree sal center)
  (cond
    [(empty? sal) empty]
    [(< (first (first sal)) (first center))
     (cons (list (first (first sal)) (second (first sal)))
           (left-subtree (rest sal) center))]
    [else (left-subtree (rest sal) center)]))

(define (right-subtree sal center)
  (cond
    [(empty? sal) empty]
    [(> (first (first sal)) (first center))
     (cons (list (first (first sal)) (second (first sal)))
           (right-subtree (rest sal) center))]
    [else (right-subtree (rest sal) center)]))

;; (range-query bstd start end) consumes a BSTD and two natural numbers,
;; the first smaller than the second, and produces a list of all the
;; corresponding values (Str) in that range, inclusively, ordered 
;; from the value with the smallest key to the largest key
;; Examples
(check-expect (range-query bstd-top-songs 3 18)
'("A Change is Gonna Come" "Strawberry Fields Forever" "Dreams"
"Superstition" "Bohemian Rhapsody"))

;; range-query: BSTD Nat Nat -> (listof Str)
(define (range-query btsd start end)
    (cond
      [(empty? btsd) empty]
      [(and (>= (node-key btsd) start) (<= (node-key btsd) end))
       (append (range-query (node-left btsd) start end)
               (list (node-val btsd))
               (range-query (node-right btsd) start end))]
      [(> (node-key btsd) end) (range-query (node-left btsd) start end)]
      [(< (node-key btsd) start) (range-query (node-right btsd) start end)]))

;; Tests
(check-expect (range-query bstd-top-songs 1 1) '("Respect"))
(check-expect (range-query bstd-top-songs 100 200) '())
(check-expect (range-query bstd-top-songs 1 33) (list
 "Respect"
 "A Change is Gonna Come"
 "Strawberry Fields Forever"
 "Dreams"
 "Superstition"
 "Bohemian Rhapsody"
 "Imagine"
 "Strange Fruit"
 "Runaway"
 "Johnny B. Goode"))
(check-expect (range-query bstd-top-songs 0 10) (list
 "Respect"
 "A Change is Gonna Come"
 "Strawberry Fields Forever"
 "Dreams"))

(range-query bstd-top-songs 3 17)