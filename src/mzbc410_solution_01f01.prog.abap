*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_01F01
*&---------------------------------------------------------------------*
FORM on_ctmenu_sub130_menu
  USING p_menu TYPE REF TO cl_ctmenu.
  cl_ctmenu=>load_gui_status(
    EXPORTING
      program    = sy-cprog
      status     = 'SUB130'
*      disable    =
      menu       = p_menu ).



ENDFORM.
FORM on_ctmenu_dyn0100
  USING p_menu TYPE REF TO cl_ctmenu.

*  cl_ctmenu=>load_gui_status(
*    EXPORTING
*      program    = sy-cprog
*      status     = 'DYN0100'
**      disable    =
*      menu       = p_menu ).
  IF maintain_flights = 'X'.
  p_menu->add_function(
    EXPORTING
      fcode             = 'SAVE'    " Funktionscode
      text              = 'Datensatz in Tabelle updaten'    " Funktionstext
   ).
  ENDIF.




ENDFORM.
