; Day la vi du ve DCL - VI DU 1

(defun C:T3()

  ; Mo va toa hop thoai

  (setq dcl_id (load_dialog "Vidu5.dcl"))

  (if (not (new_dialog "EXAMPLE" dcl_id))
    (exit)
    ) ;
  (setq stDiaupdate 0
	stHtextupdate 0
	statustxtfile 0
	stNametag 0
	stBeginfrom 0
	stTolerance 0
	stdirsort 0
	) ; end setq 

  (action_tile "Duongkinhlo" "(setq giatrihole $value) (setq stDiaupdate 1)")
  (action_tile "chieucaochu" "(setq hchu $value) (setq stHtextupdate 1)")
  (action_tile "statustxt1" "(setq  statustxtfile (atoi $value)) ")
  (action_tile "Nametag" "(setq ghiNametag $value ) (setq stNametag 1) ")
  (action_tile "Beginfrom" "(setq ghiBeginfrom $value) (setq stBeginfrom 1)" )
  (action_tile "Tolerance" "(setq stTolerance (atoi $value))" )
  (action_tile "dirsort" "(setq stdirsort (atoi $value))" )
  (princ " Ki tu lo la : ")
  (princ ghiNametag)
  

  (action_tile "cancel" "(done_dialog 0)")
  (action_tile "accept" "(done_dialog 1)")

  (setq status1 (start_dialog))
  (unload_dialog dcl_id)

  ;; if the user clicked OK -> (done_dialog 1)

  ;; set the global variables
  (if (= status1 1)
    (progn
      ; gia tri duong kinh
      (if (= stDiaupdate 0)
	(setq dia 3.2)
	(setq dia (atof giatrihole))
	) ; end if
      ;======= chieucao chu ======
      (if (= stHtextupdate 0 )
	(setq Htext 2.5)
	(setq Htext (atof hchu))
	) ; end if
      ;=========Name tag =======
      (if (= stNametag 0)
	(progn
	  (princ "333333333333")
	  (setq hienNametag "L")
	  )
	(progn
	  (princ "44444444444444444")
	  (setq hienNametag ghiNametag)
	  )
	) ; end setq
      (if (= stBeginfrom 0)
	(setq hienBeginfrom 0)
	(setq hienBeginfrom (atoi ghiBeginfrom))
	) ; end setq
      ; ======= Tolerance ====
      (if (= stTolerance 0)
	(setq ghidungsai 1) )
      (if (= stTolerance 1)
	(setq ghidungsai 2) )
      (if (= stTolerance 2)
	(setq ghidungsai 3))
      ; ======= Sort direction ====
      (if (= stdirsort 0)
	(setq chieulo 1))
      (if (= stdirsort 1)
	(setq chieulo 2))
      ;============================
      (princ "co xuat file txt hay khong :: ")
      
      ; ======Co xuat file Data.txt  hay khong
      (if (= statustxtfile 0)
	(Holetable1 dia Htext hienNametag hienBeginfrom ghidungsai chieulo)
	(Holetable2 dia Htext hienNametag hienBeginfrom ghidungsai chieulo)
	) ; end if
      

      ) ; end progn
    ) ; end if 
  (princ)

  ) ; end main program


;==============================================================;
;         Function : Hole table - Khong xuat file TXT          ;
;=============================================================='

