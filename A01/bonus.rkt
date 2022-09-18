;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define (re score)
    (abs (+ score -1)))

(define (below_or_above score)
    (re (min 1 (quotient score 50))))

(define (course_grade cp m1 m2 fe oa)
    (+ (* m1 0.07) (* m2 0.13) (* cp 0.05) (* fe 0.3) (* oa 0.45)))

(define (fail score)
  (- 100 (* 54 (below_or_above score))))

(define (final-cs135-grade cp m1 m2 fe oa)
    (min (course_grade cp m1 m2 fe oa) (fail fe) (fail oa)))