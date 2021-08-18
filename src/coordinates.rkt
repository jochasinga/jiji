#lang racket

(require lang/posn)
(require "helpers.rkt")

;; Coordinate constants

(provide ORIGIN
         UP->1/2)

(define ORIGIN (make-posn 0 0))
(define UP->1/2 (make-posn 0 -unit))
