;;;; Generated on 8/18/2017 at 17:46:50 (UTC-8).

(COMMON-LISP:IN-PACKAGE #:MAGICL.EXPOKIT-CFFI)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%DGPADM))

(CFFI:DEFCFUN ("dgpadm_" %%DGPADM :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (IDEG :POINTER)
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (WSP :POINTER)
  (LWSP :POINTER)
  (IPIV :POINTER)
  (IEXPH :POINTER)
  (NS :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%DGPADM))

(COMMON-LISP:PUSHNEW '("DGPADM" "dgpadm_" %%DGPADM %DGPADM)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %DGPADM))

(COMMON-LISP:DEFUN %DGPADM (IDEG M T H LDH WSP LWSP IPIV IEXPH NS IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%DGPADM)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IDEG)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-DOUBLE WSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LWSP)
                       (COMMON-LISP:TYPE FNV-INT32 IPIV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IEXPH)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) NS)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((IDEG-REF81 ':INT32) (M-REF82 ':INT32)
                              (T-REF83 ':DOUBLE) (LDH-REF85 ':INT32)
                              (LWSP-REF87 ':INT32) (IEXPH-REF89 ':INT32)
                              (NS-REF90 ':INT32) (IFLAG-REF91 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF IDEG-REF81 :INT32) IDEG)
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF82 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF83 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF85 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF LWSP-REF87 :INT32) LWSP)
    (COMMON-LISP:SETF (CFFI:MEM-REF IEXPH-REF89 :INT32) IEXPH)
    (COMMON-LISP:SETF (CFFI:MEM-REF NS-REF90 :INT32) NS)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF91 :INT32) IFLAG)
    (%%DGPADM IDEG-REF81 M-REF82 T-REF83 (FNV-FOREIGN-POINTER H) LDH-REF85
     (FNV-FOREIGN-POINTER WSP) LWSP-REF87 (FNV-FOREIGN-POINTER IPIV)
     IEXPH-REF89 NS-REF90 IFLAG-REF91)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %DGPADM))

(COMMON-LISP:EXPORT '%DGPADM '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%DSPADM))

(CFFI:DEFCFUN ("dspadm_" %%DSPADM :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (IDEG :POINTER)
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (WSP :POINTER)
  (LWSP :POINTER)
  (IPIV :POINTER)
  (IEXPH :POINTER)
  (NS :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%DSPADM))

(COMMON-LISP:PUSHNEW '("DSPADM" "dspadm_" %%DSPADM %DSPADM)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %DSPADM))

(COMMON-LISP:DEFUN %DSPADM (IDEG M T H LDH WSP LWSP IPIV IEXPH NS IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%DSPADM)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IDEG)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-DOUBLE WSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LWSP)
                       (COMMON-LISP:TYPE FNV-INT32 IPIV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IEXPH)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) NS)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((IDEG-REF92 ':INT32) (M-REF93 ':INT32)
                              (T-REF94 ':DOUBLE) (LDH-REF96 ':INT32)
                              (LWSP-REF98 ':INT32) (IEXPH-REF100 ':INT32)
                              (NS-REF101 ':INT32) (IFLAG-REF102 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF IDEG-REF92 :INT32) IDEG)
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF93 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF94 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF96 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF LWSP-REF98 :INT32) LWSP)
    (COMMON-LISP:SETF (CFFI:MEM-REF IEXPH-REF100 :INT32) IEXPH)
    (COMMON-LISP:SETF (CFFI:MEM-REF NS-REF101 :INT32) NS)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF102 :INT32) IFLAG)
    (%%DSPADM IDEG-REF92 M-REF93 T-REF94 (FNV-FOREIGN-POINTER H) LDH-REF96
     (FNV-FOREIGN-POINTER WSP) LWSP-REF98 (FNV-FOREIGN-POINTER IPIV)
     IEXPH-REF100 NS-REF101 IFLAG-REF102)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %DSPADM))

(COMMON-LISP:EXPORT '%DSPADM '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%ZGPADM))

(CFFI:DEFCFUN ("zgpadm_" %%ZGPADM :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (IDEG :POINTER)
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (WSP :POINTER)
  (LWSP :POINTER)
  (IPIV :POINTER)
  (IEXPH :POINTER)
  (NS :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%ZGPADM))

(COMMON-LISP:PUSHNEW '("ZGPADM" "zgpadm_" %%ZGPADM %ZGPADM)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %ZGPADM))

(COMMON-LISP:DEFUN %ZGPADM (IDEG M T H LDH WSP LWSP IPIV IEXPH NS IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%ZGPADM)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IDEG)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LWSP)
                       (COMMON-LISP:TYPE FNV-INT32 IPIV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IEXPH)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) NS)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((IDEG-REF103 ':INT32) (M-REF104 ':INT32)
                              (T-REF105 ':DOUBLE) (LDH-REF107 ':INT32)
                              (LWSP-REF109 ':INT32) (IEXPH-REF111 ':INT32)
                              (NS-REF112 ':INT32) (IFLAG-REF113 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF IDEG-REF103 :INT32) IDEG)
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF104 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF105 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF107 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF LWSP-REF109 :INT32) LWSP)
    (COMMON-LISP:SETF (CFFI:MEM-REF IEXPH-REF111 :INT32) IEXPH)
    (COMMON-LISP:SETF (CFFI:MEM-REF NS-REF112 :INT32) NS)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF113 :INT32) IFLAG)
    (%%ZGPADM IDEG-REF103 M-REF104 T-REF105 (FNV-FOREIGN-POINTER H) LDH-REF107
     (FNV-FOREIGN-POINTER WSP) LWSP-REF109 (FNV-FOREIGN-POINTER IPIV)
     IEXPH-REF111 NS-REF112 IFLAG-REF113)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %ZGPADM))

