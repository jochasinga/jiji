#! /usr/bin/env racket
#lang racket

(require 2htdp/image)
(require lang/posn)
(require racket/cmdline)
(require racket/path)
(require racket/format)
(require racket/match)
(require uuid)

(require (prefix-in list/ "../ratchet/list.rkt"))
(require (rename-in "primitive.rkt"
                    (unit_ base-unit)))

(define unit_ base-unit)
(define angles '(0 90 180 270))
(define blank (sixteen))
(define center-blocks (map (lambda (f) (f))
                       (list one five nine sixteen)))
(define blocks (list 
                two three four five six seven eight nine ten
                eleven twelve thirteen fourteen fifteen sixteen))
                    
(define (pick-el l) (list-ref l (random (length l))))

(define fill-block
  (let ([a (unit-sq)])
    (above
     (beside a a a)
     (beside a a a)
     (beside a a a))))

(define (quilt [images null] #:remote [remote #f] #:trim-width [trim-width 0.5])
  (let* ([create-bitmap (if remote bitmap/url bitmap/file)]
         [p (cond
              [(null? images) (list (block #:scale 0.2) (block #:scale 0.2))]
              [(= (length images) 1)
               (list (scale 0.2 (create-bitmap (car images))) (scale 0.2 fill-block))]
              [else (list (scale 0.2 (create-bitmap (car images)))
                          (scale 0.2 (create-bitmap (car (cdr images)))))])])
    (match p
      [(list a b) 
       (overlay
        (above
         (beside b a b a b a b a b)
         (beside a b a b a b a b a)
         (beside b a b a b a b a b)
         (beside a b a b a b a b a)
         (beside b a b a b a b a b)
         (beside a b a b a b a b a)
         (beside b a b a b a b a b)
         (beside a b a b a b a b a)
         (beside b a b a b a b a b))
        (scale 0.2 (fill-sq (* 10 (* 3 unit_)))))])))

(define (block [n 0]
               #:view-mode [m "solid"]
               #:size [size unit_]
               #:scale [sc 1])
  
  (local [(define c (pick-el blocks))
          (define d (pick-el blocks))
          (define i (pick-el center-blocks))
          (define a (list-ref angles (random (length angles))))]
    (let ([bg (above
               (beside (c a) (d (+ a (* 2 90))) (c (+ a (* 3 90))))
               (beside (d (+ a (* 3 90))) i (d (+ a 90)))
               (beside (c (+ a 90)) (d a) (c (+ a (* 2 90)))))]
          [grid (local [(define sq (square size 'outline "cornflower blue"))]
                  (above
                   (beside sq sq sq)
                   (beside sq sq sq)
                   (beside sq sq sq)))]
          [curtain (square (* 3 size) 'solid (make-color 255 255 255 150))])
        (scale sc
               (cond
                 [(string=? m "solid") bg]
                 [(string=? m "outline") (overlay grid curtain bg)]
                 [else bg])))))


(define variation (make-parameter "single"))
(define view-mode (make-parameter "solid"))
(define image-files (make-parameter null))
(define remote (make-parameter #t))
(define file-name
    (make-parameter (format "~a.png" uuid-string)))

(define parser
  (command-line
   #:program "nine-block generator"
   
   #:usage-help
   "Jiji is a command line tool to generate nine-block quilt pattern."
   
   #:once-any
   [("-s" "--single") "Generate a single nine-block unit"
                      (variation "single")]
   [("-c" "--composition") "Generate a quilt design from blocks."
                      (variation "composition")]
   
   #:multi
   [("-i" "--image") IMAGE-FILE
                     "Image of a block"
                     (image-files (cons IMAGE-FILE (image-files)))]
                      
   #:once-each
   [("-m" "--mode") VIEW-MODE
                    "Set a view mode to solid or outline."
                    (view-mode VIEW-MODE)]
   [("-f" "--file") FILE-NAME
                    "Set the destination file name."
                    (file-name FILE-NAME)]
   [("-r" "--remote") "Set to download remote file for quilt."
                      (remote #t)]

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
          (printf "~a" name))
        (let ([name (string-append path (uuid-string) ".png")])
          (save-image (block #:view-mode mo) name)
          (printf "~a" name)))))

(define (save-img image [dir "./"] [as "png"])
  (cond
    [(eq? as "png")
     (let ([name (string-append dir (uuid-string) ".png")])
       (save-image image name)
       ;; This print is important the server will parse this as file name.
       (printf "~a" name))]
    [else 
     (let ([name (string-append dir (uuid-string) ".svg")])          
       (save-svg-image image name)
       ;; This print is important the server will parse this as file name.
       (printf "~a" name))]))

(define (main)
  (match (variation)
    ["single" 
     (save-img (block #:view-mode (view-mode)) "static/")]
    ["composition"
     (cond
       [(not (null? (image-files)))
        (save-img
         (quilt (image-files) #:remote (remote))
         "static/")]
       [else
        (save-img (quilt) "static/")])]))

(main)


