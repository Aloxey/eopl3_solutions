#lang racket

; q 1.15
(define duple
  (lambda (n x)
    (if (= n 0)
        '()
        (cons x (duple (- n 1) x)))))


; q 1.16
(define invert
  (lambda (lst)
    (if (null? lst)
         '()
      (cons (list (cadr (car lst)) (car (car lst)))
            (invert (cdr lst))))))


; q 1.17
(define down
  (lambda (lst)
        (if (null? lst)
            '()
            (cons (list (car lst)) (down (cdr lst))))))


; q 1.18
;; Doesn't work
(define swapper
  (lambda (s1 s2 lst)
    (if (null? lst)
        '()
        (if (s1 (car lst))
            (cons (s2 (swapper (cdr lst))))
            (if ((car lst) s2)
               (cons (s1 (swapper (cdr lst))))
               (cons (car lst) (cdr lst)))))))


; q 1.19
;; my solution - desn't work
(define list-set1
  (lambda (lst n x)
    (if (null? lst)
    '()
    (if (= (length lst) n)
        (cons (x (list-set1 ((cdr lst) (- n 1) x))))
        (cons (car lst) (list-set1 ((cdr lst) (- n 1) x)))
        )
    )))
;;github solution
(define list-set
  (lambda (lst n x)
    (if (null? lst)
        '()
        (if (eqv? n 0)
            (cons x (cdr lst))
            (cons (car lst) (list-set (cdr lst) (- n 1) x))))))


; q 1.20 --- I don't understand the question
;(define count-occurences
;  (lambda (s slint)
;    (


; q 1.21
;; My solution, doesn't work
;(define product
;  (lambda (sos1 sos2)
;    (if (null? sos1)
;        '()
;        (if (null? sos2)
;            '()
;            (cons (car sos1) (car sos2))

;; Github solution - 1
(define product
  (lambda (sos1 sos2)
    (if (null? sos1)
        '()
        (append (map (lambda (s2) 
                       (list (car sos1) s2))
                     sos2)
                (product (cdr sos1) sos2)))))





              
                 
    
         