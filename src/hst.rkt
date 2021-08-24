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

(require "constants.rkt")
(require (rename-in "primitive.rkt"
                    (two base-1/2)
                    (thirteen base-1/4)))

(define (top-left [u UNIT-SIZE]
                  #:mode [mode MODE]
                  #:color [color COLOR]
                  #:bg-color [bg-color BG-COLOR])
  (base-1/2 0
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))

(define (top-right [u UNIT-SIZE]
                   #:mode [mode MODE]
                   #:color [color COLOR]
                   #:bg-color [bg-color BG-COLOR])
  (base-1/2 270
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))

(define (bottom-left [u UNIT-SIZE]
                     #:mode [mode MODE]
                     #:color [color COLOR]
                     #:bg-color [bg-color BG-COLOR])
  (base-1/2 90
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))

(define (bottom-right [u UNIT-SIZE]
                      #:mode [mode MODE]
                      #:color [color COLOR]
                      #:bg-color [bg-color BG-COLOR])
  (base-1/2 180))

(define (bottom [u UNIT-SIZE]
                #:mode [mode MODE]
                #:color [color COLOR]
                #:bg-color [bg-color BG-COLOR])
  (base-1/4 0
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))

(define (right [u UNIT-SIZE]
               #:mode [mode MODE]
               #:color [color COLOR]
               #:bg-color [bg-color BG-COLOR])
  (base-1/4 90
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))

(define (top [u UNIT-SIZE]
             #:mode [mode MODE]
             #:color [color COLOR]
             #:bg-color [bg-color BG-COLOR])
  (base-1/4 180
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))

(define (left [u UNIT-SIZE]
              #:mode [mode MODE]
              #:color [color COLOR]
              #:bg-color [bg-color BG-COLOR])
  (base-1/4 270
            u
            #:mode mode
            #:color color
            #:bg-color bg-color))




