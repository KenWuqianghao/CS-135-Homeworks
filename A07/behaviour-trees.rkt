;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname behaviour-trees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define-struct cnode (type id children))
;; a CNode (composite node) is a (make-cnode Sym Nat (ne-listof BT))
;; Requires:
;; type is (anyof 'Sequence 'Selector)
;; id is unique in BT
;; A BT (Behaviour Tree) is one of:
;; * Str ;; a leaf node (an action)
;; * CNode

(define npc1-through-window
(make-cnode 'Sequence 1 (list "Walk to Window"
"Open Window"
"Climb through Window"
"Turn Around"
"Close Window")))

(define npc2-aggressive-window-entry 
        (make-cnode 'Sequence 1 (list "Walk to Window"
                                      (make-cnode 'Selector 2 (list "Open Window"
                                                                    (make-cnode 'Sequence 3 (list "Pick Window Lock"
                                                                                                  "Open Window"))
                                                                    "Smash Window"))
                                      "Climb through Window"
                                      "Turn Around"
                                      (make-cnode 'Selector 4 (list "Close Window"
                                                                    "Run Away")))))

;; (action-exists?) consumes a BT and a Str for an action, in that order, 
;; and produces a true if the action exists in the BT and false otherwise
;; Examples
(check-expect (action-exists? npc1-through-window "Open Door") false)
(check-expect (action-exists? npc1-through-window "Open Window") true)
(check-expect (action-exists? npc1-through-window "Open") false)

;; actions-exist?: BT Str -> Bool
(define (action-exists? bt action)
  (cond
    [(empty? bt) false]
    [(string? bt) (cond
                    [(string=? action bt) true]
                    [else false])]
    [(list? bt) (cond
                  [(action-exists? (first bt) action) true]
                  [else (action-exists? (rest bt) action)])]
    [(cnode? bt) (action-exists? (cnode-children bt) action)]))

;; Tests
(check-expect (action-exists? npc1-through-window "Open Door") false)
(check-expect (action-exists? npc2-aggressive-window-entry "Smash Window") true)
(check-expect (action-exists? npc2-aggressive-window-entry "DOESNT EXIST") false)
(check-expect (action-exists? "RANDOM STRING" "Open Door") false)

;; (summarize-bt) consumes a BT and produces a summarized string of the series 
;; of actions in the BT
;; Examples
(check-expect (summarize-bt npc1-through-window)
"(Walk to Window and Open Window and Climb through Window and \
Turn Around and Close Window)")
(check-expect (summarize-bt (make-cnode 'Sequence 1 (list "Walk to Window"
"Open Window"))) "(Walk to Window and Open Window)")

;; summarize-bt: BT -> Str
(define (summarize-bt bt)
    (cond
      [string? bt]
      [(cnode? bt) (string-append "(" (sequence/select bt) ")")]))

;; Tests

(define (sequence/select bt)
  (cond
    [(symbol=? (cnode-type bt) 'Sequence) (sequence-to-string (cnode-children bt))]
    [(symbol=? (cnode-type bt) 'Selector) (selector-to-string (cnode-children bt))]))

(define (sequence-to-string loa)
  (cond
    [(empty? (rest lst)) (summarize-bt (first lst))]
    [else (string-append (summarize-bt ())]
    []))

(define (selector-to-string bt))

;; (add-action) consumes a CNode, ID, BT action, and Nat and produces a CNode 
;; that has the action inserted as a leaf node in the nth position in the immediate 
;; children of a-cnode, with cnode-id = id
;; Examples
(check-expect
(add-action npc1-through-window 1 "Look through Window" 2)
(make-cnode 'Sequence 1 (list "Walk to Window"
"Look through Window"
"Open Window"
"Climb through Window"
"Turn Around"
"Close Window")))
(check-expect
(add-action npc1-through-window 1 "Look" 2)
(make-cnode 'Sequence 1 (list "Walk to Window"
"Look"
"Open Window"
"Climb through Window"
"Turn Around"
"Close Window")))

;; add-action: CNode Nat BT Nat -> CNode
(define (add-action cnode id action num)
    (...))

;; Tests

;; (rewind) consumes a BT and lists the actions of all the leaf nodes in the BT in reverse order
;; Examples
(check-expect (rewind (make-cnode 'Sequence 1 (list "Walk to Window"
"Open Window"))) (list "Open Window" "Walk to Window"))

;; rewind: BT -> (listof Str)
(define (rewind bt)
    (...))

;; Tests
