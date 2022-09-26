;; (can-donate-to/cond?) produce a boolean value indicating whether the blood types are compatible
;; Examples:
(check-expect (can-donate-to/cond? 'o- 'o-) true)
(check-expect (can-donate-to/cond? 'a+ 'a-) true)
(check-expect (can-donate-to/cond? 'b- 'a-) false)

;; can-donate-to/cond?: SYM SYM -> BOOL
(define (can-donate-to/cond? symb1 symb2))

;; Test

;; (can-donate-to/bool?) produce a boolean value indicating whether the blood types are compatible
;; Examples:
(check-expect (can-donate-to/bool? 'o- 'o-) true)
(check-expect (can-donate-to/bool? 'a+ 'a-) true)
(check-expect (can-donate-to/bool? 'b- 'a-) false)

;; can-donate-to/bool?: SYM SYM -> BOOL
(define (can-donate-to/bool? symb1 symb2))

;; Test