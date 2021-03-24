#lang racket

(provide hex->rgb)

(define MIN_HEX_DIGIT 2)
(define MAX_HEX_DIGIT 6)

;; Auxiliary function that takes care
;; of the nitty-gritty of parsing the string.
(define (aux cs acc)
  (if (null? cs)
      acc
      (let ([acc_ (cons (string->number
                         (list->string
                          (cons #\#
                                (cons #\x
                                      (list (car cs)
                                            (car (cdr cs)))))))
                        acc)])
        (aux (cdr (cdr cs)) acc_))))

;; Converts a color hex value to a list
;; of RGB integer list.
(define (hex->rgb hex)
  (if (or (< (string-length hex) MIN_HEX_DIGIT)
          (> (string-length hex) MAX_HEX_DIGIT))
      (raise-argument-error
       'hex->rgb
       "string with length between 2 to 6"
       hex)
      (let ([cs (string->list hex)])
        (reverse (aux (string->list hex) '())))))
