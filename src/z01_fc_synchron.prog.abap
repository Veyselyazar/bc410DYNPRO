*&---------------------------------------------------------------------*
*& Report Z01_FC_SYNCHRON
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_fc_synchron.

PARAMETERS pa_jahr TYPE n LENGTH 4.
PARAMETERS pa_dest TYPE rfcdes-rfcdest.

DATA gv_datum_os TYPE sy-datum.

CALL FUNCTION 'EASTER_GET_DATE'
  DESTINATION pa_dest
  EXPORTING
    year                  = pa_jahr
*   IV_USER               =
  IMPORTING
    easterdate            = gv_datum_os
  EXCEPTIONS
    system_failure        = 1
    communication_failure = 2.
CASE sy-subrc.
  WHEN 0.
    WRITE: 'Ostersonntag', gv_datum_os.
  WHEN 1.
    WRITE 'Funktionsbaustein existiert nicht oder ist nicht remotefähig'.
  WHEN 2.
    WRITE 'Destination existiert nicht'.
ENDCASE.
