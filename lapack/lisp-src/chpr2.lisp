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
  (defun chpr2 (uplo n alpha x incx y incy ap)
    (declare (type (array f2cl-lib:complex8 (*)) ap y x)
             (type (f2cl-lib:complex8) alpha)
             (type (f2cl-lib:integer4) incy incx n)
             (type (string 1) uplo))
    (f2cl-lib:with-multi-array-data
        ((uplo character uplo-%data% uplo-%offset%)
         (x f2cl-lib:complex8 x-%data% x-%offset%)
         (y f2cl-lib:complex8 y-%data% y-%offset%)
         (ap f2cl-lib:complex8 ap-%data% ap-%offset%))
      (prog ((i 0) (info 0) (ix 0) (iy 0) (j 0) (jx 0) (jy 0) (k 0) (kk 0)
             (kx 0) (ky 0) (temp1 #C(0.0 0.0)) (temp2 #C(0.0 0.0)))
        (declare (type (f2cl-lib:integer4) i info ix iy j jx jy k kk kx ky)
                 (type (f2cl-lib:complex8) temp1 temp2))
        (setf info 0)
        (cond
         ((and (not (lsame uplo "U")) (not (lsame uplo "L"))) (setf info 1))
         ((< n 0) (setf info 2)) ((= incx 0) (setf info 5))
         ((= incy 0) (setf info 7)))
        (cond ((/= info 0) (xerbla "CHPR2 " info) (go end_label)))
        (if (or (= n 0) (= alpha zero))
            (go end_label))
        (cond
         ((or (/= incx 1) (/= incy 1))
          (cond ((> incx 0) (setf kx 1))
                (t
                 (setf kx
                         (f2cl-lib:int-sub 1
                                           (f2cl-lib:int-mul
                                            (f2cl-lib:int-sub n 1) incx)))))
          (cond ((> incy 0) (setf ky 1))
                (t
                 (setf ky
                         (f2cl-lib:int-sub 1
                                           (f2cl-lib:int-mul
                                            (f2cl-lib:int-sub n 1) incy)))))
          (setf jx kx) (setf jy ky)))
        (setf kk 1)
        (cond
         ((lsame uplo "U")
          (cond
           ((and (= incx 1) (= incy 1))
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((or (/= (f2cl-lib:fref x (j) ((1 *))) zero)
                      (/= (f2cl-lib:fref y (j) ((1 *))) zero))
                  (setf temp1
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref y-%data% (j) ((1 *))
                                             y-%offset%))))
                  (setf temp2
                          (f2cl-lib:conjg
                           (* alpha
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
                                temp1)
                               (*
                                (f2cl-lib:fref y-%data% (i) ((1 *)) y-%offset%)
                                temp2)))
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
                             (+
                              (*
                               (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%)
                               temp1)
                              (*
                               (f2cl-lib:fref y-%data% (j) ((1 *)) y-%offset%)
                               temp2))))
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
           (t
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((or (/= (f2cl-lib:fref x (jx) ((1 *))) zero)
                      (/= (f2cl-lib:fref y (jy) ((1 *))) zero))
                  (setf temp1
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref y-%data% (jy) ((1 *))
                                             y-%offset%))))
                  (setf temp2
                          (f2cl-lib:conjg
                           (* alpha
                              (f2cl-lib:fref x-%data% (jx) ((1 *))
                                             x-%offset%))))
                  (setf ix kx) (setf iy ky)
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
                                temp1)
                               (*
                                (f2cl-lib:fref y-%data% (iy) ((1 *))
                                               y-%offset%)
                                temp2)))
                      (setf ix (f2cl-lib:int-add ix incx))
                      (setf iy (f2cl-lib:int-add iy incy))
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
                             (+
                              (*
                               (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%)
                               temp1)
                              (*
                               (f2cl-lib:fref y-%data% (jy) ((1 *)) y-%offset%)
                               temp2))))
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
                (setf jy (f2cl-lib:int-add jy incy))
                (setf kk (f2cl-lib:int-add kk j))
               label40)))))
         (t
          (cond
           ((and (= incx 1) (= incy 1))
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((or (/= (f2cl-lib:fref x (j) ((1 *))) zero)
                      (/= (f2cl-lib:fref y (j) ((1 *))) zero))
                  (setf temp1
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref y-%data% (j) ((1 *))
                                             y-%offset%))))
                  (setf temp2
                          (f2cl-lib:conjg
                           (* alpha
                              (f2cl-lib:fref x-%data% (j) ((1 *))
                                             x-%offset%))))
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (+
                            (f2cl-lib:freal
                             (f2cl-lib:fref ap-%data% (kk) ((1 *))
                                            ap-%offset%))
                            (f2cl-lib:freal
                             (+
                              (*
                               (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%)
                               temp1)
                              (*
                               (f2cl-lib:fref y-%data% (j) ((1 *)) y-%offset%)
                               temp2))))
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
                                temp1)
                               (*
                                (f2cl-lib:fref y-%data% (i) ((1 *)) y-%offset%)
                                temp2)))
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
           (t
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j n) nil)
              (tagbody
                (cond
                 ((or (/= (f2cl-lib:fref x (jx) ((1 *))) zero)
                      (/= (f2cl-lib:fref y (jy) ((1 *))) zero))
                  (setf temp1
                          (* alpha
                             (f2cl-lib:conjg
                              (f2cl-lib:fref y-%data% (jy) ((1 *))
                                             y-%offset%))))
                  (setf temp2
                          (f2cl-lib:conjg
                           (* alpha
                              (f2cl-lib:fref x-%data% (jx) ((1 *))
                                             x-%offset%))))
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (+
                            (f2cl-lib:freal
                             (f2cl-lib:fref ap-%data% (kk) ((1 *))
                                            ap-%offset%))
                            (f2cl-lib:freal
                             (+
                              (*
                               (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%)
                               temp1)
                              (*
                               (f2cl-lib:fref y-%data% (jy) ((1 *)) y-%offset%)
                               temp2))))
                           'f2cl-lib:complex8))
                  (setf ix jx) (setf iy jy)
                  (f2cl-lib:fdo (k (f2cl-lib:int-add kk 1)
                                 (f2cl-lib:int-add k 1))
                                ((> k
                                    (f2cl-lib:int-add kk n
                                                      (f2cl-lib:int-sub j)))
                                 nil)
                    (tagbody
                      (setf ix (f2cl-lib:int-add ix incx))
                      (setf iy (f2cl-lib:int-add iy incy))
                      (setf (f2cl-lib:fref ap-%data% (k) ((1 *)) ap-%offset%)
                              (+
                               (f2cl-lib:fref ap-%data% (k) ((1 *))
                                              ap-%offset%)
                               (*
                                (f2cl-lib:fref x-%data% (ix) ((1 *))
                                               x-%offset%)
                                temp1)
                               (*
                                (f2cl-lib:fref y-%data% (iy) ((1 *))
                                               y-%offset%)
                                temp2)))
                     label70)))
                 (t
                  (setf (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%)
                          (coerce
                           (f2cl-lib:freal
                            (f2cl-lib:fref ap-%data% (kk) ((1 *)) ap-%offset%))
                           'f2cl-lib:complex8))))
                (setf jx (f2cl-lib:int-add jx incx))
                (setf jy (f2cl-lib:int-add jy incy))
                (setf kk
                        (f2cl-lib:int-add
                         (f2cl-lib:int-sub (f2cl-lib:int-add kk n) j) 1))
               label80))))))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::chpr2 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((string 1)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::complex8)
                                              (array fortran-to-lisp::complex8
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex8
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex8
                                               (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil nil nil)
                                            :calls
                                            '(fortran-to-lisp::xerbla
                                              fortran-to-lisp::lsame))))

