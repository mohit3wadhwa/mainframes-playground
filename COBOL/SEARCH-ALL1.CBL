      ******************************************************************
      *        PROGRAM NAME            : HELLOCOBOL                    *
      *        DESCRIPTION             : SAYS "HELLO" TO USER IN SPOOL *
      *        CREDITS                 : EDUCATORS AND TRAINERS        *
      *        NOTE:-        NO SETTING OF INDEX REQUIRED              *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SRCHALL1.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.                          
       
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
      
       
       01 WS-COMPANIES.                 
             05 WS-COMPANY  OCCURS 05 TIMES ASCENDING 
                        KEY IS WS-COMPANY-NAME INDEXED BY I.   
                   10 WS-COMPANY-CODE PIC 9(6).
                   10 WS-COMPANY-NAME PIC X(10).
    
       01 WS-COUNT     PIC 99 VALUE 00.
       01 WS-STRING    PIC X(10).                                             

       PROCEDURE DIVISION.
           MOVE "123456INFOSYS   909090JAPGEMINI 787878KCCENTURE 666666L     
      -    "ENPACT   444444MIRTUSA   " TO WS-COMPANIES    
           DISPLAY '--> ' WS-COMPANIES        
           MOVE 'JAPGEMINI '    TO WS-STRING
           PERFORM SEARCH-STRING-PARA
           STOP RUN
           .
           
       SEARCH-STRING-PARA.
           SEARCH ALL WS-COMPANY
           AT END DISPLAY 'STRING NOT FOUND'
           WHEN WS-COMPANY-NAME(I) = WS-STRING
                DISPLAY WS-COMPANY-NAME(I) ' FOUND!'
                DISPLAY WS-COMPANY-CODE(I) ' IS THE CORR. COMPANY CODE'
           END-SEARCH
           .
