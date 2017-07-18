#lang racket

;; Maman 12 q1

(define create
  (lambda () '()))

(define add-bit
  (lambda (binary-number bit)
    (append binary-number (list bit))))