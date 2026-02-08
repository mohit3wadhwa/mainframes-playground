      ******************************************************************
      *        PROGRAM NAME            : HELLOCOBOL                    *
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
             05 WS-COMPANY      OCCURS 05 TIMES INDEXED BY I.                 
                   10 WS-COMPANY-CODE PIC 9(6).
                   10 WS-COMPANY-NAME PIC X(10).
      *       05 WS-MONTH PIC X(3) OCCURS 12 TIMES INDEXED BY I.
    
       01 WS-COUNT     PIC 99 VALUE 00.
       01 WS-STRING    PIC X(10).                                             

       PROCEDURE DIVISION.
           MOVE "123456INFOSYS   909090CAPGEMINI 787878ACCENTURE 666666G     
      -    "ENPACT   444444VIRTUSA   " TO WS-COMPANIES                 
           MOVE 'INFOSYS   '    TO WS-STRING
           PERFORM SEARCH-STRING-PARA
           STOP RUN
           .
           
       SEARCH-STRING-PARA.
           SET I TO 1
           SEARCH WS-COMPANY
           AT END DISPLAY 'STRING NOT FOUND'
           WHEN WS-COMPANY-NAME(I) = WS-STRING
                DISPLAY WS-COMPANY-NAME(I) ' FOUND!'
                DISPLAY WS-COMPANY-CODE(I) ' IS THE CORR. COMPANY CODE'
           END-SEARCH
           .
