*&---------------------------------------------------------------------*
*& Report Z01_RPORT_GENERATOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_rport_generator.

DATA gt_tab TYPE TABLE OF string.
DATA gv_prog TYPE programm VALUE 'Z01_PERSISTENT'.
DATA gs_tab TYPE string.
gs_tab = 'Report.'.
INSERT gs_tab INTO TABLE gt_tab.
APPEND 'parameters pa_car type scarr-carrid.' TO  gt_tab.
APPEND 'data gs_scarr type scarr.' TO  gt_tab.
APPEND 'select single * from scarr into gs_scarr where carrid = pa_car.' TO gt_tab.
APPEND 'Write gs_scarr(100).' TO gt_tab.

INSERT REPORT gv_prog FROM gt_tab.

submit (gv_prog) VIA SELECTION-SCREEN AND RETURN.
