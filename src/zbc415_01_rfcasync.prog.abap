*&---------------------------------------------------------------------*
*& Report ZBC415_01_RFCSYNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc415_01_rfcasync.

PARAMETERS: carrid TYPE spfli-carrid,
            connid TYPE spfli-connid.
"  pa_des TYPE rfcdes-rfcdest.

DATA gs_spfli TYPE spfli.
DATA gv_sysid TYPE sy-sysid.
DATA gv_ende TYPE c LENGTH 1.
DATA gv_sy_subrc TYPE sy-subrc.
CALL FUNCTION 'Z_BC415_READ_SPFLI'
"DESTINATION pa_des
  STARTING NEW TASK 'FUBA1'
  PERFORMING ergebnis_entgegennehmen ON END OF TASK
  EXPORTING
    carrid = carrid
    connid = connid.
*  IMPORTING
*  EXCEPTIONS
*    system_failure        = 1
*    communication_failure = 2.
"    invalid_data          = 3.
*CASE sy-subrc.
**WHEN 0.
*
*  WHEN 1.
*    WRITE ' Funtkionsbaustein nicht vorhanden'.
*  WHEN 2.
*    WRITE 'Destination existiert nicht'.
*ENDCASE.
....
....
....

WAIT UNTIL gv_ende = 'X'. "Im herausgerollten Zusatand

CASE gv_sy_subrc.
  WHEN 0.
    WRITE: gs_spfli-carrid, gs_spfli-connid, gs_spfli-cityfrom, gs_spfli-cityto,
           / 'System-ID', gv_sysid.
  WHEN 1.
    WRITE 'Datenselektion nicht erfolgreich'.
  WHEN 2.
    WRITE 'Funktionsbaustein nicht remotefähig'.
  WHEN 3.
    WRITE 'DESTINATION existiert nicht'.
ENDCASE.


ULINE.
WRITE 'Programmende'.
FORM ergebnis_entgegennehmen USING ret_fuba.
  CASE ret_fuba.
    WHEN 'FUBA1'.
      RECEIVE RESULTS FROM FUNCTION 'z_BC415_READ_SPFLI'
       IMPORTING
             ex_spfli              = gs_spfli
             sys                   = gv_sysid
       EXCEPTIONS
        invalid_data = 1
*        system_failure        = 2
*         communication_failure = 3.
.
      gv_ende = 'X'.
      gv_sy_subrc = sy-subrc.

  ENDCASE.

ENDFORM.
