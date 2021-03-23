#lang racket

(require 2htdp/image)
(require lang/posn)
(require racket/match)

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
         sixteen
         unit_
         unit-sq
         fill-sq)

;; Default unit
(define unit_ 100)

;; Other helpers
(define (-unit [u unit_]) (- 0 u))
(define (unit/x x [u unit_]) (/ u x))
(define (unit/2 [u unit_]) (unit/x 2))
(define (unit/4 [u unit_]) (unit/x 4))

;; Default colors and style
(define mode 'solid)
(define color "cornflower blue")
(define bg-color 'lavender)

;; Some helper squares
(define (fill-sq [u unit_]) (rectangle u u mode color))
(define (unit-sq [u unit_]) (rectangle u u mode bg-color))
(define (empty-sq [u unit_]) (rectangle u u mode "transparent"))
(define (unit-square
         [u unit_]
         #:view-mode [view-mode 'solid])
  (match view-mode
    ['solid   (rectangle u u 'solid bg-color)]
    ['outline (rectangle u u 'outline 'black)]))
  
;; Coordinates
(define origin (make-posn 0 0))
(define up->1/2 (make-posn 0 -unit))

;; Shape #1
(define (_one [u unit_]) (square u mode color))

(define (one [deg 0] [u unit_] #:view-mode [mode 'solid])
  (overlay (rotate deg
                   (if (= 0 (modulo deg 90))
                       (_one u)
                       (scale 0.75 (_one u))))
           (unit-sq u)))

;; Shape #2
(define (_two [u unit_]) (polygon (list (make-posn 0 0)
                                        (make-posn 0 u)
                                        (make-posn u 0))
                                  mode
                                  color))
(define (two [deg 0] [u unit_])
  (overlay
     (rotate deg (place-image
                  (if (= 0 (modulo deg 90))
                      (_two u)
                      (scale 0.75 (_two u)))
                  (unit/2 u) (unit/2 u)
                  (empty-sq u)))
     (unit-sq u)))

;; Shape #3
(define (_three [u unit_])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (-unit u))
                 (make-posn u 0))                       
           mode
           color))
(define (three [deg 0] [u unit_])
  (place-image (rotate deg (_three u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))

;; Shape #4
(define (_four [u unit_])
  (rectangle (unit/2 u) u mode color))

(define (four [deg 0] [u unit_])
  (place-image
   (rotate deg (place-image
                (if (= 0 (modulo deg 90))
                    (_four u)
                    (scale 0.75 (_four u)))
                (unit/4 u) (unit/2 u)
                (empty-sq u)))
   (unit/2 u) (unit/2 u)
   (unit-sq u)))

;; Shape #5
(define (_five [u unit_])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (- (unit/2 u)))
                            (make-posn u 0)
                            (make-posn (unit/2 u) (unit/2 u)))
                      mode
                      color))
(define (five [deg 0] [u unit_])
  (place-image
   (rotate deg
           (place-image (_five u)
                        (unit/2 u) (unit/2 u)
                        (empty-sq u)))
  (unit/2 u) (unit/2 u)
  (unit-sq u)))

;; Shape #6
(define (_six [u unit_])
  (polygon (list (make-posn 0 0)
                 (make-posn u (unit/2 u))
                 (make-posn u u)
                 (make-posn (unit/2 u) u))
           mode
           color))
(define (six [deg 0] [u unit_])
  (place-image
   (rotate deg (place-image
                (_six u)
                (unit/2 u) (unit/2 u)
                (empty-sq u)))
   (unit/2 u) (unit/2 u)
   (unit-sq u)))

;; Shape #7
(define (_seven [u unit_])
    (above
     (_three u)
     (beside (_three u) (_three u))))
;; This can't handle angle that's not a right angle.
(define (seven [deg 0] [u unit_])
  (let ([t (scale 0.5 (_seven u))])
    (place-image
     (rotate deg (place-image
                  t
                  (unit/2 u) (unit/2 u)
                  (empty-sq u)))
     (unit/2 u) (unit/2 u)
     (unit-sq u))))

;; Shape #8
(define (_eight [u unit_])
  (polygon (list (make-posn 0 0)
                 (make-posn u (unit/2 u))
                 (make-posn (unit/2 u) u))
           mode
           color))
(define (eight [deg 0] [u unit_])
  (place-image (rotate deg (_eight u))
               (unit/2 u)
               (unit/2 u)
               (unit-sq u)))

;; Shape #9
(define (nine [deg 0] [u unit_])
  (place-image (rotate deg (scale 0.5 (_one u)))
               (unit/2 u)
               (unit/2 u)
               (unit-sq u)))

;; Shape #10
(define (ten [deg 0] [u unit_])
  (let ([t (scale 0.5 (_two u))])
    (place-image
     (rotate deg
             (place-images
              (list t t)
              (list (make-posn (unit/4 u) (* 3 (unit/4 u)))
                    (make-posn (* 3 (unit/4 u)) (unit/4 u)))
              (empty-sq u)))
     (unit/2 u) (unit/2 u)
     (unit-sq u))))

;; Shape #11
(define (_eleven [u unit_])
  (let ([un (scale 0.5 (_one u))]
        [offset (unit/4 u)])
    (place-image
     un
     offset offset
     (empty-sq u))))

(define (eleven [deg 0] [u unit_])
    (place-image
     (rotate deg (_eleven u))
     (unit/2 u) (unit/2 u)
     (unit-sq u)))

;; Shape #13
(define (_thirteen [u unit_])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (- (unit/2 u)))
                 (make-posn u 0))
           mode
           color))
(define (thirteen_ [u unit_])
  (place-image/align (_thirteen u)
                     (unit/2 u) (unit/2 u)
                     "middle" "top"
                     (empty-sq u)))
(define (thirteen [deg 0] [u unit_])
  (place-image
   (rotate deg (thirteen_ u))
   (unit/2 u) (unit/2 u)
   (unit-sq u)))
  
;; Shape #12                       
(define (_twelve [u unit_])
  (place-image/align (flip-vertical (_thirteen u))
                     (unit/2 u) (unit/2 u)
                     "middle" "top"
                     (empty-sq u)))
(define (twelve [deg 0] [u unit_])
  (rotate deg (_twelve u))
  (place-image (rotate deg (_twelve u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))

;; Shape #15
(define (_fifteen [u unit_])
  (place-image/align
   (scale 0.5 (_two u))
                  0 0
                  "left" "top"
                  (empty-sq u)))
(define (fifteen [deg 0] [u unit_])
  (place-image (rotate deg (_fifteen u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))

;; Shape #16
(define (sixteen
         [deg 0]
         [u unit_])
  (unit-sq u))

;; Shape #14
(define (_fourteen [u unit_])
  (let ([t (scale 0.5 (_two u))])
    (rotate 180 t)))

(define (fourteen_ [u unit_])
  (place-image/align
   (_fourteen u)
   (unit/2 u) (unit/2 u)
   "right" "bottom"
   (empty-sq u)))

(define (fourteen [deg 0] [u unit_])
  (place-image (rotate deg (fourteen_ u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))
  

(define tri-pyramid (scale 0.5
                           (place-image (_seven) unit_ unit_ (unit-sq (* 2 unit_)))))
(define kite (place-image (_six)
                          (/ unit_ 2)
                          (/ unit_ 2)
                          (unit-sq unit_)))

(define pyramid (place-image (_three)
                             (/ unit_ 2)
                             (/ unit_ 2)
                             (unit-sq unit_)))