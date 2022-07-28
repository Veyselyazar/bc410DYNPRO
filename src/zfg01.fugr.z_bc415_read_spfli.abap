FUNCTION z_bc415_read_spfli.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(CARRID) TYPE  SPFLI-CARRID
*"     VALUE(CONNID) TYPE  SPFLI-CONNID
*"  EXPORTING
*"     VALUE(EX_SPFLI) TYPE  SPFLI
*"     VALUE(SYS) TYPE  SYSID
*"  EXCEPTIONS
*"      INVALID_DATA
*"----------------------------------------------------------------------


  SELECT SINGLE * FROM spfli INTO ex_spfli
    WHERE carrid = carrid
      AND connid = connid.

  IF sy-subrc = 0.
    sys = sy-sysid.
  ELSE.
    RAISE invalid_data.
  ENDIF.

  carrid = 'AA'. "Physikalische Kopie


ENDFUNCTION.
