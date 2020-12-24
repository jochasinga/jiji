#lang racket

(require 2htdp/image)
(require lang/posn)

(provide one
         two
         three
         four
         five
         ten
         ten_)

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

(define six (polygon (list (make-posn 0 0)
                           (make-posn unit_ (/ unit_ 2))
                           (make-posn unit_ unit_)
                           (make-posn (/ unit_ 2) unit_))
                     mode
                     color))

(define seven
    (above _three (beside _three _three)))

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

(define nine_ (place-image (scale 0.5 _one)
                           (/ unit_ 2)
                           (/ unit_ 2)
                           (unit-sq unit_)))

(define (nine [deg 0])
  (let ([t (scale 0.5 one)])
    (place-image (rotate deg t)
                 unit/2 unit/2
                 (unit-sq unit_))))

(define (ten [deg 0])
  (let ([t (scale 0.5 two)])
    (place-image
     (rotate deg
             (place-images
              (list t t)
              (list (make-posn unit/4 (* 3 unit/4))
                    (make-posn (* 3 unit/4) unit/4))
              (empty-sq unit_)))
     unit/2 unit/2
     (unit-sq unit_))))

(define ten_
  (let ([t (scale 0.5 _two)])
    (place-images
     (list t t)
     (list (make-posn (/ unit_ 4) (* 3 (/ unit_ 4)))
           (make-posn (* 3 (/ unit_ 4)) (/ unit_ 4)))
     (unit-sq unit_))))

(define eleven_
  (let ([u (scale 0.5 _one)]
        [offset (/ unit_ 4)])
    (place-image
     u
     offset offset
     (unit-sq unit_))))

(define thirteen (polygon (list (make-posn 0 0)
                               (make-posn (/ unit_ 2) (- (/ unit_ 2)))
                               (make-posn unit_ 0))
                       mode
                       color))
(define thirteen_ (place-image/align thirteen
                                   (/ unit_ 2) (/ unit_ 2) "middle" "top"
                                   (unit-sq unit_)))
                              
(define twelve (flip-vertical thirteen))

(define twelve_ (place-image/align twelve
                                   (/ unit_ 2) (/ unit_ 2)
                                   'middle 'bottom
                                   (unit-sq unit_)))

(define fifteen_ (place-image/align
                  (scale 0.5 _two)
                  0 0
                  "left" "top"
                  (unit-sq unit_)))

(define sixteen_ (unit-sq unit_))

(define fourteen
  (let ([t (scale 0.5 _two)])
    (rotate 180 t)))
(define fourteen_ (place-image/align
                   fourteen
                   (/ unit_ 2) (/ unit_ 2)
                   "right" "bottom"
                   (unit-sq unit_)))

(define tri-pyramid (scale 0.5
                           (place-image seven unit_ unit_ (unit-sq (* 2 unit_)))))
(define kite (place-image six
                          (/ unit_ 2)
                          (/ unit_ 2)
                          (unit-sq unit_)))

(define pyramid (place-image _three
                             (/ unit_ 2)
                             (/ unit_ 2)
                             (unit-sq unit_)))