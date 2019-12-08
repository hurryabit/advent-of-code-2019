; day06-1.rkt
#lang racket

(define
  (make-immutable-hash-multi assocs)
  (foldl
   (lambda
     (assoc acc)
     (hash-update
       acc
       (car assoc)
       (lambda (values) (cons (cdr assoc) values))
       empty
     )
   )
   (hash)
   assocs
  )
)

(define
  (count-orbits table object)
  (letrec
    ([go
      (lambda
        (object dist)
        (let*
          ([satellites (hash-ref table object empty)])
          (foldl (lambda (satellite acc) (+ acc (go satellite (+ dist 1)))) dist satellites)
        )
      )
     ])
     (go object 0)
  )
)

(let*
  ([lines (file->lines "input06.txt")]
   [pairs (map (lambda (line) (cons (substring line 0 3) (substring line 4 7))) lines)]
   [table (make-immutable-hash-multi pairs)])
  (displayln (count-orbits table "COM"))
)
