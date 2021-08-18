#lang racket

(require 2htdp/image)
(require lang/posn)
(require racket/match)

(require "helpers.rkt")
(require
  (rename-in "coordinates.rkt"
             (ORIGIN origin)
             (UP->1/2 up->1/2)))
(require "constants.rkt")

;; Public functions providing basic building blocks of the patches.
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

;; Shape #1
(define (_one [u UNIT-SIZE]) (square u MODE COLOR))

(define (one [deg 0] [u UNIT-SIZE] #:view-mode [MODE 'solid])
  (overlay (rotate deg
                   (if (= 0 (modulo deg 90))
                       (_one u)
                       (scale 0.75 (_one u))))
           (unit-sq u)))

;; Shape #2
(define (_two [u UNIT-SIZE]) (polygon (list (make-posn 0 0)
                                        (make-posn 0 u)
                                        (make-posn u 0))
                                  MODE
                                  COLOR))
(define (two [deg 0] [u UNIT-SIZE])
  (overlay
     (rotate deg (place-image
                  (if (= 0 (modulo deg 90))
                      (_two u)
                      (scale 0.75 (_two u)))
                  (unit/2 u) (unit/2 u)
                  (empty-sq u)))
     (unit-sq u)))

;; Shape #3
(define (_three [u UNIT-SIZE])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (-unit u))
                 (make-posn u 0))                       
           MODE
           COLOR))
(define (three [deg 0] [u UNIT-SIZE])
  (place-image (rotate deg (_three u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))

;; Shape #4
(define (_four [u UNIT-SIZE])
  (rectangle (unit/2 u) u MODE COLOR))

(define (four [deg 0] [u UNIT-SIZE])
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
(define (_five [u UNIT-SIZE])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (- (unit/2 u)))
                            (make-posn u 0)
                            (make-posn (unit/2 u) (unit/2 u)))
                      MODE
                      COLOR))
(define (five [deg 0] [u UNIT-SIZE])
  (place-image
   (rotate deg
           (place-image (_five u)
                        (unit/2 u) (unit/2 u)
                        (empty-sq u)))
  (unit/2 u) (unit/2 u)
  (unit-sq u)))

;; Shape #6
(define (_six [u UNIT-SIZE])
  (polygon (list (make-posn 0 0)
                 (make-posn u (unit/2 u))
                 (make-posn u u)
                 (make-posn (unit/2 u) u))
           MODE
           COLOR))
(define (six [deg 0] [u UNIT-SIZE])
  (place-image
   (rotate deg (place-image
                (_six u)
                (unit/2 u) (unit/2 u)
                (empty-sq u)))
   (unit/2 u) (unit/2 u)
   (unit-sq u)))

;; Shape #7
(define (_seven [u UNIT-SIZE])
    (above
     (_three u)
     (beside (_three u) (_three u))))
;; This can't handle angle that's not a right angle.
(define (seven [deg 0] [u UNIT-SIZE])
  (let ([t (scale 0.5 (_seven u))])
    (place-image
     (rotate deg (place-image
                  t
                  (unit/2 u) (unit/2 u)
                  (empty-sq u)))
     (unit/2 u) (unit/2 u)
     (unit-sq u))))

;; Shape #8
(define (_eight [u UNIT-SIZE])
  (polygon (list (make-posn 0 0)
                 (make-posn u (unit/2 u))
                 (make-posn (unit/2 u) u))
           MODE
           COLOR))
(define (eight [deg 0] [u UNIT-SIZE])
  (place-image (rotate deg (_eight u))
               (unit/2 u)
               (unit/2 u)
               (unit-sq u)))

;; Shape #9
(define (nine [deg 0] [u UNIT-SIZE])
  (place-image (rotate deg (scale 0.5 (_one u)))
               (unit/2 u)
               (unit/2 u)
               (unit-sq u)))

;; Shape #10
(define (ten [deg 0] [u UNIT-SIZE])
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
(define (_eleven [u UNIT-SIZE])
  (let ([un (scale 0.5 (_one u))]
        [offset (unit/4 u)])
    (place-image
     un
     offset offset
     (empty-sq u))))

(define (eleven [deg 0] [u UNIT-SIZE])
    (place-image
     (rotate deg (_eleven u))
     (unit/2 u) (unit/2 u)
     (unit-sq u)))

;; Shape #13
(define (_thirteen [u UNIT-SIZE])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (- (unit/2 u)))
                 (make-posn u 0))
           MODE
           COLOR))
(define (thirteen_ [u UNIT-SIZE])
  (place-image/align (_thirteen u)
                     (unit/2 u) (unit/2 u)
                     "middle" "top"
                     (empty-sq u)))
(define (thirteen [deg 0] [u UNIT-SIZE])
  (place-image
   (rotate deg (thirteen_ u))
   (unit/2 u) (unit/2 u)
   (unit-sq u)))
  
;; Shape #12                       
(define (_twelve [u UNIT-SIZE])
  (place-image/align (flip-vertical (_thirteen u))
                     (unit/2 u) (unit/2 u)
                     "middle" "top"
                     (empty-sq u)))
(define (twelve [deg 0] [u UNIT-SIZE])
  (rotate deg (_twelve u))
  (place-image (rotate deg (_twelve u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))

;; Shape #15
(define (_fifteen [u UNIT-SIZE])
  (place-image/align
   (scale 0.5 (_two u))
                  0 0
                  "left" "top"
                  (empty-sq u)))
(define (fifteen [deg 0] [u UNIT-SIZE])
  (place-image (rotate deg (_fifteen u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))

;; Shape #16
(define (sixteen
         [deg 0]
         [u UNIT-SIZE])
  (unit-sq u))

;; Shape #14
(define (_fourteen [u UNIT-SIZE])
  (let ([t (scale 0.5 (_two u))])
    (rotate 180 t)))

(define (fourteen_ [u UNIT-SIZE])
  (place-image/align
   (_fourteen u)
   (unit/2 u) (unit/2 u)
   "right" "bottom"
   (empty-sq u)))

(define (fourteen [deg 0] [u UNIT-SIZE])
  (place-image (rotate deg (fourteen_ u))
               (unit/2 u) (unit/2 u)
               (unit-sq u)))
  

(define tri-pyramid (scale 0.5
                           (place-image (_seven) UNIT-SIZE UNIT-SIZE (unit-sq (* 2 UNIT-SIZE)))))
(define kite (place-image (_six)
                          (/ UNIT-SIZE 2)
                          (/ UNIT-SIZE 2)
                          (unit-sq UNIT-SIZE)))

(define pyramid (place-image (_three)
                             (/ UNIT-SIZE 2)
                             (/ UNIT-SIZE 2)
                             (unit-sq UNIT-SIZE)))