(COMMON-LISP:EXPORT '%ZGPADM '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%ZHPADM))

(CFFI:DEFCFUN ("zhpadm_" %%ZHPADM :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (IDEG :POINTER)
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (WSP :POINTER)
  (LWSP :POINTER)
  (IPIV :POINTER)
  (IEXPH :POINTER)
  (NS :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%ZHPADM))

(COMMON-LISP:PUSHNEW '("ZHPADM" "zhpadm_" %%ZHPADM %ZHPADM)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %ZHPADM))

(COMMON-LISP:DEFUN %ZHPADM (IDEG M T H LDH WSP LWSP IPIV IEXPH NS IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%ZHPADM)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IDEG)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LWSP)
                       (COMMON-LISP:TYPE FNV-INT32 IPIV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IEXPH)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) NS)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((IDEG-REF114 ':INT32) (M-REF115 ':INT32)
                              (T-REF116 ':DOUBLE) (LDH-REF118 ':INT32)
                              (LWSP-REF120 ':INT32) (IEXPH-REF122 ':INT32)
                              (NS-REF123 ':INT32) (IFLAG-REF124 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF IDEG-REF114 :INT32) IDEG)
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF115 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF116 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF118 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF LWSP-REF120 :INT32) LWSP)
    (COMMON-LISP:SETF (CFFI:MEM-REF IEXPH-REF122 :INT32) IEXPH)
    (COMMON-LISP:SETF (CFFI:MEM-REF NS-REF123 :INT32) NS)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF124 :INT32) IFLAG)
    (%%ZHPADM IDEG-REF114 M-REF115 T-REF116 (FNV-FOREIGN-POINTER H) LDH-REF118
     (FNV-FOREIGN-POINTER WSP) LWSP-REF120 (FNV-FOREIGN-POINTER IPIV)
     IEXPH-REF122 NS-REF123 IFLAG-REF124)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %ZHPADM))

(COMMON-LISP:EXPORT '%ZHPADM '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%DGCHBV))

(CFFI:DEFCFUN ("dgchbv_" %%DGCHBV :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (Y :POINTER)
  (WSP :POINTER)
  (IWSP :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%DGCHBV))

(COMMON-LISP:PUSHNEW '("DGCHBV" "dgchbv_" %%DGCHBV %DGCHBV)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %DGCHBV))

(COMMON-LISP:DEFUN %DGCHBV (M T H LDH Y WSP IWSP IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%DGCHBV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-DOUBLE Y)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP)
                       (COMMON-LISP:TYPE FNV-INT32 IWSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((M-REF125 ':INT32) (T-REF126 ':DOUBLE)
                              (LDH-REF128 ':INT32) (IFLAG-REF132 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF125 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF126 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF128 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF132 :INT32) IFLAG)
    (%%DGCHBV M-REF125 T-REF126 (FNV-FOREIGN-POINTER H) LDH-REF128
     (FNV-FOREIGN-POINTER Y) (FNV-FOREIGN-POINTER WSP)
     (FNV-FOREIGN-POINTER IWSP) IFLAG-REF132)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %DGCHBV))

(COMMON-LISP:EXPORT '%DGCHBV '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%DNCHBV))

(CFFI:DEFCFUN ("dnchbv_" %%DNCHBV :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (Y :POINTER)
  (WSP :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%DNCHBV))

(COMMON-LISP:PUSHNEW '("DNCHBV" "dnchbv_" %%DNCHBV %DNCHBV)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %DNCHBV))

(COMMON-LISP:DEFUN %DNCHBV (M T H LDH Y WSP)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%DNCHBV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-DOUBLE Y)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP))
  (CFFI:WITH-FOREIGN-OBJECTS ((M-REF133 ':INT32) (T-REF134 ':DOUBLE)
                              (LDH-REF136 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF133 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF134 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF136 :INT32) LDH)
    (%%DNCHBV M-REF133 T-REF134 (FNV-FOREIGN-POINTER H) LDH-REF136
     (FNV-FOREIGN-POINTER Y) (FNV-FOREIGN-POINTER WSP))))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %DNCHBV))

(COMMON-LISP:EXPORT '%DNCHBV '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%DSCHBV))

