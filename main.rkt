#! /usr/bin/env racket
#lang racket

(require 2htdp/image)
(require lang/posn)
(require racket/cmdline)

(require "primitive.rkt")

(define angles '(0 90 180 270))
(define blank (sixteen))
(define center-blocks (map (lambda (f) (f))
                       (list one five nine sixteen)))
(define blocks (list 
                two three four five six seven eight nine ten
                eleven twelve thirteen fourteen fifteen sixteen))
                    
(define (pick-el l) (list-ref l (random (length l))))

(define (block [n 0] #:view-mode [m 'solid])
  (local [(define c (pick-el blocks))
          (define d (pick-el blocks))
          (define i (pick-el center-blocks))
          (define a (list-ref angles (random (length angles))))]
    (let ([bg (above
               (beside (c a) (d (+ a (* 2 90))) (c (+ a (* 3 90))))
               (beside (d (+ a (* 3 90))) i (d (+ a 90)))
               (beside (c (+ a 90)) (d a) (c (+ a (* 2 90)))))]
          [grid (local [(define sq (square unit_ 'outline 'black))]
                  (above
                   (beside sq sq sq)
                   (beside sq sq sq)
                   (beside sq sq sq)))]
          [curtain (square (* 3 unit_) 'solid (make-color 255 255 255 150))])
        (if (eq? m 'solid)
          bg
          (overlay grid curtain bg)))))

;(define (make-block n)
;  (cond
;    [(zero? n) (block)]
;    [else
;     (local [(define c (make-block (- n 1)))
;             (define i (block))]
;       (above (beside c c c)
;              (beside c c c)
;              (beside c c c)))]))

(define view-mode (make-parameter 'solid))
(define file-path (make-parameter "./block.svg"))

(define parser
  (command-line
   #:usage-help
   "Jiji is a command line tool to generate nine-block quilt pattern"

   #:once-each
   [("-m" "--mode") VIEW-MODE
                    "Set a view mode to solid or outline"
                    (view-mode (string->symbol VIEW-MODE))]
   [("-p" "--path") FILE-PATH
                    "Set a view mode to solid or outline"
                    (file-path FILE-PATH)]

   #:args () (void)))

(define (save-as-image img
                       [filename "./block.png"]
                       #:format   [format 'png])
  (let ([default-save (lambda ()
       (save-image (block) filename))])
    (cond
      [(eq? format 'svg)
        (save-svg-image (block) "./block.svg")]
      [(eq? format 'png) (default-save)]
      [else (default-save)])

  (printf "~a ~a\n" "Saved file as" name)))

(save-as-image (block))



