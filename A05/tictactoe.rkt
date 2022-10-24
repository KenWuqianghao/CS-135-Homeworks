;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tictactoe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define grid1
(list (list '_ '_ '_)
(list '_ '_ '_)
(list '_ '_ '_)))

(define grid2
(list (list 'X 'O 'O 'O
'_)
(list 'X 'X 'O '_
'_)
(list '_ '_ '_ '_
'_)
(list '_ '_ '_ '_
'_)
(list '_ '_ '_ '_
'X)))

(define grid3 (list (list 'X)))

(define grid4 (list (list 'X 'X '_)
(list 'O 'X 'O)
(list 'O '_ '_)))

(define (count-row t3row)
  (cond
    [(empty? t3row) 0]
    [(symbol=? (first t3row) 'X) (+ 1 (count-row (rest t3row)))]
    [(symbol=? (first t3row) 'O) (+ -1 (count-row (rest t3row)))]
    [else (count-row (rest t3row))]))

(define (count-moves t3grid)
  (cond
    [(empty? t3grid) 0]
    [else (+ (count-row (first t3grid)) (count-moves (rest t3grid)))]))

;; (whose-turn) determines whose turn it is by producing a symbol value
;; Examples
(check-expect (whose-turn grid1) 'X)
(check-expect (whose-turn grid2) 'X)

;; who-turn: T3Grid -> SYM
(define (whose-turn t3grid)
  (cond
    [(= 0 (count-moves t3grid)) 'X]
    [else 'O]))

;; Tests
(check-expect (whose-turn grid3) 'O)
(check-expect (whose-turn grid4) 'X)

;; (grid-ref) t consumes a T3Grid and a row and column number, and
;; produces the symbol located at that location
;; Examples
(check-expect (grid-ref grid1 0 0) '_)
(check-expect (grid-ref grid2 0 0) 'X)

;; grid-ref: T3Grid NAT NAT -> SYM
(define (grid-ref t3grid row_num col_num)
  (list-ref (list-ref t3grid row_num) col_num))

;; Tests
(check-expect (grid-ref grid1 0 0) '_)
(check-expect (grid-ref grid2 0 0) 'X)

;; (get-column)
;; Examples
(check-expect (get-column grid1 0) (list '_ '_ '_))
(check-expect (get-column grid2 1) (list 'O 'X '_ '_ '_))

;; get-column: T3Grid NAT -> LST
(define (get-column t3grid col_num)
  (cond
    [(empty? t3grid) empty]
    [else (cons (list-ref (first t3grid) col_num)
                (get-column (rest t3grid) col_num))]))

;; Tests
(check-expect (get-column grid3 0) (list 'X))
(check-expect (get-column grid4 0) (list 'X 'O 'O))

(define (col-win? col row_num player)
  (cond
    [(empty? col) 0]
    [(symbol=? player (first col)) (+ 1 (col-win? (rest col) row_num player))]
    [else (col-win? (rest col) row_num player)]))

(define (row-win? row col_num player)
  (cond
    [(empty? row) 0]
    [(symbol=? player (first row)) (+ 1 (row-win? (rest row) col_num player))]
    [else (row-win? (rest row) col_num player)]))

;; (will-win?) produces true if that player would win 
;; by placing a marker at the given location, and false otherwise
;; Examples
(check-expect (will-win? grid2 2 2 'X) false)
(check-expect (will-win? grid3 0 0 'X) false)

;; will-win?: T3Grid NAT NAT BOOL -> BOOL
(define (will-win? t3grid row_num col_num player)
  (cond
    [(or (symbol=? 'X (grid-ref t3grid row_num col_num))
         (symbol=? 'O (grid-ref t3grid row_num col_num))) false]
    [(= (- (length t3grid) 1)
        (col-win? (get-column t3grid col_num) row_num player)) true]
    [(= (- (length (first t3grid)) 1)
        (row-win? (list-ref t3grid row_num) col_num player)) true]
    [else false]))

;; Tests
(check-expect (will-win? grid1 0 0 'X) false)
(check-expect (will-win? (list (list 'X 'X '_)
(list 'O 'X 'O)
(list 'O '_ '_))
0 2 'X) true)