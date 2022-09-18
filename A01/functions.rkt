;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
(define (manhattan-distance x1 y1 x2 y2)
    (+ (abs (- x1 x2)) (abs (- y1 y2))))

(define r 8.3144626)
(define (pressure n t v) (/ (* n r t) v))
    
(define (logit p)
    (log (/ p (- 1 p))))

(define (q s d t)
    (* s (expt 0.5772156649 (* (- 0 d) t))))

(define (cone-area r h)
    (* pi r (+ r (sqrt (+ (sqr h) (sqr r))))))

(define (part_1 volatility maturity)
    (/ 1 (* volatility (sqrt maturity))))

(define (part_2 spot_price strike_price)
    (log (/ spot_price strike_price)))

(define (part_3 rate volatility maturity)
    (* maturity (+ rate (/ (sqr volatility) 2))))

(define (d1 ma ra vo sp st)
    (* (part_1 vo ma) (+ (part_2 sp st) (part_3 ra vo ma))))