;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname q02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (alphanumeric-only los) consumes a list of strings (los)
;;   and produces the same list of strings keeping only the
;;   alphanumeric strings
;; alphanumeric-only: (listof Str) -> (listof Str)
;; Examples:
(check-expect (alphanumeric-only '("5he%llo" "12!3hu")) '())
(check-expect (alphanumeric-only '("5hello" "123hu" "89huyt#"))
'("5hello" "123hu"))
(check-expect (alphanumeric-only '("hello" "?u" "123hu"))
'("hello" "123hu"))

(define (alphanumeric-only los)
    (local
      [(define (alphanumeric? char)
         (cond
           [(char-alphabetic? char) true]
           [(char-numeric? char) true]
           [else false]))
      (define (contain-an? string)
         (foldl (lambda (char boolean) (and boolean (alphanumeric? char)))
               true (string->list string)))]
      (filter contain-an? los)))

;; Tests:
(check-expect (alphanumeric-only '("5hello" "123hu")) '("5hello" "123hu"))
(check-expect (alphanumeric-only '("helloidk" "123idk" "89huyt#"))
'("helloidk" "123idk"))
(check-expect (alphanumeric-only '(""))
'(""))

;; (remove-outliers lon) consumes a non-empty list of numbers
;;   (lon), and produces a list of the same numbers in the
;;   same order, excluding the outliers
;; remove-outliers: (listof Num) -> (listof Num)
;; Examples:
(check-expect (remove-outliers '(1)) '(1))
(check-expect (remove-outliers '(0)) '(0))
(check-expect (remove-outliers '(9 8 -3 -9 -8 0 0 0 0 3))
'(-3 0 0 0 0 3))

(define (remove-outliers lon)
  (local
    [(define miu
       (/ (foldl + 0 lon) (length lon)))
     (define sigma
       (sqrt (/ (foldr + 0 (map (lambda (x) (sqr (- x miu))) lon)) (length lon))))
     (define (outlier? x)
       (cond
         [(< x (- miu sigma)) false]
         [(> x (+ miu sigma)) false]
         [else true]))]
    (filter outlier? lon)))

;; Tests:
(check-expect (remove-outliers '(1 2 3 4 5)) '(2 3 4))
(check-expect (remove-outliers '(-1 -2 3 0 0.5 100)) '(-1 -2 3 0 0.5))
(check-expect (remove-outliers '(-100 0 -10 3 2 1 4 1/2)) '( 0 -10 3 2 1 4 0.5))

;; (zero-fill string) consumes a string no longer than 20
;;   characters. It produces the same string but with zeros
;;   added to the end, as necessary, so that the string is
;;   exactly 20 characters long.
;; zero-fill: Str -> Str
;; Examples:
(check-expect (zero-fill "abcdefghijklmn") "abcdefghijklmn000000")
(check-expect (zero-fill "0000000000000000000") "00000000000000000000")
(check-expect (zero-fill "he00llo") "he00llo0000000000000")

(define (zero-fill string)
  (list->string (build-list 20 (lambda (x)
                   (cond
                     [(< x (length (string->list string)))
                      (list-ref (string->list string) x)]
                     [else #\0])))))

;; Tests:
(check-expect (zero-fill "") "00000000000000000000")
(check-expect (zero-fill "123410897124") "12341089712400000000")
(check-expect (zero-fill "@AAADF091jafalkja1!") "@AAADF091jafalkja1!0")

;; (remove-duplicates lon) consumes a list of numbers and
;;   produces a list containing only the first occurrence of
;;   each number, in the order they occur.
;; remove-duplicates: (listof Num) -> (listof Num)
;; Examples:
(check-expect
(remove-duplicates (list 1 2 3 4 3 2 4 1)) (list 1 2 3 4))
(check-expect
(remove-duplicates (list 1 1 2 2 3 3 4 3 2 4 1)) (list 1 2 3 4))
(define (remove-duplicates lon)
  (foldr (lambda (num x) (cons num (filter (lambda (y) (not (= num y))) x))) empty lon))

;; Tests:
(check-expect
(remove-duplicates empty) empty)
(check-expect
(remove-duplicates (list 1 2 3 4)) (list 1 2 3 4))
(check-expect
(remove-duplicates (list 0 0 0 0)) (list 0))