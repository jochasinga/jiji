#lang racket

(require 2htdp/image)
(require lang/posn)
(require racket/match)
(require racket/path)


(require (rename-in "primitive.rkt"
                    (two base)
                    (thirteen base-2)))

(define (top-left) (base))

(define (top-right) (base 270))

(define (bottom-left)
  (base 90))

(define (bottom-right)
  (base 180))

(define (bottom) (base-2))

(define (right) (base-2 90))

(define (top) (base-2 180))

(define (left) (base-2 270))




