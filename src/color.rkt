#lang racket
(require 2htdp/image)

(provide (contract-out
          [hex->rgb (-> string? list?)]
          [hex->color (-> string? color?)]))

(define MIN_HEX_DIGIT 3)
(define MAX_HEX_DIGIT 6)
      
(define (pad-zero hexstr)
  (let ([diff (- 6 (string-length hexstr))])
    (if (< diff 0)
        hexstr
        (string-append hexstr (make-string diff #\0)))))
        

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


;; Remove the first '#' character from a string.
(define (remove-bang s)
  (let ([first-char (first (string->list s))])
        (if (char=? first-char #\#)
            (substring s 1)
            s)))


;; Converts a hex string to a color struct.
(define (hex->color hex)
  (apply make-color (hex->rgb)))


;; Converts a color hex value to a list of RGB integer list.
(define (hex->rgb hex)
  (let ([hex (remove-bang hex)])
    (if (or (< (string-length hex) MIN_HEX_DIGIT)
            (> (string-length hex) MAX_HEX_DIGIT))
        (raise-argument-error
         'hex->rgb
         "string with length between 3 to 6"
         hex)
        ;;(let ([cs (string->list (pad-zero hex))])
         (reverse (aux (string->list (pad-zero hex)) '())))))
