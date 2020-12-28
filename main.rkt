#! /usr/bin/env racket
#lang racket

(require 2htdp/image)
(require lang/posn)
(require racket/cmdline)
(require racket/path)
(require racket/format)
(require uuid)

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
          [grid (local [(define sq (square unit_ 'outline "cornflower blue"))]
                  (above
                   (beside sq sq sq)
                   (beside sq sq sq)
                   (beside sq sq sq)))]
          [curtain (square (* 3 unit_) 'solid (make-color 255 255 255 150))])
        (if (eq? m 'solid)
          bg
          (overlay grid curtain bg)))))

(define view-mode (make-parameter "solid"))
(define file-name
    (make-parameter (format "~a.png" uuid-string)))

(define parser
  (command-line
   #:usage-help
   "Jiji is a command line tool to generate nine-block quilt pattern."

   #:once-each
   [("-m" "--mode") VIEW-MODE
                    "Set a view mode to solid or outline."
                    (view-mode VIEW-MODE)]
   [("-f" "--file") FILE-NAME
                    "Set the destination file name."
                    (file-name FILE-NAME)]

   #:args () (void)))

(define (save-as-image
         filename
         [mode "solid"])
  (let ([mo    (string->symbol mode)]
        [fname (~a (file-name-from-path filename))]
        [path  (if (path-only filename) (~a (path-only filename)) "")]
        [ext   (string-downcase (~a (path-get-extension filename)))])
    (if (string=? ext ".svg")
        (let ([name (string-append path (uuid-string) ".svg")])          
          (save-svg-image (block #:view-mode mo) name)
          (print name))
        (let ([name (string-append path (uuid-string) ".png")])
          (save-image (block #:view-mode mo) name)
          (print name)))))

(save-as-image (file-name) (view-mode))



