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
(define (_one [u UNIT-SIZE]
              [mode MODE]
              [color COLOR])
  (square u mode color))

(define (one [deg 0]
             [u UNIT-SIZE]
             #:mode [mode MODE]
             #:color [color COLOR]
             #:bg-color [bg-color BG-COLOR])
  (overlay (rotate deg
                   (if (= 0 (modulo deg 90))
                       (_one u mode color)
                       (scale 0.75 (_one u mode color))))
           (unit-sq u #:bg-color bg-color)))

;; Shape #2
(define (_two [u UNIT-SIZE]
              [mode MODE]
              [color COLOR])
  (polygon (list (make-posn 0 0)
                 (make-posn 0 u)
                 (make-posn u 0))
           mode
           color))

(define (two [deg 0]
             [u UNIT-SIZE]
             #:mode [mode MODE]
             #:color [color COLOR]
             #:bg-color [bg-color BG-COLOR])
  (overlay
   (rotate deg (place-image
                (if (= 0 (modulo deg 90))
                    (_two u mode color)
                    (scale 0.75 (_two u mode color)))
                (unit/2 u) (unit/2 u)
                (empty-sq u)))
   (unit-sq u
            #:mode mode
            #:bg-color bg-color)))

;; Shape #3
(define (_three [u UNIT-SIZE]
                [mode MODE]
                [color COLOR])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (-unit u))
                 (make-posn u 0))                       
           mode color))

(define (three [deg 0]
               [u UNIT-SIZE]
               #:mode [mode MODE]
               #:color [color COLOR]
               #:bg-color [bg-color BG-COLOR])
  (place-image (rotate deg (_three u mode color))
               (unit/2 u) (unit/2 u)
               (unit-sq u #:bg-color bg-color)))

;; Shape #4
(define (_four [u UNIT-SIZE]
               [mode MODE]
               [color COLOR])
  (rectangle (unit/2 u) u mode color))

(define (four [deg 0]
              [u UNIT-SIZE]
              #:mode [mode MODE]
              #:color [color COLOR]
              #:bg-color [bg-color BG-COLOR])
  (place-image
   (rotate deg (place-image
                (if (= 0 (modulo deg 90))
                    (_four u mode color)
                    (scale 0.75 (_four u)))
                (unit/4 u) (unit/2 u)
                (empty-sq u)))
   (unit/2 u) (unit/2 u)
   (unit-sq u #:bg-color bg-color)))

;; Shape #5
(define (_five [u UNIT-SIZE]
               [mode MODE]
               [color COLOR])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (- (unit/2 u)))
                            (make-posn u 0)
                            (make-posn (unit/2 u) (unit/2 u)))
                      mode
                      color))
(define (five [deg 0]
              [u UNIT-SIZE]
              #:mode [mode MODE]
              #:color [color COLOR]
              #:bg-color [bg-color BG-COLOR])
  (place-image
   (rotate deg
           (place-image (_five u mode color)
                        (unit/2 u) (unit/2 u)
                        (empty-sq u)))
  (unit/2 u) (unit/2 u)
  (unit-sq u #:bg-color bg-color)))

;; Shape #6
(define (_six [u UNIT-SIZE]
              [mode MODE]
              [color COLOR])
  (polygon (list (make-posn 0 0)
                 (make-posn u (unit/2 u))
                 (make-posn u u)
                 (make-posn (unit/2 u) u))
           mode
           color))
(define (six [deg 0]
             [u UNIT-SIZE]
             #:mode [mode MODE]
             #:color [color COLOR]
             #:bg-color [bg-color BG-COLOR])
  (place-image
   (rotate deg (place-image
                (_six u mode color)
                (unit/2 u) (unit/2 u)
                (empty-sq u)))
   (unit/2 u) (unit/2 u)
   (unit-sq u #:bg-color bg-color)))

;; Shape #7
(define (_seven [u UNIT-SIZE]
                [mode MODE]
                [color COLOR])
    (above
     (_three u mode color)
     (beside (_three u mode color)
             (_three u mode color))))
;; This can't handle angle that's not a right angle.
(define (seven [deg 0]
               [u UNIT-SIZE]
               #:mode [mode MODE]
               #:color [color COLOR]
               #:bg-color [bg-color BG-COLOR])
  (let ([t (scale 0.5 (_seven u mode color))])
    (place-image
     (rotate deg (place-image
                  t
                  (unit/2 u) (unit/2 u)
                  (empty-sq u)))
     (unit/2 u) (unit/2 u)
     (unit-sq u #:bg-color bg-color))))

;; Shape #8
(define (_eight [u UNIT-SIZE]
                [mode MODE]
                [color COLOR])
  (polygon (list (make-posn 0 0)
                 (make-posn u (unit/2 u))
                 (make-posn (unit/2 u) u))
           mode
           color))
(define (eight [deg 0]
               [u UNIT-SIZE]
               #:mode [mode MODE]
               #:color [color COLOR]
               #:bg-color [bg-color BG-COLOR])
  (place-image (rotate deg (_eight u mode color))
               (unit/2 u)
               (unit/2 u)
               (unit-sq u #:bg-color bg-color)))

;; Shape #9
(define (nine [deg 0]
              [u UNIT-SIZE]
              #:mode [mode MODE]
              #:color [color COLOR]
              #:bg-color [bg-color BG-COLOR])
  (place-image (rotate deg (scale 0.5 (_one u mode color)))
               (unit/2 u)
               (unit/2 u)
               (unit-sq u #:bg-color bg-color)))

;; Shape #10
(define (ten [deg 0]
             [u UNIT-SIZE]
             #:mode [mode MODE]
             #:color [color COLOR]
             #:bg-color [bg-color BG-COLOR])
  (let ([t (scale 0.5 (_two u mode color))])
    (place-image
     (rotate deg
             (place-images
              (list t t)
              (list (make-posn (unit/4 u) (* 3 (unit/4 u)))
                    (make-posn (* 3 (unit/4 u)) (unit/4 u)))
              (empty-sq u)))
     (unit/2 u) (unit/2 u)
     (unit-sq u #:bg-color bg-color))))

;; Shape #11
(define (_eleven [u UNIT-SIZE]
                 [mode MODE]
                 [color COLOR])
  (let ([un (scale 0.5 (_one u mode color))]
        [offset (unit/4 u)])
    (place-image
     un
     offset offset
     (empty-sq u))))

(define (eleven [deg 0]
                [u UNIT-SIZE]
                #:mode [mode MODE]
                #:color [color COLOR]
                #:bg-color [bg-color BG-COLOR])
    (place-image
     (rotate deg (_eleven u mode color))
     (unit/2 u) (unit/2 u)
     (unit-sq u #:bg-color bg-color)))

;; Shape #13
(define (_thirteen [u UNIT-SIZE]
                   [mode MODE]
                   [color COLOR])
  (polygon (list (make-posn 0 0)
                 (make-posn (unit/2 u) (- (unit/2 u)))
                 (make-posn u 0))
           mode
           color))

(define (thirteen_ [u UNIT-SIZE]
                   [mode MODE]
                   [color COLOR])
  (place-image/align (_thirteen u mode color)
                     (unit/2 u) (unit/2 u)
                     "middle" "top"
                     (empty-sq u)))

(define (thirteen [deg 0]
                  [u UNIT-SIZE]
                  #:mode [mode MODE]
                  #:color [color COLOR]
                  #:bg-color [bg-color BG-COLOR])
  (place-image
   (rotate deg (thirteen_ u mode color))
   (unit/2 u) (unit/2 u)
   (unit-sq u #:bg-color bg-color)))
  
;; Shape #12                       
(define (_twelve [u UNIT-SIZE]
                 [mode MODE]
                 [color COLOR])
  (place-image/align (flip-vertical (_thirteen u mode color))
                     (unit/2 u) (unit/2 u)
                     "middle" "top"
                     (empty-sq u)))

(define (twelve [deg 0]
                [u UNIT-SIZE]
                #:mode [mode MODE]
                #:color [color COLOR]
                #:bg-color [bg-color BG-COLOR])
  (rotate deg (_twelve u mode color))
  (place-image (rotate deg (_twelve u))
               (unit/2 u) (unit/2 u)
               (unit-sq u #:bg-color bg-color)))

;; Shape #15
(define (_fifteen [u UNIT-SIZE]
                  [mode MODE]
                  [color COLOR])
  (place-image/align
   (scale 0.5 (_two u mode color))
                  0 0
                  "left" "top"
                  (empty-sq u)))

(define (fifteen [deg 0]
                 [u UNIT-SIZE]
                 #:mode [mode MODE]
                 #:color [color COLOR]
                 #:bg-color [bg-color BG-COLOR])
  (place-image (rotate deg (_fifteen u mode color))
               (unit/2 u) (unit/2 u)
               (unit-sq u #:bg-color bg-color)))

;; Shape #16
(define (sixteen [u UNIT-SIZE])
  (unit-sq u))

;; Shape #14
(define (_fourteen [u UNIT-SIZE]
                   [mode MODE]
                   [color COLOR])
  (let ([t (scale 0.5 (_two u mode color))])
    (rotate 180 t)))

(define (fourteen_ [u UNIT-SIZE]
                   [mode MODE]
                   [color COLOR])
  (place-image/align
   (_fourteen u mode color)
   (unit/2 u) (unit/2 u)
   "right" "bottom"
   (empty-sq u)))

(define (fourteen [deg 0]
                  [u UNIT-SIZE]
                  #:mode [mode MODE]
                  #:color [color COLOR]
                  #:bg-color [bg-color BG-COLOR])
  (place-image (rotate deg (fourteen_ u mode color))
               (unit/2 u) (unit/2 u)
               (unit-sq u #:bg-color bg-color)))
  

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