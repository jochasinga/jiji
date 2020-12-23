#lang racket

(require 2htdp/image)
(require lang/posn)

(define unit_ 60)
(define mode 'solid)
(define color 'slateblue)
(define bg-color 'gray)

(define (unit-sq u) (rectangle u u mode bg-color))

;; Coordinates
(define origin (make-posn 0 0))
(define up->1/2 (make-posn 0 (- unit_)))

(define one (square unit_ mode color))
(define two (polygon (list (make-posn 0 0)
                            (make-posn 0 unit_)
                            (make-posn unit_ 0))
                      mode
                      color))
(define (two->x x)
  (polygon (list (make-posn x 0)
                            (make-posn x unit_)
                            (make-posn (+ x unit_) 0))
                      mode
                      color))

(define three (polygon (list (make-posn 0 0)
                             (make-posn (/ unit_ 2) (- unit_))
                             (make-posn unit_ 0))                       
                       mode
                       color))

(define four (rectangle (/ unit_ 2) unit_ mode color))
  
(define five (polygon (list (make-posn 0 0)
                            (make-posn (/ unit_ 2) (- (/ unit_ 2)))
                            (make-posn unit_ 0)
                            (make-posn (/ unit_ 2) (/ unit_ 2)))
                      mode
                      color))

(define six (polygon (list (make-posn 0 0)
                           (make-posn unit_ (/ unit_ 2))
                           (make-posn unit_ unit_)
                           (make-posn (/ unit_ 2) unit_))
                     mode
                     color))

(define seven
    (above three (beside three three)))

(define eight (polygon (list (make-posn 0 0)
                             (make-posn unit_ (/ unit_ 2))
                             (make-posn (/ unit_ 2) unit_))
                       mode
                       color))
  
(define eight_ (place-image eight
                            (/ unit_ 2)
                            (/ unit_ 2)
                            (unit-sq unit_)))

(define nine_ (place-image (scale 0.5 one)
                           (/ unit_ 2)
                           (/ unit_ 2)
                           (unit-sq unit_)))

(define ten_
  (let ([t (scale 0.5 two)])
    (place-images
     (list t t)
     (list (make-posn (/ unit_ 4) (* 3 (/ unit_ 4)))
           (make-posn (* 3 (/ unit_ 4)) (/ unit_ 4)))
     (unit-sq unit_))))

(define eleven_
  (let ([u (scale 0.5 one)]
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
                  (scale 0.5 two)
                  0 0
                  "left" "top"
                  (unit-sq unit_)))

(define sixteen_ (unit-sq unit_))

(define fourteen
  (let ([t (scale 0.5 two)])
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

(define pyramid (place-image three
                             (/ unit_ 2)
                             (/ unit_ 2)
                             (unit-sq unit_)))
(define half-sq (place-image four
                             (/ unit_ 4)
                             (/ unit_ 2)
                             (rectangle unit_ unit_ mode bg-color)))
(define diamond (place-image five
                             (/ unit_ 2)
                             (/ unit_ 2)
                             (rectangle unit_ unit_ mode bg-color)))