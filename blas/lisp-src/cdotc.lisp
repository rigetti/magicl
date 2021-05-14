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
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))

(in-package :magicl.lisp-blas)


(defun cdotc (n cx incx cy incy)
  (declare (type (array f2cl-lib:complex8 (*)) cy cx)
           (type (f2cl-lib:integer4) incy incx n))
  (f2cl-lib:with-multi-array-data
      ((cx f2cl-lib:complex8 cx-%data% cx-%offset%)
       (cy f2cl-lib:complex8 cy-%data% cy-%offset%))
    (prog ((i 0) (ix 0) (iy 0) (ctemp #C(0.0 0.0)) (cdotc #C(0.0 0.0)))
      (declare (type (complex) cdotc)
               (type (f2cl-lib:complex8) ctemp)
               (type (f2cl-lib:integer4) iy ix i))
      (setf ctemp (f2cl-lib:cmplx 0.0 0.0))
      (setf cdotc (f2cl-lib:cmplx 0.0 0.0))
      (if (<= n 0)
          (go end_label))
      (cond
       ((and (= incx 1) (= incy 1))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i n) nil)
          (tagbody
            (setf ctemp
                    (+ ctemp
                       (*
                        (f2cl-lib:conjg
                         (f2cl-lib:fref cx-%data% (i) ((1 *)) cx-%offset%))
                        (f2cl-lib:fref cy-%data% (i) ((1 *)) cy-%offset%))))
           label100000)))
       (t (setf ix 1) (setf iy 1)
        (if (< incx 0)
            (setf ix
                    (f2cl-lib:int-add
                     (f2cl-lib:int-mul (f2cl-lib:int-sub 1 n) incx) 1)))
        (if (< incy 0)
            (setf iy
                    (f2cl-lib:int-add
                     (f2cl-lib:int-mul (f2cl-lib:int-sub 1 n) incy) 1)))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i n) nil)
          (tagbody
            (setf ctemp
                    (+ ctemp
                       (*
                        (f2cl-lib:conjg
                         (f2cl-lib:fref cx-%data% (ix) ((1 *)) cx-%offset%))
                        (f2cl-lib:fref cy-%data% (iy) ((1 *)) cy-%offset%))))
            (setf ix (f2cl-lib:int-add ix incx))
            (setf iy (f2cl-lib:int-add iy incy))
           label100001))))
      (setf cdotc ctemp)
      (go end_label)
     end_label
      (return (values cdotc nil nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::cdotc fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex8
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex8
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil nil) :calls
                                            'nil)))