(CFFI:DEFCFUN ("dschbv_" %%DSCHBV :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (Y :POINTER)
  (WSP :POINTER)
  (IWSP :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%DSCHBV))

(COMMON-LISP:PUSHNEW '("DSCHBV" "dschbv_" %%DSCHBV %DSCHBV)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %DSCHBV))

(COMMON-LISP:DEFUN %DSCHBV (M T H LDH Y WSP IWSP IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%DSCHBV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-DOUBLE Y)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP)
                       (COMMON-LISP:TYPE FNV-INT32 IWSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((M-REF139 ':INT32) (T-REF140 ':DOUBLE)
                              (LDH-REF142 ':INT32) (IFLAG-REF146 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF139 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF140 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF142 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF146 :INT32) IFLAG)
    (%%DSCHBV M-REF139 T-REF140 (FNV-FOREIGN-POINTER H) LDH-REF142
     (FNV-FOREIGN-POINTER Y) (FNV-FOREIGN-POINTER WSP)
     (FNV-FOREIGN-POINTER IWSP) IFLAG-REF146)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %DSCHBV))

(COMMON-LISP:EXPORT '%DSCHBV '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%ZGCHBV))

(CFFI:DEFCFUN ("zgchbv_" %%ZGCHBV :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (Y :POINTER)
  (WSP :POINTER)
  (IWSP :POINTER)
  (IFLAG :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%ZGCHBV))

(COMMON-LISP:PUSHNEW '("ZGCHBV" "zgchbv_" %%ZGCHBV %ZGCHBV)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %ZGCHBV))

(COMMON-LISP:DEFUN %ZGCHBV (M T H LDH Y WSP IWSP IFLAG)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%ZGCHBV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE Y)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP)
                       (COMMON-LISP:TYPE FNV-INT32 IWSP)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) IFLAG))
  (CFFI:WITH-FOREIGN-OBJECTS ((M-REF147 ':INT32) (T-REF148 ':DOUBLE)
                              (LDH-REF150 ':INT32) (IFLAG-REF154 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF147 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF148 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF150 :INT32) LDH)
    (COMMON-LISP:SETF (CFFI:MEM-REF IFLAG-REF154 :INT32) IFLAG)
    (%%ZGCHBV M-REF147 T-REF148 (FNV-FOREIGN-POINTER H) LDH-REF150
     (FNV-FOREIGN-POINTER Y) (FNV-FOREIGN-POINTER WSP)
     (FNV-FOREIGN-POINTER IWSP) IFLAG-REF154)))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %ZGCHBV))

(COMMON-LISP:EXPORT '%ZGCHBV '#:MAGICL.EXPOKIT-CFFI)


(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %%ZNCHBV))

(CFFI:DEFCFUN ("znchbv_" %%ZNCHBV :LIBRARY MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
    :VOID
  (M :POINTER)
  (T :POINTER)
  (H :POINTER)
  (LDH :POINTER)
  (Y :POINTER)
  (WSP :POINTER))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %%ZNCHBV))

(COMMON-LISP:PUSHNEW '("ZNCHBV" "znchbv_" %%ZNCHBV %ZNCHBV)
                     (COMMON-LISP:GETF
                      (COMMON-LISP:SYMBOL-PLIST
                       'MAGICL.FOREIGN-LIBRARIES:LIBEXPOKIT)
                      ':MAGICL)
                     :TEST 'COMMON-LISP:EQUAL :KEY 'COMMON-LISP:CAR)

(COMMON-LISP:DECLAIM (COMMON-LISP:INLINE %ZNCHBV))

(COMMON-LISP:DEFUN %ZNCHBV (M T H LDH Y WSP)
  (COMMON-LISP:DECLARE (COMMON-LISP:INLINE %%ZNCHBV)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) M)
                       (COMMON-LISP:TYPE COMMON-LISP:DOUBLE-FLOAT T)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE H)
                       (COMMON-LISP:TYPE (COMMON-LISP:SIGNED-BYTE 32) LDH)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE Y)
                       (COMMON-LISP:TYPE FNV-COMPLEX-DOUBLE WSP))
  (CFFI:WITH-FOREIGN-OBJECTS ((M-REF155 ':INT32) (T-REF156 ':DOUBLE)
                              (LDH-REF158 ':INT32))
    (COMMON-LISP:SETF (CFFI:MEM-REF M-REF155 :INT32) M)
    (COMMON-LISP:SETF (CFFI:MEM-REF T-REF156 :DOUBLE) T)
    (COMMON-LISP:SETF (CFFI:MEM-REF LDH-REF158 :INT32) LDH)
    (%%ZNCHBV M-REF155 T-REF156 (FNV-FOREIGN-POINTER H) LDH-REF158
     (FNV-FOREIGN-POINTER Y) (FNV-FOREIGN-POINTER WSP))))

(COMMON-LISP:DECLAIM (COMMON-LISP:NOTINLINE %ZNCHBV))

(COMMON-LISP:EXPORT '%ZNCHBV '#:MAGICL.EXPOKIT-CFFI)


;;; End of file.
