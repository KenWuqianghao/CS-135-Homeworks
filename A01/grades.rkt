;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define (final-cs135-grade cp m1 m2 fe oa)
    (+ (* m1 0.07) (* m2 0.13) (* cp 0.05) (* fe 0.3) (* oa 0.45)))

(define (cs135-final-exam-grade-needed cp m1 m2 oa)
    (/ (- 60 (* m1 0.07) (* m2 0.13) (* cp 0.05) (* oa 0.45)) 0.3))