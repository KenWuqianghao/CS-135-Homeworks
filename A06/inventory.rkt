;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname inventory) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define models (list "Hyundai Kona" "Audi e-Tron" "Chevy Bolt"
"BMW i4" "Tesla M3" "Nissan Leaf"))
(define years (list 2022 2021 2020 2022 2022 2013))
(define prices (list 36000 40000 35000 53000 60000 5000))
(define mileage (list 12000 4000 3050 25 5 230000))
(define mpge (list 132 63 123 75 133 98))

;; ev: Str Nat Num Num Num Num -> ev
(define-struct ev (model year price mileage mpge))
;; an EV is a (make-ev Str Nat Num Num Num Num)

;; (adjust-prices) produces a modified list of EVs according to the percentage change in price
;; Examples
(check-expect (adjust-prices (list (make-ev "BMW" 2000 1000 0 100)) 0.1)
              (list (make-ev "BMW" 2000 1100 0 100)))
(check-expect (adjust-prices (list (make-ev "BMW" 2000 1000 0 100)) -0.1)
              (list (make-ev "BMW" 2000 900 0 100)))

;; adjust-prices: ev Num -> ev
(define (adjust-prices list-ev num)
    (cond
      [(empty? list-ev) empty]
      [else (cons (adjust-ind-ev (first list-ev) num)
                  (adjust-prices (rest list-ev) num))]))

;; Tests

(define (adjust-ind-ev ev num)
  (make-ev (ev-model ev)
             (ev-year ev)
             (+ (ev-price ev) (* (ev-price ev) num))
             (ev-mileage ev)
             (ev-mpge ev)))

;; (build-inventory) produces list of EVs with given information
;; Examples
(check-expect (build-inventory models years prices mileage mpge)
(list (make-ev "Nissan Leaf" 2013 5000 230000 98)
(make-ev "Tesla M3" 2022 60000 5 133)
(make-ev "BMW i4" 2022 53000 25 75)
(make-ev "Chevy Bolt" 2020 35000 3050 123)
(make-ev "Audi e-Tron" 2021 40000 4000 63)
(make-ev "Hyundai Kona" 2022 36000 12000 132)))
(check-expect (build-inventory  (list "Nissan Leaf") (list 2013) (list 5000) (list 23000)
(list 98)) (list (make-ev "Nissan Leaf" 2013 5000 23000 98)))
;; build-inventory: (listof Str) (listof Nat) (listof Num) (listof Num) (listof Num)-> ListOfEVs
(define (build-inventory models years prices mileage mpge)
    (build-inventory/acc models years prices mileage mpge empty))

(define (build-inventory/acc models years prices mileage mpge inventory)
  (cond
    [(empty? models) inventory]
    [else (build-inventory/acc (rest models) (rest years) (rest prices)
                                (rest mileage) (rest mpge)
                                (append (list (make-ev (first models) (first years)
                                      (first prices) (first mileage) (first mpge))) inventory))]))

;; Tests

;; (compare-ev) produces a symbol indicating if one EV is greater than, equal to or less than
;; another EV
;; Examples
(check-expect (compare-ev
(make-ev "Nissan Leaf" 2013 5000 230000 98)
(make-ev "Tesla M3" 2022 60000 5 133)) 'lt)
(check-expect (compare-ev
(make-ev "Tesla M3" 2022 60000 5 133)
(make-ev "Nissan Leaf" 2013 5000 230000 98)) 'gt)

;; compare-ev: ev ev -> Sym
(define (compare-ev ev_1 ev_2)
    (cond
      [(> (ev-year ev_1) (ev-year ev_2)) 'gt]
      [(> (ev-year ev_2) (ev-year ev_1)) 'lt]
      [(> (ev-mpge ev_1) (ev-mpge ev_2)) 'gt]
      [(> (ev-mpge ev_2) (ev-mpge ev_1)) 'lt]
      [(> (ev-mileage ev_1) (ev-mileage ev_2)) 'lt]
      [(> (ev-mileage ev_2) (ev-mileage ev_1)) 'gt]
      [else 'eq]))

;; Tests

;; (sort-evs) produces a sorted list of EVs
;; Examples
(check-expect (sort-evs (list
(make-ev "Nissan Leaf" 2013 5000 230000 98)
(make-ev "Tesla M3" 2022 60000 5 133)))
(list (make-ev "Tesla M3" 2022 60000 5 133)
(make-ev "Nissan Leaf" 2013 5000 230000 98)))

;; sort-evs: ListOfEVs -> LisOfEVs
(define (sort-evs ev)
    (cond
      [(empty? ev) empty]
      [else (sel-sort/sf ev)]))

;; Tests

(define (sel-sort/sf sf)
    (cond
      [(empty? sf) empty]
      [else (cons (first (smallest-first sf)) (sel-sort/sf (rest (smallest-first sf))))]))

(define (smallest-first ev)
    (smallest-first/acc ev (first ev) empty))

(define (smallest-first/acc ev min min-list)
    (cond
      [(empty? ev) min-list]
      [(symbol=? (compare-ev (first ev) min) 'gt) (smallest-first/acc (rest ev) (first ev)
                                               (append (list (first ev)) min-list))]
      [else (smallest-first/acc (rest ev) min (append min-list (list (first ev))))]))