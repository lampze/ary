#!chezscheme

(define (f2i f)
  (if (> (round f) f)
      (- (round f) 1)
      (round f)))

(define (display-list l)
  (if (null? l)
      (newline)
      (begin
        (display (number2H (car l)))
        (display-list (cdr l)))))

(define (display-all in)
  (if (list? in)
      (display-list in)
      (begin (display in)
             (newline))))

(define (number2H n)
  (cond [(< n 10) n]
        [(= n 10) "a"]
        [(= n 11) "b"]
        [(= n 12) "c"]
        [(= n 13) "d"]
        [(= n 14) "e"]
        [(= n 15) "f"]
        [else #f]))

(define (H2number h)
  (cond [(number? h) h]
        [(symbol? h) (H2number (symbol->string h))]
        [(or (equal? h "a") (equal? h "A")) 10]
        [(or (equal? h "b") (equal? h "B")) 11]
        [(or (equal? h "c") (equal? h "C")) 12]
        [(or (equal? h "d") (equal? h "D")) 13]
        [(or (equal? h "e") (equal? h "E")) 14]
        [(or (equal? h "f") (equal? h "F")) 15]
        [else (H2number (string->number h))]))

(define (low-num n)
  (cond [(number? n) (f2i (/ n 10))]
        [(string? n) (substring n 0 (sub1 (string-length n)))]
        [(symbol? n) (low-num (symbol->string n))]
        [else #f]))

(define (get-last-num n)
  (cond [(number? n) (- n (* 10 (low-num n)))]
        [(string? n) (H2number (string (string-ref n (sub1 (string-length n)))))]
        [(symbol? n) (get-last-num (symbol->string n))]
        [else #f]))



(define (D2* d a)
  (define (iter d l)
    (if (= (f2i (/ d a)) 0)
        (cons (modulo d a) l)
        (iter (f2i (/ d a)) (cons (modulo d a) l))))
  (iter d '()))

(define (*2D n a)
  (define (iter n d c)
    (if (or (equal? n 0) (equal? n ""))
        d
        (iter
         (low-num n)
         (+ d (* (get-last-num n) (expt a c)))
         (add1 c))))
  (iter n 0 0))

(define (*2* in out num)
  (cond [(= in 10) (D2* num out)]
        [(= out 10) (*2D num in)]
        [(= in out) num]
        [else (D2* (*2D num in) out)]))