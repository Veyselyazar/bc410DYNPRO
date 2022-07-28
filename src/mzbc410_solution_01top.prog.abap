*&---------------------------------------------------------------------*
*& Include MZBC410_SOLUTION_01TOP                            Modulpool        SAPMZBC410_SOLUTION_01
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZBC410_SOLUTION_01.
tables sdyn_conn.
data gs_sflight type sflight.
data ok_code type sy-ucomm.
data save_okcode type sy-ucomm.
data icon_termin type icons-text.
data rahmen3 type c LENGTH 50 value 'Anzeigefelder'.
data textfeld type int8.

data: view TYPE c LENGTH 1 value 'X',
      maintain_flights type c LENGTH 1,
      maintain_bookings type c LENGTH 1.

data: gv_plane type saplane-planetype,
      gv_max   type saplane-seatsmax.

tables saplane.
data dynnr type sy-dynnr value '110'.
CONTROLS my_tabstrip type TABSTRIP.
controls my_table_control type TABLEVIEW USING SCREEN 130.
data gt_sdyn_book type TABLE OF sdyn_book.
data gs_sdyn_book type sdyn_book.
tables sdyn_book.
data not_cancelled type c value ' '.
data gv_raucher type c LENGTH 1.
