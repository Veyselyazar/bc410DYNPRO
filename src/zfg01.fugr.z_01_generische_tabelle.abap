FUNCTION Z_01_GENERISCHE_TABELLE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IT_TABELLE) TYPE  ANY TABLE
*"----------------------------------------------------------------------
FIELD-SYMBOLS <fs_table> type sorted TABLE.
FIELD-SYMBOLS <fs_line> type any.
assign it_tabelle to <fs_table>.

loop at <fs_table> ASSIGNING  <fs_line>.



ENDLOOP.




ENDFUNCTION.
