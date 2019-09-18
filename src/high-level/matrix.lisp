;;;; matrix.lisp
;;;;
;;;; Author: Cole Scott
;;;;         Robert Smith

(in-package #:magicl)

(deftype matrix-storage (&optional type)
  `(simple-array ,type (*)))

(defclass matrix (abstract-tensor)
  (;; abstract-tensor slots
   (nrows
    :initarg :nrows
    :initform 0
    :reader nrows
    :type alexandria:positive-fixnum
    :documentation "The number of rows in the matrix")
   (ncols
    :initarg :ncols
    :initform 0
    :reader ncols
    :type alexandria:positive-fixnum
    :documentation "The number of columns in the matrix")
   (size
    :initarg :size
    :initform 0
    :reader size
    :type (alexandria:positive-fixnum)
    :documentation "Total number of elements in the matrix")
   (element-type
    :initarg :element-type
    :initform (error "element-type must be specified when creating a matrix instance") ; TODO: much better error messages
    :reader element-type
    :type type
    :documentation "The type of the elements in the matrix")
   ;; matrix-specific slots
   (storage
    :initarg :storage
    :initform (error "storage must be specified when creating a matrix instance")
    :reader storage
    :documentation "Storage of the matrix, typically in a vector in column major order")
   (order
    :initarg :order
    :initform :column-major
    :reader order
    :type (member :row-major :column-major)
    :documentation "Indexing order of storage (:column-major or :row-major)."))
  (:metaclass abstract-class:abstract-class))

(defun pprint-matrix (stream matrix)
  "Pretty-print a matrix MATRIX to the stream STREAM."
  (flet ((print-real (x)
           (format stream "~6,3f" x))
         (print-complex (z)
           (format stream "~6,3f ~:[+~;-~]~6,3fj"
                   (realpart z)
                   (minusp (imagpart z))
                   (abs (imagpart z)))))
    (let* ((rows (nrows matrix))
           (cols (ncols matrix))
           (type (element-type matrix))
           (print-entry
             (cond
               ((subtypep type 'complex) #'print-complex)
               (t #'print-real))))
      (pprint-logical-block (stream nil)
        (print-unreadable-object (matrix stream :type t)
          (format stream "~Dx~D:" rows cols)
          (dotimes (r rows)
            (pprint-newline :mandatory stream)
            (dotimes (c cols)
              (funcall print-entry (tref matrix r c))
              (unless (cl:= c (1- cols))
                (write-string "    " stream)))))))))

(set-pprint-dispatch 'matrix 'pprint-matrix)

(defgeneric square-matrix-p (matrix)
  (:documentation "Whether the given matrix is square")
  (:method ((matrix matrix))
    (cl:= (nrows matrix) (ncols matrix))))

(defgeneric identity-matrix-p (matrix &optional epsilon)
  (:documentation "Whether the given matrix is an idenity matrix")
  (:method ((matrix matrix) &optional (epsilon 0d0))
    (unless (square-matrix-p matrix) (return-from identity-matrix-p nil))
    (map-indexes (shape matrix)
                 (lambda (r c)
                   (unless (>= epsilon
                               (abs
                                (cl:- (tref matrix r c)
                                      (if (cl:= r c)
                                          1 0))))
                     (return-from identity-matrix-p nil))))
    t))

(defmacro assert-square-matrix (&rest matrices)
  `(progn
     ,@(loop :for matrix in matrices
             :collect `(assert (square-matrix-p ,matrix)
                               ()
                               ,"The shape of ~a is ~a, which is not a square" ,(symbol-name matrix) ,matrix))))

;;; Required abstract-tensor methods

(defmethod rank ((matrix matrix))
  (declare (ignore matrix))
  2)

(defmethod shape ((matrix matrix))
  (list (nrows matrix) (ncols matrix)))

(defmethod tref ((matrix matrix) &rest pos)
  ;; TODO: Check pos type
  (assert (cl:= (rank matrix) (list-length pos))
          () "Invalid index ~a. Must be rank ~a" pos (rank matrix))
  (assert (cl:every #'< pos (shape matrix))
          () "Index ~a out of range" pos)
  (let ((index (ecase (order matrix)
                 (:row-major (cl:+ (second pos) (* (first pos) (ncols matrix))))
                 (:column-major (cl:+ (first pos) (* (second pos) (nrows matrix)))))))
    (aref (storage matrix) index)))

(defmethod (setf tref) (new-value (matrix matrix) &rest pos)
       (assert (cl:= (rank matrix) (list-length pos))
               () "Invalid index ~a. Must be rank ~a" pos (rank matrix))
       (assert (cl:every #'< pos (shape matrix))
               () "Index ~a out of range" pos)
       (let ((index (ecase (order matrix)
                 (:row-major (cl:+ (second pos) (* (first pos) (ncols matrix))))
                 (:column-major (cl:+ (first pos) (* (second pos) (nrows matrix)))))))
         (setf (aref (storage matrix) index) (coerce new-value (element-type matrix)))))

(defmethod copy-tensor ((matrix matrix) &rest args)
  (apply #'make-instance (class-of matrix)
         :nrows (nrows matrix)
         :ncols (ncols matrix)
         :size (size matrix)
         :element-type (element-type matrix)
         :storage (make-array (size matrix)
                              :element-type (element-type matrix))
         args))

(defmethod deep-copy-tensor ((matrix matrix) &rest args)
  (apply #'make-instance (class-of matrix)
         :nrows (nrows matrix)
         :ncols (ncols matrix)
         :size (size matrix)
         :element-type (element-type matrix)
         :storage (alexandria:copy-array (storage matrix))
         args))

;; Specific constructors

(defgeneric random-unitary (shape &key type)
  (:documentation "Generate a uniformly random element of U(n).")
  (:method (shape &key type)
    (assert-square-shape shape)
    (multiple-value-bind (q r) (qr (rand nil nil shape :type type :distribution :normal))
      (let ((d (diag r)))
        (setf d (cl:map 'list (lambda (di) (/ di (sqrt (* di (conjugate di))))) d))
        (@ q (funcall #'from-diag d shape))))))

;;; Optimized abstract-tensor methods

;; Broken for column-major
#+ignore
(defmethod map! ((function function) (matrix matrix))
  (setf (slot-value matrix 'storage) (cl:map 'vector function (storage matrix)))
  matrix)

;; Also broken
#+ignore
(defmethod into! ((function function) (matrix matrix))
  (let ((i 0))
    (map-indexes
     (shape matrix)
     (lambda (&rest dims)
       (setf (aref (storage matrix) i) (apply function dims))
       (incf i)))
    matrix))

;;; Specfic matrix classes

(defmacro defmatrix (name type tensor-name)
  `(progn
     (defclass ,name (matrix)
       ((storage :type (matrix-storage ,type)))
       (:documentation ,(format nil "Matrix with element type of ~a" type)))
     (defmethod update-instance-for-different-class :before
         ((old ,tensor-name)
          (new ,name)
          &key)
       (assert (cl:= 2 (rank old)))
       (with-slots (shape) old
         (with-slots (nrows ncols) new
           (setf nrows (first shape)
                 ncols (second shape)))))
     (defmethod update-instance-for-different-class :before
         ((old ,name)
          (new ,tensor-name)
          &key)
       (with-slots (nrows ncols) old
         (with-slots (shape rank) new
           (setf shape (list nrows ncols)
                 rank 2))))))

;; TODO: This should be generic to abstract-tensor
(defgeneric ptr-ref (m base i j)
  (:documentation
   "Accessor method for the pointer to the element in the I-th row and J-th column of a matrix M, assuming zero indexing.")
  (:method ((m matrix) base i j)
    (let ((type (element-type m)))
      ;; TODO: make sure index is not out of range
      ;; TODO: compensate for order
      (let ((idx (column-major-index (list i j) (shape m))))
        (cond
          ((subtypep type 'single-float) (cffi:mem-aptr base :float idx))
          ((subtypep type 'double-float) (cffi:mem-aptr base :double idx))
          ((subtypep type '(complex single-float)) (cffi:mem-aptr base :float (* 2 idx)))
          ((subtypep type '(complex double-float)) (cffi:mem-aptr base :double (* 2 idx)))
          (t (error "Incompatible element type ~a." type)))))))

(defgeneric rown (matrix index)
  (:documentation "Get row vector from a matrix")) ;; TODO: view? slice?

(defgeneric column (matrix index)
  (:documentation "Get column vector from a matrix"))

(defgeneric slice (matrix rmin rmax cmin cmax)
  (:documentation "Get the subarray of M containing all elements M_IJ, where RMIN<=I<RMAX and CMIN<=J<CMAX.")
  (:method ((m matrix) rmin rmax cmin cmax)
    (assert (<= 0 rmin rmax (nrows m))
            () "Invalid row indices (~a,~a)" rmin rmax)
    (assert (<= 0 cmin cmax (ncols m))
            () "Invalid column indices (~a,~a)" cmin cmax)
    (let* ((target-rows (cl:- rmax rmin))
           (target-cols (cl:- cmax cmin))
           (target (empty (list target-rows target-cols)
                          :type (element-type m))))
      (loop :for i :below target-rows
            :do (loop :for j :below target-cols
                      :do (setf (tref target i j)
                                (tref m (cl:+ rmin i) (cl:+ cmin j)))))
      target)))

;; Methods to be specified by the specific matrix classes (maybe)
(defgeneric mult (a b &key target alpha beta transa transb)
    (:documentation "Multiply matrix a by matrix b, storing in target or creating a new matrix if target is not specified.
Target cannot be the same as a or b."))

(defgeneric @ (matrix &rest matrices)
    (:documentation "Multiplication of matrices")
  (:method (matrix &rest matrices)
    (reduce #'mult matrices
            :initial-value matrix)))

;;; Generic matrix methods

(defgeneric direct-sum (a b)
  (:method ((a matrix) (b matrix))
    "Compute the direct sum of A and B."
    (let* ((arows (nrows a))
           (acols (ncols a))
           (brows (nrows b))
           (bcols (ncols b))
           (rrows (cl:+ arows brows))
           (rcols (cl:+ acols bcols))
           (result (magicl:empty (list rrows rcols)
                                 :type '(complex double-float))))
      (loop :for r :below arows :do
        (loop :for c :below acols :do
          (setf (tref result r c) (tref a r c))))
      (loop :for r :from arows :below rrows :do
        (loop :for c :from acols :below rcols :do
          (setf (tref result r c) (tref b (cl:- r arows) (cl:- c acols)))))
      result)))

(defgeneric kron (a b &rest rest)
  (:documentation "Compute the kronecker product of two matrices")
  (:method (a b &rest rest)
    (let ((ma (nrows a))
        (mb (nrows b))
        (na (ncols a))
        (nb (ncols b)))
    (flet ((calc-i-j (i j) (* (tref a (floor i mb) (floor j nb))
                              (tref b (mod i mb) (mod j nb)))))
      (reduce #'kron rest :initial-value (into! #'calc-i-j
                                                (empty (list (* ma mb) (* na nb))
                                                       :type '(complex double-float))))))))

(defgeneric transpose! (matrix &key fast)
  (:documentation "Transpose a matrix!")
  (:method ((matrix matrix) &key fast)
    "Transpose a matrix by copying values.
If fast is t then just change order. Fast can cause problems when you want to multiply specifying transpose."
    (if fast
        (progn
          (let ((shape (shape matrix)))
            (setf (slot-value matrix 'ncols) (first shape))
            (setf (slot-value matrix 'nrows) (second shape))
            (setf (slot-value matrix 'order) (case (order matrix)
                                               (:row-major :column-major)
                                               (:column-major :row-major)))))
        (let ((index-function
                (ecase (order matrix)
                  (:row-major #'row-major-index)
                  (:column-major #'column-major-index))))
          (loop :for row :below (nrows matrix)
                :do (loop :for col :from row :below (ncols matrix)
                          :do (rotatef
                               (aref (storage matrix) (funcall index-function (list row col) (shape matrix)))
                               (aref (storage matrix) (funcall index-function (list col row) (shape matrix))))))
          (setf (slot-value matrix 'ncols) (first (shape matrix)))
          (setf (slot-value matrix 'nrows) (second (shape matrix)))))
    matrix))

(defgeneric transpose (matrix)
  (:documentation "Create a matrix with the transpose of the input")
  (:method ((matrix matrix))
    "Transpose a matrix by copying values.
If fast is t then just change order. Fast can cause problems when you want to multiply specifying transpose."
    (let ((new-matrix (copy-tensor matrix)))
      (let ((index-function
              (ecase (order matrix)
                (:row-major #'row-major-index)
                (:column-major #'column-major-index))))
        (loop :for row :below (nrows matrix)
              :do(loop :for col :from row :below (ncols matrix)
                        :do (let ((index1 (funcall index-function (list row col) (shape matrix)))
                                  (index2 (funcall index-function (list col row) (shape matrix))))
                              (setf (aref (storage new-matrix) index2) (aref (storage matrix) index1)
                                    (aref (storage new-matrix) index1) (aref (storage matrix) index2)))))
        (setf (slot-value matrix 'ncols) (first (shape matrix)))
        (setf (slot-value matrix 'nrows) (second (shape matrix))))
      new-matrix)))


(defgeneric diag (matrix)
  (:documentation "Get a list of the diagonal elements of a matrix")
  (:method ((matrix matrix))
    (assert-square-matrix matrix)
    (let ((rows (nrows matrix)))
      (loop :for i :below rows
            :collect (tref matrix i i)))))

(defgeneric inverse (matrix)
  (:documentation "Get the inverse of the matrix"))

(defgeneric trace (matrix)
  (:documentation "Get the trace of the matrix (product of diagonals)")
  (:method ((matrix matrix))
    (assert-square-matrix matrix)
    (let ((rows (nrows matrix)))
      (loop :for i :below rows
            :sum (tref matrix i i)))))

(defgeneric det (matrix)
  (:documentation "Compute the determinant of a square matrix")
  (:method ((matrix matrix))
    (assert-square-matrix matrix)
    (let ((d 1))
      (multiple-value-bind (a ipiv) (lu matrix)
        (dotimes (i (nrows matrix))
          (setq d (* d (tref a i i))))
        (dotimes (i (size ipiv))
          (unless (cl:= (1+ i) (tref ipiv i))
            (setq d (cl:- d))))
        d))))

(defgeneric upper-triangular (matrix &optional order)
  (:documentation "Get the upper triangular portion of the matrix")
  (:method ((matrix matrix) &optional (order (ncols matrix)))
    (let ((m (nrows matrix))
          (n (ncols matrix)))
      (assert (<= order (max (nrows matrix) (ncols matrix))) () "ORDER, given as ~D, is greater than the maximum dimension of A, ~D." order (max m n))
      (let ((target (empty (list order order) :order (order matrix) :type (element-type matrix))))
        (if (> m n)
            (loop for i from 0 to (1- order)
                  do (loop for j from (max 0 (cl:+ (cl:- n order) i)) to (1- n)
                           do (setf (tref target i (cl:+ j (cl:- order n))) (tref matrix i j))))
            (loop for j from (cl:- n order) to (1- n)
                  do (loop for i from 0 to (min (cl:+ (cl:- order n) j) (1- m))
                           do (setf (tref target i (cl:- j (cl:- n order))) (tref matrix i j)))))
        target))))

(defgeneric lower-triangular (matrix &optional order)
  (:documentation "Get the lower triangular portion of the matrix")
  (:method ((matrix matrix) &optional (order (ncols matrix)))
    (let ((m (nrows matrix))
          (n (ncols matrix)))
      (assert (<= order (max (nrows matrix) (ncols matrix))) () "ORDER, given as ~D, is greater than the maximum dimension of A, ~D." order (max m n))
      (let ((target (empty (list order order) :order (order matrix) :type (element-type matrix))))
        (if (> m n)
            (loop for i from (cl:- m order) to (1- m)
                  do (loop for j from 0 to (min (+ (cl:- order m) i) (1- n))
                           do (setf (tref target (cl:- i (cl:- m order)) j) (tref matrix i j))))
            (loop for j from 0 to (1- order)
                  do (loop for i from (max 0 (cl:+ (cl:- m order) j)) to (1- m)
                           do (setf (tref target (cl:+ i (cl:- order m)) j) (tref matrix i j)))))
        target)))))))

;; TODO: this only makes sense on complex matrices. Only define for complex matrices?
(defgeneric conjugate-transpose (matrix)
  (:documentation "Compute the conjugate transpose of a matrix")
  (:method ((matrix matrix))
    (map #'conjugate (transpose matrix))))

(defgeneric conjugate-transpose! (matrix)
  (:documentation "Compute the conjugate transpose of a matrix, replacing the elements")
  (:method ((matrix matrix))
    (map! #'conjugate (transpose! matrix))))

(defgeneric dagger (matrix)
  (:documentation "Compute the conjugate transpose of a matrix")
  (:method ((matrix matrix))
    (conjugate-transpose matrix)))

(defgeneric dagger! (matrix)
  (:documentation "Compute the conjugate transpose of a matrix, replacing the elements")
  (:method ((matrix matrix))
    (conjugate-transpose! matrix)))

;; TODO: either make this generic or call lapack functions
(defgeneric orthonormalize! (matrix)
  (:documentation "Orthonormalize a matrix, replacing the elements"))

;;; Fancy linear algebra

(defgeneric eig (matrix)
  (:documentation "Find the (right) eigenvectors and corresponding eigenvalues of a square matrix M. Returns two lists (EIGENVALUES, EIGENVECTORS)")
  (:method ((matrix matrix))
    (lapack-eig matrix)))

;; TODO: maybe write generic form of this
(defgeneric lu (matrix)
  (:documentation "Get the LU decomposition of the matrix

ARGS:
matrix :: matrix

VALUES:
a :: matrix
ipiv :: vector")
  (:method ((matrix matrix))
    (lapack-lu matrix)))

(defgeneric csd (matrix p q)
  (:documentation "Find the Cosine-Sine Decomposition of a matrix X given that it is to be partitioned with upper left block of dimension P-by-Q. Returns the CSD elements (VALUES U SIGMA VT) such that X=U*SIGMA*VT.")
  (:method ((matrix matrix) p q)
    (labels ((csd-from-blocks (u1 u2 v1t v2t theta)
               "Calculates the matrices U, SIGMA, and VT of the CSD of a matrix from its intermediate representation, as calculated from ZUNCSD."
               (let ((p (nrows u1))
                     (q (nrows v1t))
                     (m (cl:+ (nrows u1) (nrows u2)))
                     (r (length theta)))
                 (let ((u (direct-sum u1 u2))
                       (sigma (const 0 (list m m) :type (element-type matrix)))
                       (vt (direct-sum v1t v2t)))
                   (let ((diag11 (min p q))
                         (diag12 (min p (cl:- m q)))
                         (diag21 (min (cl:- m p) q))
                         (diag22 (min (cl:- m p) (cl:- m q))))
                     (let ((iden11 (cl:- diag11 r))
                           (iden12 (cl:- diag12 r))
                           (iden21 (cl:- diag21 r))
                           (iden22 (cl:- diag22 r)))
                       ;; Construct sigma from theta
                       (loop :for i :from 0 :to (1- iden11)
                             do (setf (tref sigma i i) 1))
                       (loop :for i :from iden11 :to (1- diag11)
                             do (setf (tref sigma i i) (cos (nth (cl:- i iden11) theta))))
                       (loop :for i :from 0 :to (1- iden12)
                             do (setf (tref sigma (cl:- p 1 i) (cl:- m 1 i)) -1))
                       (loop :for i :from iden12 :to (1- diag12)
                             do (setf (tref sigma (cl:- p 1 i) (cl:- m 1 i))
                                      (cl:- (sin (nth (cl:- r 1 (cl:- i iden12)) theta)))))
                       (loop :for i :from 0 :to (1- iden21)
                             do (setf (tref sigma (cl:- m 1 i) (cl:- q 1 i)) 1))
                       (loop :for i :from iden21 :to (1- diag21)
                             do (setf (tref sigma (cl:- m 1 i) (cl:- q 1 i))
                                      (sin (nth (cl:- r 1 (cl:- i iden21)) theta))))
                       (loop :for i :from 0 :to (1- iden22)
                             do (setf (tref sigma (cl:+ p i) (cl:+ q i)) 1))
                       (loop :for i :from iden22 :to (1- diag22)
                             do (setf (tref sigma (cl:+ p i) (cl:+ q i)) (cos (nth (cl:- i iden22) theta))))))
                   (values u sigma vt)))))
      (multiple-value-bind (u1 u2 v1t v2t theta) (lapack-csd matrix p q)
        (csd-from-blocks u1 u2 v1t v2t theta)))))

(defgeneric svd (matrix)
  (:documentation "Find the SVD of a matrix M. Return (VALUES U SIGMA Vt) where M = U*SIGMA*Vt")
  (:method ((matrix matrix))
    (lapack-svd matrix)))

(defgeneric ql (matrix)
  (:documentation "Finds the QL factorization of the matrix M.")
  (:method ((m matrix))
    (let ((rows (nrows m))
          (cols (ncols m)))
      (multiple-value-bind (a tau) (lapack-ql m)
        (let* ((r (upper-triangular a cols))
               (q (lapack-ql-q a tau)))
          ;; change signs if diagonal elements of r are negative
          (dotimes (j cols)
            (let ((diag-elt (tref r j j)))
              (assert (zerop (imagpart diag-elt))
                      () "Diagonal element R_~D~D=~A is not real" j j diag-elt)
              (setf diag-elt (realpart diag-elt))
              (when (minusp diag-elt)
                (dotimes (i rows)
                  (when (<= j i (1- cols))
                    (setf (tref r j i) (cl:- (tref r j i))))
                  (setf (tref q i j) (cl:- (tref q i j)))))))
          (values q r))))))

;; TODO: Let's clean this up
(defgeneric qr (matrix)
  (:documentation "Finds the QL factorization of the matrix M.")
  (:method ((m matrix))
    (let ((rows (nrows m))
          (cols (ncols m)))
      (multiple-value-bind (a tau) (lapack-qr m)
        (let* ((r (upper-triangular a cols))
               (q (lapack-qr-q a tau)))
          ;; change signs if diagonal elements of r are negative
          (dotimes (j cols)
            (let ((diag-elt (tref r j j)))
              (assert (zerop (imagpart diag-elt))
                      () "Diagonal element R_~D~D=~A is not real" j j diag-elt)
              (setf diag-elt (realpart diag-elt))
              (when (minusp diag-elt)
                (dotimes (i rows)
                  (when (<= j i (1- cols))
                    (setf (tref r j i) (cl:- (tref r j i))))
                  (setf (tref q i j) (cl:- (tref q i j)))))))
          (values q r))))))

(defgeneric rq (matrix)
  (:documentation "Finds the RQ factorization of the matrix M.")
  (:method ((matrix matrix))
    (error "RQ not fully implemented")
    ;;(lapack-rq matrix)
    ))

(defgeneric lq (matrix)
  (:documentation "Finds the LQ factorization of the matrix M.")
  (:method ((matrix matrix))
    (error "LQ not fully implemented")
    ;;(lapack-lq matrix)
    ))

;; Lapack functions

(defgeneric lapack-eig (matrix))

(defgeneric lapack-lu (matrix))

(defgeneric lapack-csd (matrix p q))

(defgeneric lapack-svd (matrix))

(defgeneric lapack-ql (matrix)
  (:documentation "Find the LAPACK intermediate representation of ql of a matrix"))

(defgeneric lapack-qr (matrix)
  (:documentation "Find the LAPACK intermediate representation of qr of a matrix"))

(defgeneric lapack-rq (matrix)
  (:documentation "Find the LAPACK intermediate representation of rq of a matrix"))

(defgeneric lapack-lq (matrix)
  (:documentation "Find the LAPACK intermediate representation of lq of a matrix"))

(defgeneric lapack-ql-q (matrix tau)
  (:documentation "Finds the unitary matrix Q from QL factorization of the matrix M, given the reflectors and intermediate representation provided by lapack-ql"))

(defgeneric lapack-qr-q (matrix tau)
  (:documentation "Finds the unitary matrix Q from QR factorization of the matrix M, given the reflectors and intermediate representation provided by lapack-qr"))

(defgeneric lapack-rq-q (matrix tau)
  (:documentation "Finds the unitary matrix Q from RQ factorization of the matrix M, given the reflectors and intermediate representation provided by lapack-rq"))

(defgeneric lapack-lq-q (matrix tau)
  (:documentation "Finds the unitary matrix Q from LQ factorization of the matrix M, given the reflectors and intermediate representation provided by lapack-lq"))


;; TODO:
;; Inverse
;; einsum
;; Solve
;; exponent
;; dot
;; stack together
