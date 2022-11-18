;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ancestor-trees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct anode (name father mother))
;; An ANode is a (make-anode Str AT AT)

;; An ancestor tree (AT) is one of:
;; * empty
;; * ANode
;;
;; Requires: each name (Str) is unique

;; anode-template: ANode -> Any
(define (anode-template anode)
    (cond
        [(empty? anode) ...]
        [(anode? anode) (... (anode-name at)
                             (anode-template (anode-left-node at))
                             (anode-template (anode-right-node at)))]))

;; at-template: AT -> Any
(define (at-template at)
    (cond
        [(empty? at) ...]
        [(anode? at) (... (anode-name at)
                            (at-template (anode-father at)
                            (at-template (anode-mother at))))]))

(define sample_at (make-anode "A" (make-anode "B" empty empty) (make-anode "C" empty empty)))

;; (find-subtree at name) consumes an AT and a name and produces the subtree of AT that is rooted at 
;; the node labelled name
;; Examples
(check-expect (find-subtree sample_at "A") sample_at)
(check-expect (find-subtree sample_at "Z") empty)

;; find-subtree: AT Str -> AT
(define (find-subtree at name)
  (cond
    [(empty? at) empty]
    [(string=? name (anode-name at)) at]
    [(anode? (find-subtree (anode-father at) name)) (find-subtree (anode-father at) name)]
    [(anode? (find-subtree (anode-mother at) name)) (find-subtree (anode-mother at) name)]
    [else empty]))
  
;; Tests
(check-expect (find-subtree sample_at "A") sample_at)
(check-expect (find-subtree sample_at "B") (make-anode "B" empty empty))
(check-expect (find-subtree empty "SEARCH EMPTY TREE") empty)
(check-expect (find-subtree sample_at "SEARCH NON EXISTING NODE") empty)
  
;; (get-f-generation at num) consumes an AT and a NAT and produces produces the list of family members 
;; that have depth equal to the provided number, from left to right
;; Examples
(check-expect (get-f-generation sample_at 0) (list "A"))
(check-expect (get-f-generation sample_at 1) (list "B" "C"))

;; get-f-generation: AT Nat -> (listof Str)
(define (get-f-generation at num)
    (cond
      [(empty? at) empty]
      [(= num 0) (list(anode-name at))]
      [else (append (get-f-generation (anode-father at) (sub1 num))
                    (get-f-generation (anode-mother at) (sub1 num)))]))

;; Tests
(check-expect (get-f-generation empty 0) empty)
(check-expect (get-f-generation sample_at 3) empty)
(check-expect (get-f-generation (make-anode "A" (make-anode "B" (make-anode "C" empty empty)
(make-anode "D" empty empty)) (make-anode "E" empty empty)) 2) (list "C" "D"))

;; (get-f-descendants-path at name) consumes an AT and a name and produces a list of the familial 
;; descendants of name, starting with name and ending at the root node
;; Examples
(check-expect (get-f-descendants-path sample_at "A") (list "A"))
(check-expect (get-f-descendants-path sample_at "B") (list "B" "A"))

;; get-f-descendants-path: AT Str -> (listof Str)
(define (get-f-descendants-path at name)
    (cond
      [(empty? at) empty]
      [(not (empty? (get-f-descendants-path (anode-father at) name)))
       (append (get-f-descendants-path (anode-father at) name) (list (anode-name at)))]
      [(not (empty? (get-f-descendants-path (anode-mother at) name)))
       (append (get-f-descendants-path (anode-mother at) name) (list (anode-name at)))]
      [(string=? name (anode-name at)) (list (anode-name at))]
      [else empty]))

;; Tests
(check-expect (get-f-descendants-path empty "Empty Tre") empty)
(check-expect (get-f-descendants-path sample_at "Non Existing Name") empty)
(check-expect (get-f-descendants-path (make-anode "A" (make-anode "B" (make-anode "C" empty empty)
(make-anode "D" empty empty)) (make-anode "E" empty empty)) "C") (list "C" "B" "A"))