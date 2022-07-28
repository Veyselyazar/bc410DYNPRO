*&---------------------------------------------------------------------*
*&  Include  Z01_TABSTRIP_WIZZARD_O01
*&---------------------------------------------------------------------*

*&SPWIZARD: OUTPUT MODULE FOR TS 'MY_TABSTRIP'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: SETS ACTIVE TAB
MODULE MY_TABSTRIP_ACTIVE_TAB_SET OUTPUT.
  MY_TABSTRIP-ACTIVETAB = G_MY_TABSTRIP-PRESSED_TAB.
  CASE G_MY_TABSTRIP-PRESSED_TAB.
    WHEN C_MY_TABSTRIP-TAB1.
      G_MY_TABSTRIP-SUBSCREEN = '0110'.
    WHEN C_MY_TABSTRIP-TAB2.
      G_MY_TABSTRIP-SUBSCREEN = '0120'.
    WHEN C_MY_TABSTRIP-TAB3.
      G_MY_TABSTRIP-SUBSCREEN = '0130'.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.