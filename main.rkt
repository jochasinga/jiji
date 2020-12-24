#lang racket

(require 2htdp/image)
(require lang/posn)

(require "primitive.rkt")

(define center-blocks (map (lambda (f) (f))
                       (list one five nine sixteen)))
(define blocks (map (lambda (f) (f))
                    (list 
                     two three four six seven eight ten
                     eleven twelve thirteen fourteen fifteen)))
                    
(define (pick-el l) (list-ref l (random (length l))))

(define (block [n 0])
  (local [(define c (pick-el blocks))
          (define i (pick-el center-blocks))]
    (above (beside c c c)
           (beside c i c)
           (beside c c c))))

;(define (block n)
;  (cond
;    [(zero? n) (square 1 "solid" "red")]
;    [else
;     (local [(define c (block (- n 1)))
;             (define i (square (image-width c) "solid" "white"))]
;       (above (beside c c c)
;              (beside c i c)
;              (beside c c c)))]))

