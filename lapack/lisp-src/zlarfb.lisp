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


(let* ((one (f2cl-lib:cmplx 1.0d0 0.0d0)))
  (declare (type (f2cl-lib:complex16) one)
           (ignorable one))
  (defun zlarfb (side trans direct storev m n k v ldv t$ ldt c ldc work ldwork)
    (declare (type (array f2cl-lib:complex16 (*)) work c t$ v)
             (type (f2cl-lib:integer4) ldwork ldc ldt ldv k n m)
             (type (string 1) storev direct trans side))
    (f2cl-lib:with-multi-array-data
        ((side character side-%data% side-%offset%)
         (trans character trans-%data% trans-%offset%)
         (direct character direct-%data% direct-%offset%)
         (storev character storev-%data% storev-%offset%)
         (v f2cl-lib:complex16 v-%data% v-%offset%)
         (t$ f2cl-lib:complex16 t$-%data% t$-%offset%)
         (c f2cl-lib:complex16 c-%data% c-%offset%)
         (work f2cl-lib:complex16 work-%data% work-%offset%))
      (prog ((i 0) (j 0) (lastv 0) (lastc 0)
             (transt
              (make-array '(1) :element-type 'character :initial-element #\ )))
        (declare (type (f2cl-lib:integer4) i j lastv lastc)
                 (type (string 1) transt))
        (if (or (<= m 0) (<= n 0))
            (go end_label))
        (cond
         ((lsame trans "N") (f2cl-lib:f2cl-set-string transt "C" (string 1)))
         (t (f2cl-lib:f2cl-set-string transt "N" (string 1))))
        (cond
         ((lsame storev "C")
          (cond
           ((lsame direct "F")
            (cond
             ((lsame side "L")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlr m k v ldv))))
              (setf lastc (ilazlc lastv n c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 (j 1)
                                         ((1 ldc) (1 *)) c-%offset%)
                   ldc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                  (zlacgv lastc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label10))
              (ztrmm "R" "L" "N" "U" lastc k one v ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "C" "N" lastc k (f2cl-lib:int-sub lastv k) one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv one work ldwork)))
              (ztrmm "R" "U" transt "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> m k)
                (zgemm "N" "C" (f2cl-lib:int-sub lastv k) lastc k (- one)
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv work ldwork one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc)))
              (ztrmm "R" "L" "C" "U" lastc k one v ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data% (j i) ((1 ldc) (1 *))
                                           c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data% (j i) ((1 ldc) (1 *))
                                              c-%offset%)
                               (f2cl-lib:dconjg
                                (f2cl-lib:fref work-%data% (i j)
                                               ((1 ldwork) (1 *))
                                               work-%offset%))))
                     label20))
                 label30)))
             ((lsame side "R")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlr n k v ldv))))
              (setf lastc (ilazlr m lastv c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldc) (1 *)) c-%offset%)
                   1
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label40))
              (ztrmm "R" "L" "N" "U" lastc k one v ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "N" lastc k (f2cl-lib:int-sub lastv k) one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv one work ldwork)))
              (ztrmm "R" "U" trans "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "C" lastc (f2cl-lib:int-sub lastv k) k (- one) work
                 ldwork
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc)))
              (ztrmm "R" "L" "C" "U" lastc k one v ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data% (i j) ((1 ldc) (1 *))
                                           c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data% (i j) ((1 ldc) (1 *))
                                              c-%offset%)
                               (f2cl-lib:fref work-%data% (i j)
                                              ((1 ldwork) (1 *))
                                              work-%offset%)))
                     label50))
                 label60)))))
           (t
            (cond
             ((lsame side "L")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlr m k v ldv))))
              (setf lastc (ilazlc lastv n c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                         ((+ lastv (f2cl-lib:int-sub k) j) 1)
                                         ((1 ldc) (1 *)) c-%offset%)
                   ldc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                  (zlacgv lastc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label70))
              (ztrmm "R" "U" "N" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     ((+ lastv (f2cl-lib:int-sub k) 1) 1)
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "C" "N" lastc k (f2cl-lib:int-sub lastv k) one c ldc v
                 ldv one work ldwork)))
              (ztrmm "R" "L" transt "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "C" (f2cl-lib:int-sub lastv k) lastc k (- one) v ldv
                 work ldwork one c ldc)))
              (ztrmm "R" "U" "C" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     ((+ lastv (f2cl-lib:int-sub k) 1) 1)
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data%
                                           ((f2cl-lib:int-add
                                             (f2cl-lib:int-sub lastv k) j)
                                            i)
                                           ((1 ldc) (1 *)) c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data%
                                              ((f2cl-lib:int-add
                                                (f2cl-lib:int-sub lastv k) j)
                                               i)
                                              ((1 ldc) (1 *)) c-%offset%)
                               (f2cl-lib:dconjg
                                (f2cl-lib:fref work-%data% (i j)
                                               ((1 ldwork) (1 *))
                                               work-%offset%))))
                     label80))
                 label90)))
             ((lsame side "R")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlr n k v ldv))))
              (setf lastc (ilazlr m lastv c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                         (1
                                          (f2cl-lib:int-add
                                           (f2cl-lib:int-sub lastv k) j))
                                         ((1 ldc) (1 *)) c-%offset%)
                   1
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label100))
              (ztrmm "R" "U" "N" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     ((+ lastv (f2cl-lib:int-sub k) 1) 1)
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "N" lastc k (f2cl-lib:int-sub lastv k) one c ldc v
                 ldv one work ldwork)))
              (ztrmm "R" "L" trans "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "C" lastc (f2cl-lib:int-sub lastv k) k (- one) work
                 ldwork v ldv one c ldc)))
              (ztrmm "R" "U" "C" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     ((+ lastv (f2cl-lib:int-sub k) 1) 1)
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data%
                                           (i
                                            (f2cl-lib:int-add
                                             (f2cl-lib:int-sub lastv k) j))
                                           ((1 ldc) (1 *)) c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data%
                                              (i
                                               (f2cl-lib:int-add
                                                (f2cl-lib:int-sub lastv k) j))
                                              ((1 ldc) (1 *)) c-%offset%)
                               (f2cl-lib:fref work-%data% (i j)
                                              ((1 ldwork) (1 *))
                                              work-%offset%)))
                     label110))
                 label120)))))))
         ((lsame storev "R")
          (cond
           ((lsame direct "F")
            (cond
             ((lsame side "L")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlc k m v ldv))))
              (setf lastc (ilazlc lastv n c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 (j 1)
                                         ((1 ldc) (1 *)) c-%offset%)
                   ldc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                  (zlacgv lastc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label130))
              (ztrmm "R" "U" "C" "U" lastc k one v ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "C" "C" lastc k (f2cl-lib:int-sub lastv k) one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv one work ldwork)))
              (ztrmm "R" "U" transt "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "C" "C" (f2cl-lib:int-sub lastv k) lastc k (- one)
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv work ldwork one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc)))
              (ztrmm "R" "U" "N" "U" lastc k one v ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data% (j i) ((1 ldc) (1 *))
                                           c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data% (j i) ((1 ldc) (1 *))
                                              c-%offset%)
                               (f2cl-lib:dconjg
                                (f2cl-lib:fref work-%data% (i j)
                                               ((1 ldwork) (1 *))
                                               work-%offset%))))
                     label140))
                 label150)))
             ((lsame side "R")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlc k n v ldv))))
              (setf lastc (ilazlr m lastv c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldc) (1 *)) c-%offset%)
                   1
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label160))
              (ztrmm "R" "U" "C" "U" lastc k one v ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "C" lastc k (f2cl-lib:int-sub lastv k) one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv one work ldwork)))
              (ztrmm "R" "U" trans "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "N" lastc (f2cl-lib:int-sub lastv k) k (- one) work
                 ldwork
                 (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldv) (1 *)) v-%offset%)
                 ldv one
                 (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                       (1 (f2cl-lib:int-add k 1))
                                       ((1 ldc) (1 *)) c-%offset%)
                 ldc)))
              (ztrmm "R" "U" "N" "U" lastc k one v ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data% (i j) ((1 ldc) (1 *))
                                           c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data% (i j) ((1 ldc) (1 *))
                                              c-%offset%)
                               (f2cl-lib:fref work-%data% (i j)
                                              ((1 ldwork) (1 *))
                                              work-%offset%)))
                     label170))
                 label180)))))
           (t
            (cond
             ((lsame side "L")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlc k m v ldv))))
              (setf lastc (ilazlc lastv n c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                         ((+ lastv (f2cl-lib:int-sub k) j) 1)
                                         ((1 ldc) (1 *)) c-%offset%)
                   ldc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                  (zlacgv lastc
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label190))
              (ztrmm "R" "L" "C" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     (1
                                      (f2cl-lib:int-add
                                       (f2cl-lib:int-sub lastv k) 1))
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "C" "C" lastc k (f2cl-lib:int-sub lastv k) one c ldc v
                 ldv one work ldwork)))
              (ztrmm "R" "L" transt "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "C" "C" (f2cl-lib:int-sub lastv k) lastc k (- one) v ldv
                 work ldwork one c ldc)))
              (ztrmm "R" "L" "N" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     (1
                                      (f2cl-lib:int-add
                                       (f2cl-lib:int-sub lastv k) 1))
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data%
                                           ((f2cl-lib:int-add
                                             (f2cl-lib:int-sub lastv k) j)
                                            i)
                                           ((1 ldc) (1 *)) c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data%
                                              ((f2cl-lib:int-add
                                                (f2cl-lib:int-sub lastv k) j)
                                               i)
                                              ((1 ldc) (1 *)) c-%offset%)
                               (f2cl-lib:dconjg
                                (f2cl-lib:fref work-%data% (i j)
                                               ((1 ldwork) (1 *))
                                               work-%offset%))))
                     label200))
                 label210)))
             ((lsame side "R")
              (setf lastv
                      (max (the f2cl-lib:integer4 k)
                           (the f2cl-lib:integer4 (ilazlc k n v ldv))))
              (setf lastc (ilazlr m lastv c ldc))
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (zcopy lastc
                   (f2cl-lib:array-slice c-%data% f2cl-lib:complex16
                                         (1
                                          (f2cl-lib:int-add
                                           (f2cl-lib:int-sub lastv k) j))
                                         ((1 ldc) (1 *)) c-%offset%)
                   1
                   (f2cl-lib:array-slice work-%data% f2cl-lib:complex16 (1 j)
                                         ((1 ldwork) (1 *)) work-%offset%)
                   1)
                 label220))
              (ztrmm "R" "L" "C" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     (1
                                      (f2cl-lib:int-add
                                       (f2cl-lib:int-sub lastv k) 1))
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "C" lastc k (f2cl-lib:int-sub lastv k) one c ldc v
                 ldv one work ldwork)))
              (ztrmm "R" "L" trans "N" lastc k one t$ ldt work ldwork)
              (cond
               ((> lastv k)
                (zgemm "N" "N" lastc (f2cl-lib:int-sub lastv k) k (- one) work
                 ldwork v ldv one c ldc)))
              (ztrmm "R" "L" "N" "U" lastc k one
               (f2cl-lib:array-slice v-%data% f2cl-lib:complex16
                                     (1
                                      (f2cl-lib:int-add
                                       (f2cl-lib:int-sub lastv k) 1))
                                     ((1 ldv) (1 *)) v-%offset%)
               ldv work ldwork)
              (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                            ((> j k) nil)
                (tagbody
                  (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                ((> i lastc) nil)
                    (tagbody
                      (setf (f2cl-lib:fref c-%data%
                                           (i
                                            (f2cl-lib:int-add
                                             (f2cl-lib:int-sub lastv k) j))
                                           ((1 ldc) (1 *)) c-%offset%)
                              (-
                               (f2cl-lib:fref c-%data%
                                              (i
                                               (f2cl-lib:int-add
                                                (f2cl-lib:int-sub lastv k) j))
                                              ((1 ldc) (1 *)) c-%offset%)
                               (f2cl-lib:fref work-%data% (i j)
                                              ((1 ldwork) (1 *))
                                              work-%offset%)))
                     label230))
                 label240))))))))
        (go end_label)
       end_label
        (return
         (values nil nil nil nil nil nil nil nil nil nil nil nil nil nil
                 nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zlarfb
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((string 1) (string 1) (string 1)
                                              (string 1)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil nil nil nil nil
                                              nil nil nil nil nil nil nil)
                                            :calls
                                            '(fortran-to-lisp::zgemm
                                              fortran-to-lisp::ztrmm
                                              fortran-to-lisp::zcopy
                                              fortran-to-lisp::lsame
                                              fortran-to-lisp::zlacgv
                                              fortran-to-lisp::ilazlc
                                              fortran-to-lisp::ilazlr))))

