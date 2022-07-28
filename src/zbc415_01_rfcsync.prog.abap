*&---------------------------------------------------------------------*
*& Report ZBC415_01_RFCSYNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc415_01_rfcsync.

PARAMETERS: carrid TYPE spfli-carrid,
            connid TYPE spfli-connid,
            pa_des TYPE rfcdes-rfcdest.

DATA gs_spfli TYPE spfli.
DATA gv_sysid TYPE sy-sysid.
CALL FUNCTION 'Z_BC415_READ_SPFLI'
in BACKGROUND TASK
DESTINATION pa_des
  EXPORTING
    carrid                = carrid
    connid                = connid.

COMMIT WORK.
uline.
write 'programmende'.
