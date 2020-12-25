#lang racket

(require 2htdp/image)
(require lang/posn)

(require "primitive.rkt")

(define angles '(0 90 180 270))
(define blank (sixteen))
(define center-blocks (map (lambda (f) (f))
                       (list one five nine sixteen)))
(define blocks (list 
                two three four five six seven eight nine ten
                eleven twelve thirteen fourteen fifteen sixteen))
                    
(define (pick-el l) (list-ref l (random (length l))))

(define (block [n 0])
  (local [(define c (pick-el blocks))
          (define d (pick-el blocks))
          (define i (pick-el center-blocks))
          (define a (list-ref angles (random (length angles))))]
          (above
           (beside (c a) (d (+ a (* 2 90))) (c (+ a (* 3 90))))
           (beside (d (+ a (* 3 90))) i (d (+ a 90)))
           (beside (c (+ a 90)) (d a) (c (+ a (* 2 90)))))))

;(define (make-block n)
;  (cond
;    [(zero? n) (block)]
;    [else
;     (local [(define c (make-block (- n 1)))
;             (define i (block))]
;       (above (beside c c c)
;              (beside c c c)
;              (beside c c c)))]))

