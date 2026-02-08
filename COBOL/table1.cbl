      ******************************************************************
      *        PROGRAM NAME            : TABLE_SNIPPET                 *
      *        DESCRIPTION             : SAYS "HELLO" TO USER IN SPOOL *
      *        CREDITS                 : EDUCATORS AND TRAINERS        *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PLAYTAB2.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.                          
       
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
      
       
       01 WS-COMPANIES.
             05 WS-COMPANY-COUNT      PIC 9(2).                  
             05 WS-COMPANY      OCCURS 1 TO 10 DEPENDING ON 
                                            WS-COMPANY-COUNT.   
                   10 WS-COMPANY-CODE PIC 9(6).
                   10 WS-COMPANY-NAME PIC X(10).
      *       05 WS-MONTH PIC X(3) OCCURS 12 TIMES INDEXED BY I.
    
       01 WS-COUNT     PIC 99 VALUE 00.
       01 WS-EOF-STA   PIC X.
           88 WS-EOF   VALUE 'Y'.
           88 WS-N-EOF VALUE 'N'.                                             

       PROCEDURE DIVISION.
      *     MOVE 'JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC' TO WS-YEAR
           MOVE "09123456INFOSYS   909090CAPGEMINI 787878ACCENTURE 66666     
      -    "6GENPACT   444444VIRTUSA   " TO WS-COMPANIES
      *    MOVE 01    TO WS-COUNT
           DISPLAY 'RANDOM'
      *    SET I TO 1
           PERFORM SHOW-MONTH-PARA VARYING WS-COUNT FROM 1 BY 1 
                           UNTIL WS-COUNT > WS-COMPANY-COUNT
           STOP RUN
           .
           
       SHOW-MONTH-PARA.
           DISPLAY WS-COMPANY-CODE(WS-COUNT)
           DISPLAY WS-COMPANY-NAME(WS-COUNT)
      *    COMPUTE WS-COUNT = WS-COUNT + 1
