;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl2.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v 1409c1352feb 2013/03/24 20:44:50 toy $")

;;; Using Lisp SBCL 2.0.9
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))

(in-package :magicl.lisp-lapack)


(let* ((zero (f2cl-lib:cmplx 0.0 0.0)))
  (declare (type (f2cl-lib:complex8) zero)
           (ignorable zero))
  (defun chpr (uplo n alpha x incx ap)
    (declare (type (array f2cl-lib:complex8 (*)) ap x)
             (type (single-float) alpha)
             (type (f2cl-lib:integer4) incx n)
             (type (string 1) uplo))
    (f2cl-lib:with-multi-array-data
        ((uplo character uplo-%data% uplo-%offset%)
         (x f2cl-lib:complex8 x-%data% x-%offset%)
         (ap f2cl-lib:complex8 ap-%data% ap-%offset%))
      (prog ((i 0) (info 0) (ix 0) (j 0) (jx 0) (k 0) (kk 0) (kx 0)
             (temp #C(0.0 0.0)))
        (declare (type (f2cl-lib:integer4) i info ix j jx k kk kx)
                 (type (f2cl-lib:complex8) temp))
        (setf info 0)
        (cond
         ((and (not (lsame uplo "U")) (not (lsame uplo "L"))) (setf info 1))
         ((< n 0) (setf info 2)) ((= incx 0) (setf info 5)))
        (cond ((/= info 0) (xerbla "CHPR  " info) (go end_label)))
        (if (or (= n 0) (= alpha (f2cl-lib:freal zero)))
            (go end_label))
        (cond
         ((<= incx 0)
          (setf kx
                  (f2cl-lib:int-sub 1
                                    (f2cl-lib:int-mul (f2cl-lib:int-sub n 1)
                                                      incx))))
         ((/= incx 1) (setf kx 1)))
        (setf kk 1)
        (cond
         ((lsame uplo "U")
          (cond
           ((= incx 1)
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((/= (f2cl-lib:fref x (j) ((1 *))) zero)
                  (setf temp
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref x-%data% (j) ((1 *))
                                             x-%offset%))))
                  (setf k kk)
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i
                                    (f2cl-lib:int-add j (f2cl-lib:int-sub 1)))
                                 nil)
                    (tagbody
                      (setf (f2cl-lib:fref ap-%data% (k) ((1 *)) ap-%offset%)
                              (+
                               (f2cl-lib:fref ap-%data% (k) ((1 *))
                                              ap-%offset%)
                               (*
                                (f2cl-lib:fref x-%data% (i) ((1 *)) x-%offset%)
                                temp)))
                      (setf k (f2cl-lib:int-add k 1))
                     label10))
                  (setf (f2cl-lib:fref ap-%data%
                                       ((f2cl-lib:int-sub
                                         (f2cl-lib:int-add kk j) 1))
                                       ((1 *)) ap-%offset%)
                          (coerce
                           (+
                            (f2cl-lib:freal
                             (f2cl-lib:fref ap-%data%
                                            ((f2cl-lib:int-sub
                                              (f2cl-lib:int-add kk j) 1))
                                            ((1 *)) ap-%offset%))
                            (f2cl-lib:freal
                             (* (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%)
                                temp)))
                           'f2cl-lib:complex8)))
                 (t
                  (setf (f2cl-lib:fref ap-%data%
                                       ((f2cl-lib:int-sub
                                         (f2cl-lib:int-add kk j) 1))
                                       ((1 *)) ap-%offset%)
                          (coerce
                           (f2cl-lib:freal
                            (f2cl-lib:fref ap-%data%
                                           ((f2cl-lib:int-sub
                                             (f2cl-lib:int-add kk j) 1))
                                           ((1 *)) ap-%offset%))
                           'f2cl-lib:complex8))))
                (setf kk (f2cl-lib:int-add kk j))
               label20)))
           (t (setf jx kx)
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((/= (f2cl-lib:fref x (jx) ((1 *))) zero)
                  (setf temp
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref x-%data% (jx) ((1 *))
                                             x-%offset%))))
                  (setf ix kx)
                  (f2cl-lib:fdo (k kk (f2cl-lib:int-add k 1))
                                ((> k
                                    (f2cl-lib:int-add kk j
                                                      (f2cl-lib:int-sub 2)))
                                 nil)
                    (tagbody
                      (setf (f2cl-lib:fref ap-%data% (k) ((1 *)) ap-%offset%)
                              (+
                               (f2cl-lib:fref ap-%data% (k) ((1 *))
                                              ap-%offset%)
                               (*
                                (f2cl-lib:fref x-%data% (ix) ((1 *))
                                               x-%offset%)
                                temp)))
                      (setf ix (f2cl-lib:int-add ix incx))
                     label30))
                  (setf (f2cl-lib:fref ap-%data%
                                       ((f2cl-lib:int-sub
                                         (f2cl-lib:int-add kk j) 1))
                                       ((1 *)) ap-%offset%)
                          (coerce
                           (+
                            (f2cl-lib:freal
                             (f2cl-lib:fref ap-%data%
                                            ((f2cl-lib:int-sub
                                              (f2cl-lib:int-add kk j) 1))
                                            ((1 *)) ap-%offset%))
                            (f2cl-lib:freal
                             (*
                              (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%)
                              temp)))
                           'f2cl-lib:complex8)))
                 (t
                  (setf (f2cl-lib:fref ap-%data%
                                       ((f2cl-lib:int-sub
                                         (f2cl-lib:int-add kk j) 1))
                                       ((1 *)) ap-%offset%)
                          (coerce
                           (f2cl-lib:freal
                            (f2cl-lib:fref ap-%data%
                                           ((f2cl-lib:int-sub
                                             (f2cl-lib:int-add kk j) 1))
                                           ((1 *)) ap-%offset%))
                           'f2cl-lib:complex8))))
                (setf jx (f2cl-lib:int-add jx incx))
                (setf kk (f2cl-lib:int-add kk j))
               label40)))))
         (t
          (cond
           ((= incx 1)
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((/= (f2cl-lib:fref x (j) ((1 *))) zero)
                  (setf temp
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref x-%data% (j) ((1 *))
                                             x-%offset%))))
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (+
                            (f2cl-lib:freal
                             (f2cl-lib:fref ap-%data% (kk) ((1 *))
                                            ap-%offset%))
                            (f2cl-lib:freal
                             (* temp
                                (f2cl-lib:fref x-%data% (j) ((1 *))
                                               x-%offset%))))
                           'f2cl-lib:complex8))
                  (setf k (f2cl-lib:int-add kk 1))
                  (f2cl-lib:fdo (i (f2cl-lib:int-add j 1)
                                 (f2cl-lib:int-add i 1))
                                ((> i n) nil)
                    (tagbody
                      (setf (f2cl-lib:fref ap-%data% (k) ((1 *)) ap-%offset%)
                              (+
                               (f2cl-lib:fref ap-%data% (k) ((1 *))
                                              ap-%offset%)
                               (*
                                (f2cl-lib:fref x-%data% (i) ((1 *)) x-%offset%)
                                temp)))
                      (setf k (f2cl-lib:int-add k 1))
                     label50)))
                 (t
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (f2cl-lib:freal
                            (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%))
                           'f2cl-lib:complex8))))
                (setf kk
                        (f2cl-lib:int-add
                         (f2cl-lib:int-sub (f2cl-lib:int-add kk n) j) 1))
               label60)))
           (t (setf jx kx)
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((/= (f2cl-lib:fref x (jx) ((1 *))) zero)
                  (setf temp
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref x-%data% (jx) ((1 *))
                                             x-%offset%))))
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (+
                            (f2cl-lib:freal
                             (f2cl-lib:fref ap-%data% (kk) ((1 *))
                                            ap-%offset%))
                            (f2cl-lib:freal
                             (* temp
                                (f2cl-lib:fref x-%data% (jx) ((1 *))
                                               x-%offset%))))
                           'f2cl-lib:complex8))
                  (setf ix jx)
                  (f2cl-lib:fdo (k (f2cl-lib:int-add kk 1)
                                 (f2cl-lib:int-add k 1))
                                ((> k
                                    (f2cl-lib:int-add kk n
                                                      (f2cl-lib:int-sub j)))
                                 nil)
                    (tagbody
                      (setf ix (f2cl-lib:int-add ix incx))
                      (setf (f2cl-lib:fref ap-%data% (k) ((1 *)) ap-%offset%)
                              (+
                               (f2cl-lib:fref ap-%data% (k) ((1 *))
                                              ap-%offset%)
                               (*
                                (f2cl-lib:fref x-%data% (ix) ((1 *))
                                               x-%offset%)
                                temp)))
                     label70)))
                 (t
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (f2cl-lib:freal
                            (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%))
                           'f2cl-lib:complex8))))
                (setf jx (f2cl-lib:int-add jx incx))
                (setf kk
                        (f2cl-lib:int-add
                         (f2cl-lib:int-sub (f2cl-lib:int-add kk n) j) 1))
               label80))))))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::chpr fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((string 1)
                                              (fortran-to-lisp::integer4)
                                              (single-float)
                                              (array fortran-to-lisp::complex8
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex8
                                               (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil) :calls
                                            '(fortran-to-lisp::xerbla
                                              fortran-to-lisp::lsame))))

