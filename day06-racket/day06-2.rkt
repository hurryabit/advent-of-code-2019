; day06-2.rkt
#lang racket

(define (path table object)
  (letrec
    ([go
      (lambda (satellite acc)
        (if (hash-has-key? table satellite)
          (let ([planet (hash-ref table satellite)])
            (go planet (cons planet acc))
          )
          acc
        )
      )
    ])
    (go object empty)
  )
)

(define/match (strip-common-prefix xs ys)
  [((cons x xs) (cons y ys)) #:when (equal? x y) (strip-common-prefix xs ys)]
  [(_ _) (cons xs ys)]
)

(let*
  ([lines (file->lines "input06.txt")]
   [pairs (map (lambda (line) (cons (substring line 4 7) (substring line 0 3))) lines)]
   [table (make-immutable-hash pairs)]
   [san-path (path table "SAN")]
   [you-path (path table "YOU")]
   [stripped (strip-common-prefix san-path you-path)]
  )
  (displayln (+ (length (car stripped)) (length (cdr stripped))))
)
