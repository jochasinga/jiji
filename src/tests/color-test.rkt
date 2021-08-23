#lang racket

(require rackunit
         "../color.rkt")

(define rosetta-and-cream
  '("#D8A7B1" "#B6E2D3" "#FAE8E0" "#EF7C8E"))

(check-equal? (hex->rgb "FF") '(255))
(check-equal? (hex->rgb "ff") '(255))
(check-equal? (hex->rgb "f0") '(240))
(check-equal? (hex->rgb "f7f7F0") '(247 247 240))
(check-equal? (length (map hex->rgb rosetta-and-cream)) 4)

(check-equal? (with-handlers ([exn:fail:contract?
                   (λ (e) "error")])
                (hex->rgb ""))
              "error")
(check-equal? (with-handlers ([exn:fail:contract?
                   (λ (e) "error")])
                (hex->rgb "f0f0f0f"))
              "error")