(defun Holetable1 (Duongkinhlo chieucaochu1 ghiNametag0 ghiBeginfrom0 ghidungsai0 chieulo0 / )
  ;   --    set up thong so ban dau ----
  (setvar "osmode" 0 )
  (setvar "orthomode" 0 )
  (setvar "cmdecho" 0)
  ; ------- set up variable ------------
  (setq radi (* 0.5 Duongkinhlo ))
  (setq linhs (ssget (list (cons '0 "circle") (cons '40 radi) ))
	sothutu 0
	soluong (sslength linhs)
	) ; end setq

  ; ------------CREAT TABLE IN AUTOCAD ----
  (vl-load-com)
  (setq ActiveDocument (vla-get-activedocument (vlax-get-acad-object)))
  (setq mSpace(vla-get-modelspace ActiveDocument))
  (setq pt (vlax-make-safearray vlax-vbDouble '(0 . 2)))
  (setq diemleft (getpoint "NHAP TOA DIEM DIEM DAT TABLE "))
  (vlax-safearray-fill pt diemleft)
  (setq myTable (vla-addtable mSpace pt (+ soluong 2) 3 10 30))
  (vla-setcelltextheight myTable 0 0 5)
  (vla-settext myTable 0 0 "Day la hang dau tien")
  (princ "Ketthuctao bang")
  (princ "Soluong")


  ; -------- lay du lieu Vitri hole table -----
  (setq linhc '(1.0 2.0 3.0))
  (repeat soluong
    (setq cute (ssname linhs sothutu)
	  cutecode (entget cute)
	  tamtron (cdr (assoc 10 cutecode))
	  ) ; end setq
    (setq linhc (append linhc (list tamtron)))
    (setq sothutu (1+ sothutu))
    ) ; end repeat
  (setq linhc (cdddr linhc ))

  ;========== Sap xep thu tu lo ===========
  (if (= chieulo0 1)
    (progn
      (setq linhc (vl-sort linhc (function
		 (lambda (e1 e2)
		   (< (car e1) (car e2))
		   )
		 )
	   ) ; end vlsort
	) ; end setq
      ) ; end progn1
    (progn
      (setq linhc (vl-sort linhc (function
		 (lambda (e1 e2)
		   (< (cadr e1) (cadr e2))
		   )
		 )
	   ) ; end vlsort
	) ; end setq
      ) ; end progn2
    ) ; end if
  ;=======================================
  (princ "Da xong list ")
  (princ ghiNametag0)

  ; ---- Them toa do vao table va ve Name tag
  (setq dem 0)

  (repeat soluong
    (setq pointhole (nth dem linhc))
    (setq tamtron1 (trans pointhole 0 1 ))
    (setq dem0 (+ dem ghiBeginfrom0))
    (princ " so thu tu dem la :")
    (princ dem0)
    
    (setq mota3 (strcat ghiNametag0 (itoa dem0)))
    (command "text" tamtron1 2.5 "0" mota3 "" "")

    (setq x1 (car tamtron1)
	  y1 (cadr tamtron1)
	  ) ; end setq
    (setq xx1 (rtos x1 2 ghidungsai0 )
	  yy1 (rtos y1 2 ghidungsai0 )
	  ) ; end setq
    ; ---- Nap du lieu vao bang table
    (vla-settextheight myTable (+ dem 1) chieucaochu1)
    (vla-settext myTable (+ dem 1) 0 mota3)
    (vla-settext myTable (+ dem 1) 1 xx1)
    (vla-settext myTable (+ dem 1) 2 yy1)
    (setq dem (1+ dem))
    ) ; end repeat
  (princ "Ket thuc cuoc tinh" )
  ) ; Finish Function : Holetable1


;==============================================================;
;         Function : Hole table - XUAT FILE .TXT           ;
;=============================================================='
(defun Holetable2 (Duongkinhlo chieucaochu1 ghiNametag0 ghiBeginfrom0 ghidungsai0 chieulo0 / )
  ;   --    set up thong so ban dau ----
  (setvar "osmode" 0 )
  (setvar "orthomode" 0 )
  (setvar "cmdecho" 0)

  ;--------------CREAT FILE DATA.TXT ---------
  (setq file (getfiled "Lay text.... " "" "txt" 1))
  (setq f (open file "w"))
  (write-line "---------------------------------" f)
  (write-line "Desc        X         Y  " f)
  (write-line "---------------------------------" f)
  
  ; ------- set up variable ------------
  (setq radi (* 0.5 Duongkinhlo ))
  (setq linhs (ssget (list (cons '0 "circle") (cons '40 radi) ))
	sothutu 0
	soluong (sslength linhs)
	) ; end setq

  ; ------------CREAT TABLE IN AUTOCAD ----
  (vl-load-com)
  (setq ActiveDocument (vla-get-activedocument (vlax-get-acad-object)))
  (setq mSpace(vla-get-modelspace ActiveDocument))
  (setq pt (vlax-make-safearray vlax-vbDouble '(0 . 2)))
  (setq diemleft (getpoint "NHAP TOA DIEM DIEM DAT TABLE "))
  (vlax-safearray-fill pt diemleft)
  (setq myTable (vla-addtable mSpace pt (+ soluong 2) 3 10 30))
  (vla-setcelltextheight myTable 0 0 5)
  (vla-settext myTable 0 0 "Day la hang dau tien")
  (princ "Ketthuctao bang")
  (princ "Soluong")
  

  


  ; -------- lay du lieu Vitri hole table -----
  (setq linhc '(1.0 2.0 3.0))
  (repeat soluong
    (setq cute (ssname linhs sothutu)
	  cutecode (entget cute)
	  tamtron (cdr (assoc 10 cutecode))
	  ) ; end setq
    (setq linhc (append linhc (list tamtron)))
    (setq sothutu (1+ sothutu))
    ) ; end repeat
  (setq linhc (cdddr linhc ))
    ;========== Sap xep thu tu lo ===========
  (if (= chieulo0 1)
    (progn
      (setq linhc (vl-sort linhc (function
		 (lambda (e1 e2)
		   (< (car e1) (car e2))
		   )
		 )
	   ) ; end vlsort
	) ; end setq
      ) ; end progn1
    (progn
      (setq linhc (vl-sort linhc (function
		 (lambda (e1 e2)
		   (< (cadr e1) (cadr e2))
		   )
		 )
	   ) ; end vlsort
	) ; end setq
      ) ; end progn2
    ) ; end if
  ;=======================================
  (princ "Da xong list ")
  (princ ghiNametag0)

  ; ---- Them toa do vao table va ve Name tag
  (setq dem 0)

  (repeat soluong
    (setq pointhole (nth dem linhc))
    (setq tamtron1 (trans pointhole 0 1 ))
    (setq dem0 (+ dem ghiBeginfrom0))
    (princ " so thu tu dem la :")
    (princ dem0)
    
    (setq mota3 (strcat ghiNametag0 (itoa dem0)))
    (command "text" tamtron1 2.5 "0" mota3 "" "")

    (setq x1 (car tamtron1)
	  y1 (cadr tamtron1)
	  ) ; end setq
    (setq xx1 (rtos x1 2 ghidungsai0 )
	  yy1 (rtos y1 2 ghidungsai0 )
	  ) ; end setq

    ;---------nap du lieu vao file DATA.TXT ------
    (princ (strcat mota3 "\t" xx1 "\t" yy1 "\n") f)
    ; ---- Nap du lieu vao bang table
    (vla-settextheight myTable (+ dem 1) chieucaochu1)
    (vla-settext myTable (+ dem 1) 0 mota3)
    (vla-settext myTable (+ dem 1) 1 xx1)
    (vla-settext myTable (+ dem 1) 2 yy1)
    (setq dem (1+ dem))
    ) ; end repeat
  (close f )
  (command "osnap" "Endpoint,midpoint,center,Intersection,Tangent" )
  (princ "Ket thuc cuoc tinh" )
  ) ; Finish Function : Holetable2