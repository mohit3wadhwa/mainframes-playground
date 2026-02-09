IDENTIFICATION DIVISION.
PROGRAM-ID. COMPLOPT.

*> This program is intentionally simple; it is used to see
*> the effect of different COBOL compiler options such as:
*>   RENT / NORENT
*>   OPT(STD|FULL) / NOOPT
*>   TEST / NOTEST
*>   NUMCHECK / NONUMCHECK
*>   SSRANGE / NOSSRANGE
*> The behavior (performance, storage, runtime checks, debug info)
*> will change depending on the compile JCL you use.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
SOURCE-COMPUTER. IBM-ZOS.
OBJECT-COMPUTER. IBM-ZOS.

DATA DIVISION.
WORKING-STORAGE SECTION.

01  WS-NUMBER-OK        PIC 9(5) VALUE 12345.
01  WS-NUMBER-BAD       PIC 9(5) VALUE 99999.
01  WS-SMALL-TABLE.
    05 WS-TAB-ENTRY     PIC X(10) OCCURS 5 INDEXED BY IDX.

01  WS-IDX              PIC S9(4) COMP VALUE 1.

01  WS-MSG              PIC X(60).

PROCEDURE DIVISION.
MAIN-SECTION.

    MOVE 'ENTRY-1' TO WS-TAB-ENTRY (1).
    MOVE 'ENTRY-2' TO WS-TAB-ENTRY (2).
    MOVE 'ENTRY-3' TO WS-TAB-ENTRY (3).
    MOVE 'ENTRY-4' TO WS-TAB-ENTRY (4).
    MOVE 'ENTRY-5' TO WS-TAB-ENTRY (5).

    DISPLAY 'COMPLOPT PROGRAM STARTED'.

*>  Example for NUMCHECK / SSRANGE effects:
*>  - Accessing table with invalid subscript can be trapped with SSRANGE.
*>  - Invalid numeric data can be trapped with NUMCHECK.
    MOVE 1 TO WS-IDX.
    PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 5
       DISPLAY 'TABLE(' WS-IDX ')=' WS-TAB-ENTRY (WS-IDX)
    END-PERFORM.

*>  Deliberate out-of-range index to see effect of SSRANGE:
    MOVE 10 TO WS-IDX.
    DISPLAY 'ABOUT TO ACCESS OUT-OF-RANGE INDEX 10'.
    DISPLAY 'TABLE(10) = ' WS-TAB-ENTRY (WS-IDX).

*>  Simple arithmetic to see optimized vs non-optimized code
    ADD 1 TO WS-NUMBER-OK.
    DISPLAY 'WS-NUMBER-OK = ' WS-NUMBER-OK.

    MOVE 'NORMAL END OF COMPLOPT' TO WS-MSG.
    DISPLAY WS-MSG.

    GOBACK.
