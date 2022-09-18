;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname conversion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define (mph->m/s s) (* 1609.344 (/ s 3600 )))

(define (psi->pa p) (/ (* p 4.4482 144) (sqr 0.3048)))

(define (lbf-ft->Nm pf) (* 0.3048 4.4482 pf))