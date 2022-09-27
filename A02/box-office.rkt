;; (can-donate-to/cond?) produce the predicted box office profits (as an Int) in millions
;; Examples:
(check-expect (box-office-profits "Thor: Love and Thunder" "Marvel" 4 50 ) 980)

;; box-office-profits: STR STR INT INT -> INT
(define (box-office-profits movie studio actor_num explosion_num)
    (+ (movie_bonus movie) (studio_bonus studio) (actor_bonus actor_num) (explosion_bonus explosion_num)))

(define (movie_bonus movie)
    (cond 
        [(and (< (string-length movie) 10) (starts_with_the movie)) -25]
        [(and (< (string-length movie) 10) (not (starts_with_the movie))) 25]
        [(and (> (string-length movie) 10) (starts_with_the movie)) -50]
        [else 0]))

(define (starts_with_the movie)
    (cond 
        [(string=? (substring movie 0 4) "The") true]
        [else false]))

(define (studio_bonus studio)
    (cond 
        [(string=? studio "Marvel") 500]
        [(string=? studio "DC") -250]
        [else 0]))

(define (actor_bonus actor_num)
    (* actor_num 50))

(define (explosion_bonus explosion_num)
    (- (* explosion_num 6) 20))

;; Test
(check-expect (box-office-profits "The Suicide Squad" "DC" 4 100 ) 530)
(check-expect (box-office-profits "Eternals" "Marvel" 10 30 ) 1185)
(check-expect (box-office-profits "Groundhog Day" "Columbia Pictures" 2 0 ) 80)