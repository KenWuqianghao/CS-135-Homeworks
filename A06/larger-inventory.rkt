;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname large-inventory) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define larger-inventory (list (make-ev "Nissan Leaf"     2013  5000 230000  98)
                               (make-ev "Tesla M3"        2022 60000      5 133)
                               (make-ev "BMW i4"          2022 53000     25  75)
                               (make-ev "Chevy Bolt"      2020 35000   3050 123)
                               (make-ev "Audi e-Tron"     2021 40000   4000  63)
                               (make-ev "Hyundai Kona"    2022 36000  12000 132)
                               (make-ev "Ford Mustang"    2023 57000      0  98)
                               (make-ev "Hyundai Ioniq"   2022 48000   1200 110)
                               (make-ev "Lucid Air Dream" 2022 148500    65 111)
                               (make-ev "Polestar 2"      2020 115000 89000  52)
                               (make-ev "Hyundai Kona"    2022 36000  12005 132)))


(define models-larger-inventory (list "Nissan Leaf" "Tesla M3" "BMW i4"
                     "Chevy Bolt" "Audi e-Tron" "Hyundai Kona"
                     "Ford Mustang" "Hyundai Ioniq" "Lucid Air Dream"
                     "Polestar 2" "hyundai Kona"))

(define years-larger-inventory (list 2013 2022 2022 2020
                                     2021 2022 2023 2022
                                     2022 2020 2022))


(define prices-larger-inventory (list 5000 60000 53000
                                      35000 40000 36000
                                      57000 48000 148500
                                      115000 36000))

(define mileage-larger-inventory (list 230000 5 25
                                       3050 4000 12000
                                       0 1200 65 89000 12005))

(define mpge-larger-inventory (list 98 133 75
                                    123 63 132
                                    98 110 111 52 132))