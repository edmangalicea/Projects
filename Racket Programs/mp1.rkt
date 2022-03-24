#lang racket
(require racket/trace)
(provide (all-defined-out)) ; export all top-level definitions for testing

;;;;; Part 1: Recursion and Lists

(define (rotate n lst)
(if (= n 1)
    (append (rest lst) (cons(first lst)`()))
  

(rotate (- n 1) (append (rest lst) (cons(first lst)`())))))





(define (lookup key lst)
(cond [(equal? key (car (first lst)))
    (cdr (first lst))]
      [(equal? null (rest lst)) #f]
[else (lookup key (rest lst))]))



(define (update key value lst)
  (let rec ([k null]
            [lst lst]
            [ket key]
            [value value])
  (cond [(equal? null lst) (append (append lst (reverse k)) (cons (cons key value)'()))]          
    [(equal? key (car (first lst)))
         (begin
           (remove (first lst) lst)
                (cons (cons key value) (rest lst)))]
    [else(rec (cons (first lst)k)(rest lst) key value) ])))





(define (equal-shape? shape1 shape2)
 (cond
    [(not (equal? (length shape1) (length shape2)))
   #f]
    [(null? shape1)
     #t]
   [(equal? (list? (first shape1))(list? (first shape2)))
    (equal-shape? (rest shape1) (rest shape2))]
  [else #f]))
   
   
    
      
  


;;;;; Part 2: Higher Order Functions
;;(even? 2)

;;(lambda (x) (f (my-curry rest)))

(define (my-curry f . rest)
  (let rec ([n (procedure-arity f)]
            [a '()])
   
    (lambda (x)
     (cond ((= n 0)
            (apply f (reverse a)))
           ((= n 1)
            (apply f(reverse(cons x a))))
           (else (rec (- n 1) (cons x a)))))
    
    ))

#|

(define (my-curry f . rest)
  (let rec ([n (procedure-arity f)]
            [a '()])
    (cond
      ((= n 1)
       (apply f (reverse (cons x a))))
     ((= n 0)
        (apply f (reverse a)))
    (else (lambda (x)
     (rec (- n 1) (cons x a)))
    ))))
|#



  #|
  (let rec ([n (procedure-arity cons)]
            [f f]
            [rest rest])
    (if (= n 0))
        
    (rec lambda f rest
            
 (lambda (f) rest))
|#

    
;  (if (= 0 lenght rest)
      
 ; (lambda f (rest rest))
   
;(cons (f (first lst)) (map f (rest lst)))))

 
;;  (((my-curry cons) 1) 2)
;;((my-curry even?) 2)
;;(eval (even? 2))

;;(define (map f lst)
;;  (if (null? lst)
;;      '()
;;      (cons (f (first lst)) (map f (rest lst)))))
  
(define (my-map f lst)
  (trace-let rec ([i f]
            [li lst])
    (if (null? li)
        '()
        (cons (i (first li)) (map i (rest li))))))
;;(trace my-map)
 
;;(my-map (curry * 2) (range 10))
;;(map (curry * 2) (range 10))
;;(my-map (lambda (n) (* n 5)) '(1 3 5 7 10))

  

(define (my-filter pred lst)
  (let rec ([prev pred]
            [ls lst])
    (if (null? ls)
        '()
          (if (prev (first ls))
              (cons (first ls) (rec prev (rest ls)))
              (rec prev (rest ls))))))


;;(apply (cons(lambda (n) (* n 100)) '42))
;;(apply (lambda (n) (* n 100)) 42)
;((first b)(second b))

;;((lambda (n) (* n 100)) '42)
;;((lambda (n) (* n 100)) (second ((lambda (n) (* n 100)) '42)))
;;(eval '((lambda (n) (* n 100)) 42))

;;(define test (lambda (msg . args)
;;               (println msg)
;;               (println (third args))))


;;closure below aka let over lamba

(define (make-object name)
  (let ([env (cons (cons 'name name) '())])
    (lambda (a . b)   
      (match a
        ['get (lookup (first b) env)]
        ['set (set! env (update (first b)(second b)env))]
         ['update
         
            (let ([x ((second b) (lookup (first b) env))])
              (println env)
          (set! env (update (first b) x env)))
         
          

                  ]))))



(define (make-object2 name)
  (let ([env (cons (cons 'name name) '())])
    (lambda (a . b)   
      (match a
        ['get (lookup (first b) env)]
        ['set (set! env (update (first b)(second b)env))]
         ['update

        
            (let ([x ((second b) (lookup (first b) env))])
              (println env)
          (set! env (update (first b) x env)))
         
          

                  ]))))

        ;;['set (set! x (second b))(set! t (first b))]
         ;;   ['update ((second b)x)]))))
;;(define obj (make-object "foo")) 
;;(obj 'get 'name)

;;(obj 'set 'name 'bar)
;;(obj 'get 'name)
;;((lambda (n) (* n 100)) 42)
;;(obj 'set 'x 42)
;;(obj 'update 'x (lambda (n) (* n 100)))
;;(obj 'get 'x)
   

#|
(define max-mag
  (lambda (num nums
    (list-ref (num nums) 1))))
    ;;(apply max (map magnitude (cons num nums)))))
|#
 

;;set!

;;(lamba a (.... a is a list
;;(lamba a . b) the last element b contains the rest of the elements 



;;(max-mag 1 -2 0 3 1 2 3)



;;;;; Part 3: Meta-circular Evaluator

(define (my-eval rexp)
  (let my-eval-env ([rexp rexp]
                    [env '()])           ; environment (assoc list)
    (cond [(symbol? rexp)                ; variable
           void]
          [(eq? (first rexp) 'lambda)    ; lambda expression
           void]
          [else                          ; function application
           void])))


;;;;; Part 4: Free Variables

(define (free sexp)
  '())
