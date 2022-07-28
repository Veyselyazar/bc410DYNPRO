*&---------------------------------------------------------------------*
*& Report ZBC415_01_RFCSYNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc415_01_trfc.

PARAMETERS: carrid TYPE spfli-carrid,
            connid TYPE spfli-connid,
            pa_des TYPE rfcdes-rfcdest.

DATA gs_spfli TYPE spfli.
DATA gv_sysid TYPE sy-sysid.
CALL FUNCTION 'Z_BC415_READ_SPFLI'
DESTINATION pa_des
  EXPORTING
    carrid                = carrid
    connid                = connid
  IMPORTING
    ex_spfli              = gs_spfli
    sys                   = gv_sysid
  EXCEPTIONS
    system_failure        = 1
    communication_failure = 2
    invalid_data          = 3.
CASE sy-subrc.
  WHEN 0.
    WRITE: gs_spfli-carrid, gs_spfli-connid, gs_spfli-cityfrom, gs_spfli-cityto,
           / 'System-ID', gv_sysid.
  WHEN 1.
    WRITE ' Funtkionsbaustein nicht vorhanden'.
  WHEN 2.
    WRITE 'Destination existiert nicht'.
  WHEN 3.
    WRITE 'Datenbestand passt nicht'.
ENDCASE.
