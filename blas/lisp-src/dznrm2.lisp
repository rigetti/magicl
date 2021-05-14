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


(let* ((one 1.0d0) (zero 0.0d0))
  (declare (type (double-float 1.0d0 1.0d0) one)
           (type (double-float 0.0d0 0.0d0) zero)
           (ignorable one zero))
  (defun dznrm2 (n x incx)
    (declare (type (array f2cl-lib:complex16 (*)) x)
             (type (f2cl-lib:integer4) incx n))
    (f2cl-lib:with-multi-array-data
        ((x f2cl-lib:complex16 x-%data% x-%offset%))
      (prog ((ix 0) (norm 0.0d0) (scale 0.0d0) (ssq 0.0d0) (temp 0.0d0)
             (dznrm2 0.0d0))
        (declare (type (f2cl-lib:integer4) ix)
                 (type (double-float) norm scale ssq temp dznrm2))
        (cond ((or (< n 1) (< incx 1)) (setf norm zero))
              (t (setf scale zero) (setf ssq one)
               (f2cl-lib:fdo (ix 1 (f2cl-lib:int-add ix incx))
                             ((> ix
                                 (f2cl-lib:int-add 1
                                                   (f2cl-lib:int-mul
                                                    (f2cl-lib:int-add n
                                                                      (f2cl-lib:int-sub
                                                                       1))
                                                    incx)))
                              nil)
                 (tagbody
                   (cond
                    ((/= (f2cl-lib:dble (f2cl-lib:fref x (ix) ((1 *)))) zero)
                     (setf temp
                             (abs
                              (f2cl-lib:dble
                               (f2cl-lib:fref x-%data% (ix) ((1 *))
                                              x-%offset%))))
                     (cond
                      ((< scale temp)
                       (setf ssq (+ one (* ssq (expt (/ scale temp) 2))))
                       (setf scale temp))
                      (t (setf ssq (+ ssq (expt (/ temp scale) 2)))))))
                   (cond
                    ((/= (f2cl-lib:dimag (f2cl-lib:fref x (ix) ((1 *)))) zero)
                     (setf temp
                             (abs
                              (f2cl-lib:dimag
                               (f2cl-lib:fref x-%data% (ix) ((1 *))
                                              x-%offset%))))
                     (cond
                      ((< scale temp)
                       (setf ssq (+ one (* ssq (expt (/ scale temp) 2))))
                       (setf scale temp))
                      (t (setf ssq (+ ssq (expt (/ temp scale) 2)))))))
                  label10))
               (setf norm (* scale (f2cl-lib:fsqrt ssq)))))
        (setf dznrm2 norm)
        (go end_label)
       end_label
        (return (values dznrm2 nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dznrm2
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values '(nil nil nil)
                                            :calls 'nil)))

