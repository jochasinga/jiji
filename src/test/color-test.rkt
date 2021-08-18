#lang racket

(require rackunit
         "../color.rkt")

(check-equal? (hex->rgb "FF") '(255))
(check-equal? (hex->rgb "ff") '(255))
(check-equal? (hex->rgb "f0") '(240))
(check-equal? (hex->rgb "f7f7F0") '(247 247 240))

(check-equal? (with-handlers ([exn:fail:contract?
                   (λ (e) "error")])
                (hex->rgb ""))
              "error")
(check-equal? (with-handlers ([exn:fail:contract?
                   (λ (e) "error")])
                (hex->rgb "f0f0f0f"))
              "error")
