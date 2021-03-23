#lang racket

(provide parser)
(provide variation)
(provide view-mode)
(provide image-files)
(provide remote)
(provide file-name)

(require racket/cmdline)
(require uuid)

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