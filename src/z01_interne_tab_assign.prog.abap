*&---------------------------------------------------------------------*
*& Report Z01_INTERNE_TAB_ASSIGN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_INTERNE_TAB_ASSIGN.

data gt_spfli type table of spfli.
select * from spfli into TABLE gt_spfli.


loop at gt_spfli ASSIGNING FIELD-SYMBOL(<fs_spfli>).
  <fs_spfli>-mandt = 888.
  write: / <fs_spfli>-carrid,
           <fs_spfli>-connid,
           <fs_spfli>-mandt.

ENDLOOP.
