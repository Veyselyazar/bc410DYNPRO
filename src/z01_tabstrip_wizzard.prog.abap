*&---------------------------------------------------------------------*
*& Report Z01_TABSTRIP_WIZZARD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_TABSTRIP_WIZZARD.


call screen 100.

*&SPWIZARD: FUNCTION CODES FOR TABSTRIP 'MY_TABSTRIP'
CONSTANTS: BEGIN OF C_MY_TABSTRIP,
             TAB1 LIKE SY-UCOMM VALUE 'FC_TAB1',
             TAB2 LIKE SY-UCOMM VALUE 'FC_TAB2',
             TAB3 LIKE SY-UCOMM VALUE 'FC_TAB3',
           END OF C_MY_TABSTRIP.
*&SPWIZARD: DATA FOR TABSTRIP 'MY_TABSTRIP'
CONTROLS:  MY_TABSTRIP TYPE TABSTRIP.
DATA:      BEGIN OF G_MY_TABSTRIP,
             SUBSCREEN   LIKE SY-DYNNR,
             PROG        LIKE SY-REPID VALUE 'Z01_TABSTRIP_WIZZARD',
             PRESSED_TAB LIKE SY-UCOMM VALUE C_MY_TABSTRIP-TAB1,
           END OF G_MY_TABSTRIP.
DATA:      OK_CODE LIKE SY-UCOMM.

*&SPWizard: Include inserted by SP Wizard. DO NOT CHANGE THIS LINE!
INCLUDE Z01_TABSTRIP_WIZZARD_O01 .
INCLUDE Z01_TABSTRIP_WIZZARD_I01 .
