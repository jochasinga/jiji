#lang racket

(require 2htdp/image)
(require lang/posn)

(provide one
         two
         three
         four
         five
         six
         seven
         eight
         nine
         ten
         eleven
         twelve
         thirteen
         fourteen
         fifteen
         sixteen)

(define unit_ 20)
(define -unit (- 0 unit_))
(define (unit/x x) (/ unit_ x))
(define unit/2 (/ unit_ 2))
(define unit/4 (/ unit_ 4))

(define mode 'solid)
(define color 'slateblue)
(define bg-color 'gray)

(define (unit-sq u) (rectangle u u mode bg-color))
(define (empty-sq u) (rectangle u u mode "transparent"))

;; Coordinates
(define origin (make-posn 0 0))
(define up->1/2 (make-posn 0 -unit))

(define _one (square unit_ mode color))
(define (one [deg 0])
  (place-image (rotate deg
                       (if (= 0 (modulo deg 90))
                           _one
                           (scale 0.75 _one)))
               unit/2 unit/2
               (unit-sq unit_)))
  
(define _two (polygon (list (make-posn 0 0)
                            (make-posn 0 unit_)
                            (make-posn unit_ 0))
                      mode
                      color))
(define (two [deg 0])
  (place-image
     (rotate deg (place-image
                  (if (= 0 (modulo deg 90))
                      _two
                      (scale 0.75 _two))
                  unit/2 unit/2
                  (empty-sq unit_)))
     unit/2 unit/2
     (unit-sq unit_)))

(define _three (polygon (list (make-posn 0 0)
                              (make-posn (/ unit_ 2) (- unit_))
                              (make-posn unit_ 0))                       
                        mode
                        color))
(define (three [deg 0])
  (place-image (rotate deg _three)
               unit/2 unit/2
               (unit-sq unit_)))

(define _four (rectangle (/ unit_ 2) unit_ mode color))
(define (four [deg 0])
  (place-image
   (rotate deg (place-image
                (if (= 0 (modulo deg 90))
                    _four
                    (scale 0.75 _four))
                unit/4 unit/2
                (empty-sq unit_)))
   unit/2 unit/2
   (unit-sq unit_)))

(define _five (polygon (list (make-posn 0 0)
                            (make-posn (/ unit_ 2) (- (/ unit_ 2)))
                            (make-posn unit_ 0)
                            (make-posn (/ unit_ 2) (/ unit_ 2)))
                      mode
                      color))
(define (five [deg 0])
  (place-image
   (rotate deg
           (place-image _five
                        unit/2 unit/2
                        (empty-sq unit_)))
  unit/2 unit/2
  (unit-sq unit_)))

(define _six (polygon (list (make-posn 0 0)
                           (make-posn unit_ (/ unit_ 2))
                           (make-posn unit_ unit_)
                           (make-posn (/ unit_ 2) unit_))
                     mode
                     color))
(define (six [deg 0])
  (place-image
   (rotate deg (place-image
                _six
                unit/2 unit/2
                (empty-sq unit_)))
   unit/2 unit/2
   (unit-sq unit_)))

(define _seven
    (above _three (beside _three _three)))
;; This can't handle angle that's not a right angle.
(define (seven [deg 0])
  (let ([t (scale 0.5 _seven)])
    (place-image
     (rotate deg (place-image
                      t
                      unit/2 unit/2
                  (empty-sq unit_)))
     unit/2 unit/2
     (unit-sq unit_))))

;(define (seven [deg 0])
;  (let ([t (scale 0.5 _seven)])
;    (define w (image-width t))
;    (define h (image-height t))
;    (define d (max w h))
;    (define dx (/ w 2))   ; centroid x offset
;    (define dy (* 2/3 h)) ; centroid y offset
;    (define blank (circle d "solid" "transparent"))
;    (let ([shape (rotate deg (place-image/align t (- d dx) (- d dy) "left" "top" blank))])
;      (place-image shape
;                   unit/2 unit/2
;                   (unit-sq unit_)))))

(define _eight (polygon (list (make-posn 0 0)
                             (make-posn unit_ (/ unit_ 2))
                             (make-posn (/ unit_ 2) unit_))
                       mode
                       color))
(define (eight [deg 0])
  (place-image (rotate deg _eight)
               (/ unit_ 2)
               (/ unit_ 2)
               (unit-sq unit_)))

(define (nine [deg 0])
  (place-image (rotate deg (scale 0.5 _one))
               (/ unit_ 2)
               (/ unit_ 2)
               (unit-sq unit_)))

(define (ten [deg 0])
  (let ([t (scale 0.5 _two)])
    (place-image
     (rotate deg
             (place-images
              (list t t)
              (list (make-posn unit/4 (* 3 unit/4))
                    (make-posn (* 3 unit/4) unit/4))
              (empty-sq unit_)))
     unit/2 unit/2
     (unit-sq unit_))))

(define _eleven
  (let ([u (scale 0.5 _one)]
        [offset (/ unit_ 4)])
    (place-image
     u
     offset offset
     (empty-sq unit_))))

(define (eleven [deg 0])
    (place-image
     (rotate deg _eleven)
     unit/2 unit/2
     (unit-sq unit_)))

(define _thirteen (polygon (list (make-posn 0 0)
                                (make-posn (/ unit_ 2) (- (/ unit_ 2)))
                                (make-posn unit_ 0))
                       mode
                       color))
(define thirteen_ (place-image/align _thirteen
                                   unit/2 unit/2
                                   "middle" "top"
                                   (empty-sq unit_)))
(define (thirteen [deg 0])
  (place-image
   (rotate deg thirteen_)
   unit/2 unit/2
   (unit-sq unit_)))
  
                       
(define _twelve
  (place-image/align (flip-vertical _thirteen)
                     unit/2 unit/2
                     'middle 'top
                     (empty-sq unit_)))
(define (twelve [deg 0])
  (rotate deg _twelve)
  (place-image (rotate deg _twelve)
               unit/2 unit/2
               (unit-sq unit_)))

(define _fifteen (place-image/align
                  (scale 0.5 _two)
                  0 0
                  "left" "top"
                  (empty-sq unit_)))
(define (fifteen [deg 0])
  (place-image (rotate deg _fifteen)
               unit/2 unit/2
               (unit-sq unit_)))

(define sixteen (unit-sq unit_))

(define _fourteen
  (let ([t (scale 0.5 _two)])
    (rotate 180 t)))
(define fourteen_ (place-image/align
                   _fourteen
                   (/ unit_ 2) (/ unit_ 2)
                   "right" "bottom"
                   (empty-sq unit_)))
(define (fourteen [deg 0])
  (place-image (rotate deg fourteen_)
               unit/2 unit/2
               (unit-sq unit_)))
  

(define tri-pyramid (scale 0.5
                           (place-image _seven unit_ unit_ (unit-sq (* 2 unit_)))))
(define kite (place-image _six
                          (/ unit_ 2)
                          (/ unit_ 2)
                          (unit-sq unit_)))

(define pyramid (place-image _three
                             (/ unit_ 2)
                             (/ unit_ 2)
                             (unit-sq unit_)))