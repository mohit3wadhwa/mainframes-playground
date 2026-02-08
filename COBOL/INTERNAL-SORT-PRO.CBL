       IDENTIFICATION DIVISION.
       PROGRAM-ID. SORTPRO.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL.
           SELECT INFILE   ASSIGN TO "IN.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT OUTFILE  ASSIGN TO "OUT.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT WORKFILE ASSIGN TO "WORK.txt"
           ORGANIZATION IS LINE SEQUENTIAL.  

       DATA DIVISION.
       FILE SECTION.

       FD INFILE.
       01 INREC.
           05 IN-EMP-ID         PIC 9(6).
           05 IN-EMP-NAME       PIC X(20).

       FD OUTFILE.
       01 OUTREC.
           05 OUT-EMP-ID         PIC 9(6).
           05 OUT-EMP-NAME       PIC X(20).
       
       SD WORKFILE.
       01 WORKREC.
           05 WK-EMP-ID         PIC 9(6).
           05 WK-EMP-NAME       PIC X(20).

       WORKING-STORAGE SECTION.
       01 WS-EOF            PIC X VALUE 'N'.
       01 WS-OUTREC.
           05 WS-OUT-EMP-ID         PIC 9(6).
           05 WS-OUT-EMP-NAME       PIC X(20).

       PROCEDURE DIVISION.
           DISPLAY 'INSIDE A COBOL PROGRAM FOR INTERNAL SORTING'
           
           SORT WORKFILE ON ASCENDING KEY OUT-EMP-ID
           USING INFILE GIVING OUTFILE.

           OPEN INPUT OUTFILE
           
           PERFORM UNTIL WS-EOF = 'Y'
              READ OUTFILE INTO WS-OUTREC
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END DISPLAY '--> ' WS-OUTREC
              END-READ
           END-PERFORM

           CLOSE OUTFILE

           STOP RUN
           .
