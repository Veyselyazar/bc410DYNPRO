*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_01I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  save_okcode = ok_code.
  clear ok_code.

  CASE save_okcode.
    WHEN 'BACK' .
      DATA gv_answer TYPE c LENGTH 1.
      IF sy-datar = abap_true.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = 'Programm verlassen '
*           DIAGNOSE_OBJECT       = ' '
            text_question         = 'Möchten Sie wirklich beenden?'
            text_button_1         = 'Ja'(001)
            icon_button_1         = 'ICON_CHECKED'
            text_button_2         = 'Nein'(002)
            icon_button_2         = 'ICON_CANCEL'
            default_button        = '2'
            display_cancel_button = ' '
*           USERDEFINED_F1_HELP   = ' '
*           START_COLUMN          = 25
*           START_ROW             = 6
*           POPUP_TYPE            =
            iv_quickinfo_button_1 = 'Verlassen'
            iv_quickinfo_button_2 = 'Im Programm bleiben '
          IMPORTING
            answer                = gv_answer.
        CASE gv_answer.
          WHEN '1'.
            LEAVE TO SCREEN 0.
        ENDCASE.
      ELSE.
        LEAVE TO SCREEN 0.
      ENDIF.

    WHEN 'TIME'.
      CALL SCREEN 150
        STARTING AT 20 10
        ENDING AT   50 15.
    WHEN 'SAVE'.
      MOVE-CORRESPONDING sdyn_conn TO gs_sflight.
      UPDATE sflight FROM gs_sflight.
      IF sy-subrc = 0.
        MESSAGE 'Sflight wurde erfolgreich upgedated' TYPE 'S'.
      ELSE.
        MESSAGE 'Unbekannter Fehler bei Update SFLIGHT' TYPE 'X'.
      ENDIF.
   when 'FC_TAB1' or 'FC_TAB2' or 'FC_TAB3'.
         my_tabstrip-activetab = ok_code.  "Aktiven Reiter setzen
  ENDCASE.
ENDMODULE.

MODULE check_sflight INPUT.

  SELECT SINGLE * FROM sflight INTO gs_sflight
    WHERE carrid = sdyn_conn-carrid
      AND connid = sdyn_conn-connid
      AND fldate = sdyn_conn-fldate.
  IF sy-subrc <> 0.

    MESSAGE e007(bc410).
*    CLEAR: gs_sflight, sdyn_conn.
*    SET PARAMETER ID 'CAR' FIELD '   '. "gs_sflight-carrid.
*    SET PARAMETER ID 'CON' FIELD '0000'. "gs_sflight-connid.
*    SET PARAMETER ID 'DAY' FIELD '00000000'. "  sdyn_conn-fldate.
*    LEAVE TO SCREEN 100.
  ELSE.
*    SET SCREEN 100.
*    LEAVE  SCREEN .
    "Leave to screen 100
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  NICHTS_WIE_RAUS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE nichts_wie_raus INPUT.
  IF ok_code = 'FC_PUSH'.
    LEAVE PROGRAM.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CHECK_PLANETYPE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_planetype INPUT.
  SELECT SINGLE planetype, seatsmax FROM saplane
    INTO (@gv_plane, @gv_max)
    WHERE planetype = @sdyn_conn-planetype.
  IF sy-subrc = 0.
    IF gv_max >= sdyn_conn-seatsocc.
      MOVE: gv_plane TO gs_sflight-planetype,
            gv_max   TO gs_sflight-seatsmax.
      MESSAGE 'Der Flugzeugtyp wurde erfolgreich geändert' TYPE 'S'.
    ELSE.
      MESSAGE e109(bc410).
    ENDIF.

  ELSE.
    MESSAGE 'Flugzeugtyp eistiert nicht' TYPE 'E'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  FUTURE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE future INPUT.
  MESSAGE 'Wird in neuemr Release ausgeführt' TYPE 'I'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar       = 'Daten löschen '
          text_question  = 'Sie werden die erfassten Daten verlieren'
          default_button = '2'
        IMPORTING
          answer         = gv_answer.
      CASE gv_answer.
        WHEN '1'.
          CLEAR: gs_sflight, sdyn_conn.
          SET PARAMETER ID 'CAR' FIELD gs_sflight-carrid.
          SET PARAMETER ID 'CON' FIELD gs_sflight-connid.
          SET PARAMETER ID 'DAY' FIELD gs_sflight-fldate.
          LEAVE TO SCREEN 100.
      ENDCASE.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MESSAGE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE message INPUT.
 message 'PAI des 101 wird ausgeführt' type 'I'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  UPDATE_TABELLE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE update_tabelle INPUT.
    move-CORRESPONDING sdyn_book to gs_sdyn_book.

   modify gt_sdyn_book from gs_sdyn_book
   INDEX my_table_control-current_line
   TRANSPORTING mark luggweight.
ENDMODULE.
