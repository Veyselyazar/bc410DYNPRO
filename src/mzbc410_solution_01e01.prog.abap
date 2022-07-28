*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_01E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.
  GET PARAMETER ID 'CAR' FIELD gs_sflight-carrid.
  GET PARAMETER ID 'CON' FIELD gs_sflight-connid.
  GET PARAMETER ID 'DAY' FIELD gs_sflight-fldate.

  data gv_nl type c LENGTH 20.
  get PARAMETER ID 'ZIAL_NL' field gv_nl.

  IF gs_sflight-carrid IS NOT INITIAL
    AND gs_sflight-connid IS NOT INITIAL
    AND gs_sflight-fldate IS NOT INITIAL.
    SELECT SINGLE * FROM sflight INTO gs_sflight
      WHERE carrid = gs_sflight-carrid
        AND connid = gs_sflight-connid
        AND fldate = gs_sflight-fldate.

  ENDIF.
