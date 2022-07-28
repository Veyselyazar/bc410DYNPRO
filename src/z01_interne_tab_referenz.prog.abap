*&---------------------------------------------------------------------*
*& Report Z01_INTERNE_TAB_ASSIGN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_INTERNE_TAB_REFERENZ.

data gt_spfli type table of spfli .
select * from spfli into TABLE gt_spfli.
"data gr_spfli type REF TO spfli.

data gv_prog type c LENGTH 30 value 'Z01_PROG'.
"call TRANSACTION gv_prog.

*submit (gv_prog) AND RETURN.
*data gv_tab type c LENGTH 20 value 'SFLIGHT'.
*select * from (gv_tab) ...


data gv_fuba type c LENGTH 30 value 'EASTER_GET_DATE'.
data gt_parm type abap_func_parmbind_tab.
call function gv_fuba
      EXPORTING year = 2023.


loop at gt_spfli REFERENCE INTO data(gr_spfli).
  gr_spfli->mandt = 888.
  write: / gr_spfli->*-carrid,
           gr_spfli->connid,
           gr_spfli->mandt.

ENDLOOP.

READ TABLE gt_spfli with  key carrid = 'AA' REFERENCE INTO gr_spfli.

write gr_spfli->cityfrom.
