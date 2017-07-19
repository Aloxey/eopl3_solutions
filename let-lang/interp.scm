(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the LET language.  The \commentboxes are the
  ;; latex code for inserting the rules into the code in the book.
  ;; These are too complicated to put here, see the text, sorry.

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of)


;;new stuff
  ;; ex 3.16
(define cond-val
  (lambda (conds acts env)
    (cond ((null? conds)
           (eopl:error 'cond-val "No conditions got into #t"))
          ((expval->bool (value-of (car conds) env))
           (value-of (car acts) env))
          (else
           (cond-val (cdr conds) (cdr acts) env)))))



(define value-of-vals
  (lambda (vals env)
    (if (null? vals)
	'()
	(cons (value-of (car vals) env)
	      (value-of-vals (cdr vals) env)))))

(define extend-env-list
  (lambda (vars vals env)
    (if (null? vars)
	env
	(let ((var1 (car vars))
	      (val1 (car vals)))
	  (extend-env-list (cdr vars) (cdr vals) (extend-env var1 val1 env))))))

  
;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  ;; Page: 71
  (define value-of-program 
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-env))))))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 71
  (define value-of
    (lambda (exp env)
      (cases expression exp

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
        (const-exp (num) (num-val num))

        ;\commentbox{ (value-of (var-exp \x{}) \r) = (apply-env \r \x{})}
        (var-exp (var) (apply-env env var))

        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (- num1 num2)))))

        ;\commentbox{\zerotestspec}
        (zero?-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (let ((num1 (expval->num val1)))
              (if (zero? num1)
                (bool-val #t)
                (bool-val #f)))))
              
        ;\commentbox{\ma{\theifspec}}
        (if-exp (exp1 exp2 exp3)
          (let ((val1 (value-of exp1 env)))
            (if (expval->bool val1)
              (value-of exp2 env)
              (value-of exp3 env))))





        ;;  ex 3.6
        (minus-exp (exp1)
                   (let
                     ((val1 (value-of exp1 env)))
                     (let ((num1 (expval->num val1))) (num-val (- num1)))))

        ;; ex 3.8
        (equal?-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
               (bool-val (= num1 num2)))))

        ;; ex 3.9
        (cons-exp (exp1 exp2)
                  (let
                      ((val1 (value-of exp1 env))
                       (val2 (value-of exp2 env)))
                        (cons-val val1 val2)))

        ;; ex 3.10
        (emptylist-exp ()
        (emptylist-val))

        ;; ex.16 
        ;\commentbox{\ma{\theletspecsplit}}
        ;old let
        ;(let-exp (var exp1 body)       
        ;  (let ((val1 (value-of exp1 env)))
        ;    (value-of body
        ;      (extend-env var val1 env))))

	   (let-exp (vars vals body)
		    (let ((_vals (value-of-vals vals env)))
		      (value-of body (extend-env-list vars _vals env))))

        
      (list-exp (exprs)
        (list-val (map (lambda (expr) (value-of expr env)) exprs)))

      (car-exp (exp1)
        (let ((val1 (value-of exp1 env)))
          (expval->car val1)))
        
        )))


  )

