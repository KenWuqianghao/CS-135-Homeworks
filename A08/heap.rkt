;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname heap) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; make sure heap-support.rkt is in the same folder as this file (heap.rkt)
(require "heap-support.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Do NOT uncomment the following (define-struct hnode ...) because it is
;; defined for you in the (require "heap-support.rkt") above
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-struct hnode (key left right))
;;
;; A (heapof X) is one of:
;; * empty
;; * (make-hnode X (heapof X) (heapof X))
;; requires: all elements in left are >= key
;;           all elements in right are >= key
;;
;; The following function is available for your use:
;; 
;; (heap-print heap key->string) pretty prints the provided (heapof X)
;;   using the key->string function to convert type X to a string
;; NOTE: displays the heap rotated counter-clockwise of an angle of 90 degrees
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define example-heap (make-hnode 1
                                 (make-hnode 15
                                             (make-hnode 60
                                                         (make-hnode 70 '() '())
                                                         '())
                                             (make-hnode 20
                                                         (make-hnode 40 '() '())
                                                         '()))
                                 (make-hnode 5
                                             (make-hnode 10
                                                         (make-hnode 50 '() '())
                                                         '())
                                             (make-hnode 30 '() '()))))
(define string-heap (make-hnode "a"
                                 (make-hnode "d"
                                             (make-hnode "i"
                                                         (make-hnode "j" '() '())
                                                         '())
                                             (make-hnode "e"
                                                         (make-hnode "g" '() '())
                                                         '()))
                                 (make-hnode "b"
                                             (make-hnode "c"
                                                         (make-hnode "h" '() '())
                                                         '())
                                             (make-hnode "f" '() '()))))
;; uncomment this line to "print" the example heap in the interactions window
;; this function may help you to debug your code
;; NOTE: do NOT leave in any (heap-print ...) calls in your code when submitting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (heap-add X heap comparison) adds an element of type X to a heap
;;   (heapof X), producing a new heap
;; heap-add: X (heapof X) -> (heapof X)
;; Examples:
(check-expect (heap-add 6 empty <=) (make-hnode 6 '() '()))
(check-expect (heap-add 3 example-heap <=) (make-hnode 1
                                 (make-hnode 3
                                             (make-hnode 5
                                                         (make-hnode 30 '() '())
                                                         '())
                                             (make-hnode 10
                                                         (make-hnode 50 '() '())
                                                         '()))
                                 (make-hnode 15
                                             (make-hnode 60
                                                         (make-hnode 70 '() '())
                                                         '())
                                             (make-hnode 20
                                                         (make-hnode 40 '() '())
                                                         '()))))

(define (heap-add X heap comparison)
    (cond
      [(empty? heap) (make-hnode X empty empty)]
      [(comparison (hnode-key heap) X) (make-hnode (hnode-key heap)
                                                   (heap-add X (hnode-right heap) comparison)
                                                   (hnode-left heap))]
      [else (make-hnode X (heap-add (hnode-key heap) (hnode-right heap) comparison)
                                                   (hnode-left heap))]))

;; Tests:
(check-expect (heap-add 0 empty <=) (make-hnode 0 '() '()))
(check-expect (heap-add 10 example-heap <=) (make-hnode
 1
 (make-hnode
  5
  (make-hnode
   10
   (make-hnode 30 '() '())
   '())
  (make-hnode
   10
   (make-hnode 50 '() '())
   '()))
 (make-hnode
  15
  (make-hnode
   60
   (make-hnode 70 '() '())
   '())
  (make-hnode
   20
   (make-hnode 40 '() '())
   '()))))

(check-expect (heap-add "z" string-heap string<=?) (make-hnode
 "a"
 (make-hnode
  "b"
  (make-hnode
   "f"
   (make-hnode "z" '() '())
   '())
  (make-hnode
   "c"
   (make-hnode "h" '() '())
   '()))
 (make-hnode
  "d"
  (make-hnode
   "i"
   (make-hnode "j" '() '())
   '())
  (make-hnode
   "e"
   (make-hnode "g" '() '())
   '()))))

;; (heap-remove-min heap comparison) removes the smallest element from
;;   the heap (the root) and produces a new heap
;; heap-remove-min: (heapof X) -> (heapof X)
;; Examples:
(check-expect (heap-remove-min empty <=) empty)
(check-expect (heap-remove-min example-heap <=) (make-hnode 5
                                 (make-hnode 15
                                             (make-hnode 60
                                                         (make-hnode 70 '() '())
                                                         '())
                                             (make-hnode 20
                                                         (make-hnode 40 '() '())
                                                         '()))
                                 (make-hnode 10
                                             (make-hnode 50
                                                         '() '())
                                             (make-hnode 30 '() '()))))

(define (heap-remove-min hp compare?)
  (cond
    [(or (empty? hp) (and (empty? (hnode-left hp)) (empty? (hnode-right hp))))
     empty]
    [(empty? (hnode-left hp)) (hnode-right hp)]
    [(empty? (hnode-right hp)) (hnode-left hp)]
    [(compare? (hnode-key (hnode-left hp)) (hnode-key (hnode-right hp)))
     (make-hnode (hnode-key (hnode-left hp))
                 (heap-remove-min (hnode-left hp) compare?)
                 (hnode-right hp))]
    [else
     (make-hnode (hnode-key (hnode-right hp))
                 (hnode-left hp)
                 (heap-remove-min (hnode-right hp) compare?))]))
;; Tests:
(check-expect (heap-remove-min empty <=) empty)
(check-expect (heap-remove-min string-heap string<=?) (make-hnode
 "b"
 (make-hnode
  "d"
  (make-hnode
   "i"
   (make-hnode "j" '() '())
   '())
  (make-hnode
   "e"
   (make-hnode "g" '() '())
   '()))
 (make-hnode
  "c"
  (make-hnode "h" '() '())
  (make-hnode "f" '() '()))))

;; (list->heap lox comparison) generates a heap by recursively
;;   calling heap-add from a lox and a comparison function
;; list->heap: (listof X) X<=? -> (heapof X)
;; Examples:
(check-expect (list->heap '(70 1 15 5 60 50 40 30 20 10) <=) example-heap)
(check-expect (list->heap '(1 2 3) <=) (make-hnode 1
                                                   (make-hnode 2 '() '())
                                                   (make-hnode 3 '() '())))

(define (list->heap lox comparison)
  (cond
    [(empty? lox) empty]
    [else (heap-add (first lox) (list->heap (rest lox) comparison) comparison)]))

;; Tests:
(check-expect (list->heap empty <=) empty)
(check-expect (list->heap '("a" "b" "c") string<=?) (make-hnode
 "a"
 (make-hnode "b" '() '())
 (make-hnode "c" '() '())))
(check-expect (list->heap '(-1 0 5) <=) (make-hnode -1
                                                   (make-hnode 0 '() '())
                                                   (make-hnode 5 '() '())))

;; (heap->list  heap comparison) generates a sorted list of
;;   all of the elements in a heap by recursively calling
;;   heap-remove-min
;; heap->list : (heapof X) X<=? -> 
;; Examples:
(check-expect (heap->list example-heap <=) '(1 5 10 15 20 30 40 50 60 70))
(check-expect (heap->list (make-hnode 0
                                                   (make-hnode 1 '() '())
                                                   (make-hnode 1 '() '())) <=) (list 0 1 1))
                          
(define (heap->list  heap comparison)
  (cond
    [(empty? heap) empty]
    [else (cons (hnode-key heap) (heap->list (heap-remove-min heap comparison) comparison))]))

;; Tests:
(check-expect (heap->list string-heap string<=?) (list
 "a"
 "b"
 "c"
 "d"
 "e"
 "f"
 "g"
 "h"
 "i"
 "j"))
(check-expect (heap->list (make-hnode 1
                                                   (make-hnode 2 '() '())
                                                   (make-hnode 3 '() '())) <=) (list 1 2 3))
                          
;; (heap-sort lox comparison) sorts a lox (listof X) with a
;;   comparison function by combining heap-add,
;;   heap-remove-min, list->heap and heap->list in ascending
;;   order.
;; heap-sort: (listof X) X<=? -> (listof X)
;; Examples:
(check-expect (heap-sort '(70 1 15 5 60 50 40 30 20 10) <=)
              '(1 5 10 15 20 30 40 50 60 70))
(check-expect (heap-sort '(1 2 3) <=)
              '(1 2 3))

(define (heap-sort lox comparison)
  (heap->list (list->heap lox comparison) comparison))

;; Tests:
(check-expect (heap-sort (list
 "a"
 "b"
 "c"
 "d"
 "e"
 "f"
 "g"
 "h"
 "i"
 "j") string<=?)
              (list
 "a"
 "b"
 "c"
 "d"
 "e"
 "f"
 "g"
 "h"
 "i"
 "j"))
(check-expect (heap-sort '(1 2 3) <=)
              '(1 2 3))