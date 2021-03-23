#lang racket

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
  (let ([cs (string->list hex)])
    (reverse (aux (string->list hex) '()))))
