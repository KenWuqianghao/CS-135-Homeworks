;; (can-donate-to/cond?) produce the predicted box office profits (as an Int) in millions
;; Examples:
(check-expect (box-office-profits "Thor: Love and Thunder" "Marvel" 4 50 ) 980).

;; box-office-profits: STR STR INT INT -> INT
(define (box-office-profits movie studio actor-num explosion-num))

;; Test