      ******************************************************************
      *        PROGRAM NAME            : HELLOCOBOL                    *
      *        DESCRIPTION             : SAYS "HELLO" TO USER IN SPOOL *
      *        CREDITS                 : EDUCATORS AND TRAINERS        *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILEACCESS.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
           SELECT FLE1 ASSIGN TO "WJCL1.txt"      
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL. 

           SELECT FLE2 ASSIGN TO "OUT.txt"      
           ORGANIZATION IS LINE SEQUENTIAL.                            
       
       DATA DIVISION.
       FILE SECTION.
       FD FLE1.
       01 FD-VAR       PIC X(80).

       FD FLE2.
       01 FD-VAR-OUT   PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-VAR       PIC X(80).
       01 WS-COUNT     PIC 99 VALUE 00.
       01 WS-EOF-STA   PIC X.
           88 WS-EOF   VALUE 'Y'.
           88 WS-N-EOF VALUE 'N'.                                             

       PROCEDURE DIVISION.
           SET WS-N-EOF TO TRUE
      *    INITIALIZE WS-COUNT
           OPEN INPUT FLE1
           OPEN OUTPUT FLE2
           PERFORM READ-FILE-PARA UNTIL WS-EOF
           CLOSE FLE1
           CLOSE FLE2
           STOP RUN
           .

       READ-FILE-PARA.
      *    DISPLAY "NO OF RECORDS: " WS-COUNT
           INITIALIZE WS-VAR
                      FD-VAR-OUT
           READ FLE1 
           AT END SET WS-EOF TO TRUE
           NOT AT END 
           MOVE FD-VAR TO WS-VAR
                          FD-VAR-OUT
           IF WS-VAR(3:8) = 'JAVAPROG' THEN
              WRITE FD-VAR-OUT
           END-IF
           DISPLAY WS-VAR
           COMPUTE WS-COUNT = WS-COUNT + 1
           END-READ
           .
           
