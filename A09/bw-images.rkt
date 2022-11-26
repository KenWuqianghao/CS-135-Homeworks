;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname bw-images) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define image-L '((1 0 0 0)
(1 0 0 0)
(1 0 0 0)
(1 1 1 1)))

(define image-L-reflect-x '((1 1 1 1)
(1 0 0 0)
(1 0 0 0)
(1 0 0 0)))

(define image-L-reflect-y '((0 0 0 1)
(0 0 0 1)
(0 0 0 1)
(1 1 1 1)))

(define image-L-inverted '((0 1 1 1)
(0 1 1 1)
(0 1 1 1)
(0 0 0 0)))

(define simple-image '((1 1)
                (1 1)))
  
;; (invert image) consumes a 2D-Image image, and produces a
;;   2D-Image that is the inverted, such that, the black
;;   pixels are white and the white pixels are black
;; invert: 2D-Image -> 2D-Image
;; Examples:
(check-expect (invert image-L) image-L-inverted)
(check-expect (invert simple-image)
              '((0 0)
                (0 0)))

(define (invert image)
  (...))

;; Tests:

;; (reflect-x-axis image) consumes a 2D-Image and produces a
;;   2D-Image that represents the reflection of the 2D-Image
;;   across the x-axis
;; reflect-x-axis: 2D-Image -> 2D-Image
;; Examples:
(check-expect (reflect-x-axis image-L) image-L-reflect-x)
(check-expect (reflect-x-axis simple-image) simple-image)

(define (reflect-x-axis image)
  (...))

;; Tests:

;; (reflect-y-axis image) consumes a 2D-Image and produces a
;;   2D-Image that represents the reflection of the 2D-Image
;;   across the y-axis
;; reflect-y-axis: 2D-Image -> 2D-Image
;; Examples:
(check-expect (reflect-y-axis image-L) image-L-reflect-y)
(check-expect (reflect-y-axis simple-image) simple-image)

(define (reflect-y-axis image)
  (...))

;; Tests:

;; (transpose image) consumes a 2D-Image and produces a
;;   2D-Image that represents the transposed image
;; transpose: 2D-Image -> 2D-Image
;; Examples:
(check-expect (transpose image-L)
'((1 1 1 1)
(0 0 0 1)
(0 0 0 1)
(0 0 0 1)))
(check-expect (transpose '((1 0 0 1 1)))
'((1) (0) (0) (1) (1)))
(check-expect (transpose simple-image) simple-image)

(define (transpose image)
  (...))

;; Tests: