*&---------------------------------------------------------------------*
*& Report  BC402_DYT_DYN_CALL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zbc402_01_dyn_call MESSAGE-ID bc402.

TYPE-POOLS:
   abap.

DATA: gt_cust TYPE ty_customers,
      gt_conn TYPE ty_connections.

DATA: gt_parms    TYPE abap_parmbind_tab,
      gs_parms    TYPE abap_parmbind,
      gv_methname TYPE c LENGTH 30.

SELECTION-SCREEN COMMENT 1(80) TEXT-sel.
PARAMETERS:
  pa_xconn TYPE xfeld RADIOBUTTON GROUP tab DEFAULT 'X',
  pa_xcust TYPE xfeld RADIOBUTTON GROUP tab.
PARAMETERS:
   pa_nol   TYPE i DEFAULT '100'.

START-OF-SELECTION.

* specific part
*----------------------------------------------------------------------*
  CASE 'X'.
    WHEN pa_xconn.
      gv_methname = 'WRITE_CONNECTIONS'.
      gs_parms-name = 'IT_CONN'.
      gs_parms-value = REF #( gt_conn ).
      INSERT gs_parms INTO TABLE gt_parms.

      SELECT * FROM spfli INTO TABLE gt_conn
               UP TO pa_nol ROWS.


    WHEN pa_xcust.
      gv_methname = 'WRITE_CUSTOMERS'.
      gs_parms-name = 'IT_CUST'.
      gs_parms-value = REF #( gt_cust ).

      INSERT gs_parms INTO TABLE gt_parms.

      SELECT * FROM scustom INTO TABLE gt_cust
               UP TO pa_nol ROWS.

  ENDCASE.
  DATA gv_classname TYPE c LENGTH 30 VALUE 'CL_BC402_UTILITIES'.
  TRY.
      CALL METHOD (gv_classname)=>(gv_methname)
        PARAMETER-TABLE gt_parms.
    CATCH cx_root INTO DATA(go_error).
      MESSAGE |{ |Folgender Fehler ist aufgetrenen | &&  go_error->get_text( ) }| TYPE 'E'.
  ENDTRY.



* dynamic part
*----------------------------------------------------------------------*
