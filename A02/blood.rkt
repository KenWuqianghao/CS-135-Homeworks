;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname blood) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (can-donate-to/cond?) produce a boolean value indicating whether the blood types are compatible
;; Examples:
(check-expect (can-donate-to/cond? 'O- 'O-) true)
(check-expect (can-donate-to/cond? 'A+ 'A-) false)
(check-expect (can-donate-to/cond? 'B- 'A-) false)

;; can-donate-to/cond?: SYM SYM -> BOOL
(define (can-donate-to/cond? donor recipient)
    (cond 
        [(symbol=? recipient donor) true]
        [(symbol=? donor 'O-) true]
        [(symbol=? recipient 'AB+) true]
        [(symbol=? recipient 'A+) (cond
                                    [(symbol=? donor 'O+) true]
                                    [(symbol=? donor 'A-) true]
                                    [else false])]
        [(symbol=? recipient 'B+) (cond
                                    [(symbol=? donor 'O+) true]
                                    [(symbol=? donor 'B-) true]
                                    [else false])]
        [(symbol=? recipient 'AB-) (cond
                                    [(symbol=? donor 'O+) true]
                                    [(symbol=? donor 'B-) true]
                                    [(symbol=? donor 'A-) true]
                                    [else false])]
        [else false]) )                                            

;; Test
(check-expect (can-donate-to/cond? 'O+ 'A+) true)
(check-expect (can-donate-to/cond? 'O+ 'B+) true)
(check-expect (can-donate-to/cond? 'O+ 'B-) false)
(check-expect (can-donate-to/cond? 'O- 'O-) true)
(check-expect (can-donate-to/cond? 'O- 'O+) true)
(check-expect (can-donate-to/cond? 'AB- 'AB+) true)
(check-expect (can-donate-to/cond? 'AB- 'B-) false)
(check-expect (can-donate-to/cond? 'A- 'A+) true)
(check-expect (can-donate-to/cond? 'A- 'AB-) true)
(check-expect (can-donate-to/cond? 'A- 'O-) false)
(check-expect (can-donate-to/cond? 'B- 'B+) true)
(check-expect (can-donate-to/cond? 'B- 'AB-) true)
(check-expect (can-donate-to/cond? 'B- 'O-) false)


;; (can-donate-to/bool?) produce a boolean value indicating whether the blood types are compatible
;; Examples:
(check-expect (can-donate-to/bool? 'O- 'O-) true)
(check-expect (can-donate-to/bool? 'A+ 'A-) false)
(check-expect (can-donate-to/bool? 'B- 'A-) false)

;; can-donate-to/bool?: SYM SYM -> BOOL
(define (can-donate-to/bool? donor recipient)
    (or (symbol=? recipient donor)
        (symbol=? donor 'O-)
        (symbol=? recipient 'AB+)
        (and (symbol=? recipient 'A+) (or (symbol=? donor 'O+) (symbol=? donor 'A-)))
        (and (symbol=? recipient 'B+) (or (symbol=? donor 'O+) (symbol=? donor 'B-)))
        (and (symbol=? recipient 'AB-) (or (symbol=? donor 'A-) (symbol=? donor 'B-)))))
;; Test
(check-expect (can-donate-to/cond? 'O+ 'A+) true)
(check-expect (can-donate-to/cond? 'O+ 'B+) true)
(check-expect (can-donate-to/cond? 'O+ 'B-) false)
(check-expect (can-donate-to/cond? 'O- 'O-) true)
(check-expect (can-donate-to/cond? 'O- 'O+) true)
(check-expect (can-donate-to/cond? 'AB- 'AB+) true)
(check-expect (can-donate-to/cond? 'AB- 'B-) false)
(check-expect (can-donate-to/cond? 'A- 'A+) true)
(check-expect (can-donate-to/cond? 'A- 'AB-) true)
(check-expect (can-donate-to/cond? 'A- 'O-) false)
(check-expect (can-donate-to/cond? 'B- 'B+) true)
(check-expect (can-donate-to/cond? 'B- 'AB-) true)
(check-expect (can-donate-to/cond? 'B- 'O-) false)