;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname cs135search) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define sample_an_il (list (list "barks" (list "b.txt"))
(list "cat" (list "a.txt" "c.txt"))
(list "chases" (list "c.txt"))
(list "dog" (list "b.txt" "c.txt"))
(list "sleeps" (list "a.txt"))
(list "suddenly" (list "c.txt"))
(list "the" (list "a.txt" "b.txt" "c.txt"))))

(define (in_list? string dl)
    (cond
        [(empty? dl) false]
        [(string=? string (first dl)) true]
        [(string<? string (first dl)) false]
        [else (in_list? string (rest dl))]))

;; (both) produces a doc-list (DL) that occur in both DLs
;; Examples
(check-expect (both (list "b.txt") (list "b.txt" "c.txt")) (list "b.txt"))
(check-expect (both (list "a.txt") (list "a.txt" "c.txt")) (list "a.txt"))

;; both: DL Dl -> DL
(define (both dl_1 dl_2)
    (cond
        [(empty? dl_1) empty]
        [(in_list? (first dl_1) dl_2) (cons (first dl_1) (both (rest dl_1) dl_2))]
        [else (both (rest dl_1) dl_2)]))

;;Tests
(check-expect (both (list "d.txt") (list "d.txt" "c.txt")) (list "d.txt"))
(check-expect (both (list "e.txt") (list "e.txt" "c.txt")) (list "e.txt"))

;; (exclude) produces a doc-list (DL) that occur in the first DL but not the second
;; Examples
(check-expect (exclude (list "b.txt" "c.txt") (list "b.txt")) (list "c.txt"))
(check-expect (exclude (list "a.txt" "b.txt") (list "a.txt")) (list "b.txt"))

;; exclude: DL Dl -> DL
(define (exclude dl_1 dl_2)
    (cond
        [(empty? dl_1) empty]
        [(not (in_list? (first dl_1) dl_2))
        (cons (first dl_1) (exclude (rest dl_1) dl_2))]
        [else (exclude (rest dl_1) dl_2)]))

;; Tests
(check-expect (exclude (list "c.txt" "d.txt") (list "c.txt")) (list "d.txt"))
(check-expect (exclude (list "e.txt" "f.txt") (list "e.txt")) (list "f.txt"))

;; (keys-retrieve) produces a (listof Str) with lexicographic ordering
;; Examples
(check-expect (keys-retrieve "b.txt" sample_an_il) (list "barks" "dog" "the"))
(check-expect (keys-retrieve "a.txt" sample_an_il) (list "cat" "sleeps" "the"))

;; keys-retrieve: STR IL -> listof Str
(define (keys-retrieve doc an-il)
  (cond
    [(empty? an-il) empty]
    [(in_list? doc (second (first an-il)))
     (cons (first (first an-il)) (keys-retrieve doc (rest an-il)))]
    [else (keys-retrieve doc (rest an-il))]))

;; Tests
(check-expect (keys-retrieve "c.txt" sample_an_il) (list "cat" "chases" "dog" "suddenly" "the"))
(check-expect (keys-retrieve "d.txt" sample_an_il) empty)

(define (words_search str_1 str_2 an-il)
  (cond
    [(empty? an-il) empty]
    [(or (string=? str_2 (first (first an-il)))
    (string=? str_1 (first (first an-il))))
     (cons (second (first an-il)) (words_search str_1 str_2 (rest an-il)))]
    [else (words_search str_1 str_2 (rest an-il))]))

;; (search)  produces a doc-list (DL) depending on the option term
;; Examples
(check-expect (search 'both "barks" "dog" sample_an_il) (list "b.txt"))
(check-expect (search 'exclude "barks" "dog" sample_an_il) empty)

;; search: SYM STR STR IL -> DL
(define (search action str_1 str_2 an-il)
  (cond
    [(symbol=? action 'both)
     (both (first (words_search str_1 str_2 an-il))
     (second (words_search str_1 str_2 an-il)))]
    [else (exclude (first (words_search str_1 str_2 an-il))
    (second (words_search str_1 str_2 an-il)))]))

;; Tests
(check-expect (search 'both "cat" "dog" sample_an_il) (list "c.txt"))
(check-expect (search 'exclude "cat" "dog" sample_an_il) (list "a.txt"))