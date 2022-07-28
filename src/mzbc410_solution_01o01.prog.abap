*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_01O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  MOVE_TO_DYN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE move_to_dyn OUTPUT.
  MOVE-CORRESPONDING gs_sflight TO sdyn_conn.
  IF gs_sflight IS NOT INITIAL.
    IF  gs_sflight-fldate < sy-datum.
      CALL FUNCTION 'ICON_CREATE'
        EXPORTING
          name   = 'ICON_INCOMPLETE'
"         text   = ' Flug liegt in der Vergangenheit'
          info   = 'Flug liegt in der Vergangenheit '
*         ADD_STDINF                  = 'X'
        IMPORTING
          result = icon_termin.
    ELSE.
      CALL FUNCTION 'ICON_CREATE'
        EXPORTING
          name   = 'ICON_CHECKED'
 "        text   = ' Zukunft'
          info   = 'Flug heute oder in der Zukunft'
*         ADD_STDINF                  = 'X'
        IMPORTING
          result = icon_termin.
    ENDIF.

  ENDIF.

ENDMODULE.


MODULE status_0100 OUTPUT.
*  data gv_fc type sy-ucomm.
*  data gt_fc type sorted TABLE OF sy-ucomm with UNIQUE key table_line.
*
*  gv_fc = 'SAVE'. insert gv_fc into table gt_fc.
*  gv_fc = 'PRINT'. insert gv_fc into table gt_fc.
*  gv_fc = 'SEARCH'. insert gv_fc into table gt_fc.


  "delete gt_fc where TABLE_LINE = 'SAVE'.



  SET PF-STATUS 'STATUS0100' EXCLUDING 'SAVE'.
  CASE 'X'.
    WHEN view.
      SET TITLEBAR 'TITLE0100' WITH TEXT-ti1.
    WHEN maintain_flights.
      SET TITLEBAR 'TITLE0100' WITH TEXT-ti2.
      SET PF-STATUS 'STATUS0100'.
    WHEN maintain_bookings.
      SET TITLEBAR 'TITLE0100' WITH TEXT-ti3.

  ENDCASE.


  " set PF-STATUS  'STATUS_SAVE'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0150  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
  SET PF-STATUS 'STATUS_0150'.
  SET TITLEBAR 'TITEL150'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.
  IF maintain_flights = 'X'.
    LOOP AT SCREEN.
      IF screen-name CS 'PLANETYPE'.
        screen-input = 1.
        MODIFY SCREEN.
      ENDIF.
*      IF screen-name CS 'TAB3'.
*        screen-active = 0.
*        MODIFY SCREEN.
*      ENDIF.

    ENDLOOP.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_INPUT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_input INPUT.
  IF sdyn_conn-carrid <> 'LH'.
    MESSAGE 'Heute wird nur Lufthansa verarbeitet' TYPE 'E'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SAPLANE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE get_saplane OUTPUT.
*  select single * from saplane
*    into saplane
*    where planetype = sdyn_conn-planetype.
*ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  FILL_DYNNR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE fill_dynnr OUTPUT.
  CASE ok_code.
    WHEN 'MODE'.
      CASE abap_true.
        WHEN view.
          dynnr = '0110'.
          my_tabstrip-activetab = 'FC_TAB1'.
        WHEN maintain_flights.
          dynnr = '0120'.
          my_tabstrip-activetab = 'FC_TAB2'.
        WHEN maintain_bookings.
          dynnr = '130'.
          my_tabstrip-activetab = 'FC_TAB3'.
      ENDCASE.

    WHEN 'FC_TAB1' OR 'FC_TAB2' OR 'FC_TAB3'.
      CLEAR: view, maintain_flights, maintain_bookings.
      CASE my_tabstrip-activetab.
        WHEN 'FC_TAB1'.
          dynnr = '0110'.
          view = 'X'.
        WHEN 'FC_TAB2'.
          dynnr = '0120'.
          maintain_flights = 'X'.
        WHEN 'FC_TAB3'.
          dynnr = '0130'.
          maintain_bookings = 'X'.
      ENDCASE.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SPFLI  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_spfli OUTPUT.
  ON CHANGE OF sdyn_conn-carrid OR sdyn_conn-connid.
    SELECT SINGLE * FROM spfli INTO CORRESPONDING FIELDS OF sdyn_conn
      WHERE carrid = sdyn_conn-carrid
        AND connid = sdyn_conn-connid.
  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SAPLANE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_saplane OUTPUT.
  ON CHANGE OF sdyn_conn-planetype.
    SELECT SINGLE * FROM saplane
      INTO saplane
      WHERE planetype = sdyn_conn-planetype.
  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SBOOK  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_sbook OUTPUT.
  ON CHANGE OF sdyn_conn-carrid OR sdyn_conn-connid OR sdyn_conn-fldate.
    SELECT * FROM sbook INTO CORRESPONDING FIELDS OF TABLE gt_sdyn_book
      WHERE carrid = sdyn_conn-carrid
        AND connid = sdyn_conn-connid
        AND fldate = sdyn_conn-fldate
        AND cancelled = not_cancelled.
  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TRANS_WA_TO_SDYN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE trans_wa_to_sdyn OUTPUT.
  MOVE-CORRESPONDING gs_sdyn_book TO sdyn_book.

  IF gv_raucher = 'X'.
    IF sdyn_book-smoker = 'X'.
      LOOP AT SCREEN.
        " IF screen-name CS 'SMOKER'.
        screen-intensified = 1.
        MODIFY SCREEN.
        "ENDIF.
      ENDLOOP.
    ENDIF.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TABLE_CONTROL_SETTINGS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE table_control_settings INPUT.
  "my_table_control-line_sel_mode = '2'.
  "my_table_control-fixed_cols = 2.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CONTROL_SETTINGS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE control_settings OUTPUT.
  DATA gs_cols LIKE LINE OF my_table_control-cols.
*  LOOP AT my_table_control-cols INTO gs_cols FROM 1 TO 3.
*    "  if gs_cols-index < 4.
*    gs_cols-screen-intensified = 1.
**    else.
**      gs_cols-screen-intensified = 0.
**    endif.
*    MODIFY my_table_control-cols FROM gs_cols.
*  ENDLOOP.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SORT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0130 INPUT.
  CASE ok_code.
    WHEN 'SRTD' OR 'SRTU'.
      READ TABLE my_table_control-cols INTO gs_cols
      WITH KEY selected = abap_true.
      IF sy-subrc = 0.
        " MESSAGE 'Eine Spalte ist markiert' TYPE 'I'.
        IF ok_code = 'SRTD'.
          SORT gt_sdyn_book BY (gs_cols-screen-name+10) DESCENDING.   "gs_BOOK-FLDATE
        ELSE.
          SORT gt_sdyn_book BY (gs_cols-screen-name+10) ASCENDING.   "gs_BOOK-FLDATE
        ENDIF.
      ELSE.
        MESSAGE 'Es ist keine Spalte markiert' TYPE 'I'.
      ENDIF.
    WHEN 'SELE'.
      LOOP AT gt_sdyn_book INTO gs_sdyn_book WHERE mark = ' '.
        gs_sdyn_book-mark = 'X'.
        MODIFY gt_sdyn_book FROM gs_sdyn_book.
      ENDLOOP.
    WHEN 'DSELE'.
      LOOP AT gt_sdyn_book INTO gs_sdyn_book WHERE mark = 'X'.
        gs_sdyn_book-mark = ' '.
        MODIFY gt_sdyn_book FROM gs_sdyn_book.
      ENDLOOP.
  ENDCASE.
ENDMODULE.
