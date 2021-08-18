#lang racket

;; An HST abstraction of the primitives.

(require 2htdp/image)
(require lang/posn)
(require racket/match)
(require racket/path)

(provide top right bottom left
         top-right
         top-left
         bottom-right
         bottom-left)

(require (rename-in "primitive.rkt"
                    (two base-1/2)
                    (thirteen base-1/4)))

(define (top-left) (base-1/2))

(define (top-right) (base-1/2 270))

(define (bottom-left) (base-1/2 90))

(define (bottom-right) (base-1/2 180))

(define (bottom) (base-1/4))

(define (right) (base-1/4 90))

(define (top) (base-1/4 180))

(define (left) (base-1/4 270))




