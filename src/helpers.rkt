#lang racket

(require 2htdp/image)
(require "constants.rkt")


(provide -unit
         unit/x
         unit/2
         unit/4
         fill-sq
         unit-sq
         empty-sq
         unit-square)

(define (-unit [u UNIT-SIZE]) (- 0 u))
(define (unit/x x [u UNIT-SIZE]) (/ u x))
(define (unit/2 [u UNIT-SIZE]) (unit/x 2))
(define (unit/4 [u UNIT-SIZE]) (unit/x 4))

;; Some helper squares
(define (fill-sq [u UNIT-SIZE]) (rectangle u u MODE COLOR))
(define (unit-sq [u UNIT-SIZE]) (rectangle u u MODE BG-COLOR))
(define (empty-sq [u UNIT-SIZE]) (rectangle u u MODE "transparent"))
(define (unit-square
         [u UNIT-SIZE]
         #:view-mode [view-mode MODE])
  (match view-mode
    ['solid   (rectangle u u MODE BG-COLOR)]
    ['outline (rectangle u u 'outline 'black)]))