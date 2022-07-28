*&---------------------------------------------------------------------*
*& Report Z01_DYNAMISCH_FUBA_AUFRUFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_dynamisch_fuba_aufrufen.
types gty_n type n LENGTH 4.
DATA: gv_fuba TYPE c LENGTH 30 VALUE 'EASTER_GET_DATE'.
DATA: gt_parm TYPE abap_func_parmbind_tab,
      gs_parm TYPE abap_func_parmbind.
DATA gv_jahr TYPE gty_n  VALUE '2023'.
DATA ref_jahr TYPE REF TO gty_n.
DATA gv_datum TYPE sy-datum.


gs_parm-name = 'YEAR'.
gs_parm-kind = abap_func_exporting.
GET REFERENCE OF gv_jahr INTO gs_parm-value.

INSERT gs_parm INTO TABLE gt_parm.
CLEAR gs_parm.
gs_parm-name = 'EASTERDATE'.
gs_parm-kind = 20.
GET REFERENCE OF gv_datum INTO gs_parm-value.


INSERT gs_parm INTO TABLE gt_parm.

CALL FUNCTION gv_fuba
  PARAMETER-TABLE gt_parm.


IF gv_datum IS NOT INITIAL.
  WRITE: 'Ostersonntag', gv_datum.

ENDIF.
