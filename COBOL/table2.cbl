      ******************************************************************
      *        PROGRAM NAME            : HELLOCOBOL                    *
      *        DESCRIPTION             : SAYS "HELLO" TO USER IN SPOOL *
      *        CREDITS                 : EDUCATORS AND TRAINERS        *
      *        TABLE/ARRAY USING INDEXES                               *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PLAYTABLE.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.                          
       
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 WS-YEAR.       
            05 WS-MONTH PIC X(3) OCCURS 12 TIMES INDEXED BY I.
    
       01 WS-COUNT     PIC 99 VALUE 00.
       01 WS-EOF-STA   PIC X.
           88 WS-EOF   VALUE 'Y'.
           88 WS-N-EOF VALUE 'N'.                                             

       PROCEDURE DIVISION.
           MOVE 'JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC' TO WS-YEAR
      *    MOVE 01    TO WS-COUNT
           DISPLAY 'RANDOM'
      *    SET I TO 1
           PERFORM SHOW-MONTH-PARA VARYING I FROM 1 BY 1 UNTIL I > 12
           STOP RUN
           .
           
       SHOW-MONTH-PARA.
           DISPLAY WS-MONTH(I)
      *    COMPUTE WS-COUNT = WS-COUNT + 1
           .
