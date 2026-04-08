       ID DIVISION.                                                     00010000
       PROGRAM-ID. MATCHLP1.                                            00020003
       AUTHOR. ANIL POLSANI.                                            00030000
       DATE-WRITTEN. TODAY.                                             00040000
                                                                        00050000
       ENVIRONMENT DIVISION.                                            00060000
       INPUT-OUTPUT SECTION.                                            00070000
       FILE-CONTROL.                                                    00080000
           SELECT  TRAN-INFILE   ASSIGN  TO TRANSDD1                    00090000
           ORGANIZATION  IS SEQUENTIAL                                  00100000
           ACCESS MODE IS SEQUENTIAL                                    00110000
           FILE STATUS  IS WS-TF-STATUS.                                00120000
                                                                        00130000
           SELECT  MAST-INFILE   ASSIGN  TO MASTDD01                    00140000
           ORGANIZATION  IS SEQUENTIAL                                  00150000
           ACCESS MODE IS SEQUENTIAL                                    00160000
           FILE STATUS  IS WS-MF-STATUS.                                00170000
                                                                        00180000
           SELECT  BILL-OTFILE   ASSIGN  TO BILLDD01                    00190000
           ORGANIZATION  IS SEQUENTIAL                                  00200000
           ACCESS MODE IS SEQUENTIAL                                    00210000
           FILE STATUS  IS WS-BF-STATUS.                                00220000
                                                                        00230000
       DATA DIVISION.                                                   00240000
       FILE SECTION.                                                    00250000
       FD TRAN-INFILE                                                   00260000
           LABEL RECORD ARE STANDARD.                                   00270000
       COPY TRANCPY2.                                                   00280000
                                                                        00290000
       FD MAST-INFILE                                                   00300000
           LABEL RECORD ARE STANDARD.                                   00310000
       COPY MASTCPY1.                                                   00320000
                                                                        00330000
       FD BILL-OTFILE                                                   00340000
           LABEL RECORD ARE STANDARD.                                   00350000
       COPY BILLCPY1.                                                   00360000
                                                                        00370000
       WORKING-STORAGE SECTION.                                         00380000
       01  WS-TF-STATUS       PIC   X(02)  VALUE SPACE.                 00390000
       01  WS-MF-STATUS       PIC   X(02)  VALUE SPACE.                 00400000
       01  WS-BF-STATUS       PIC   X(02)  VALUE SPACE.                 00410000
                                                                        00420000
       01  WS-END-OF-TFILE     PIC   X(01)  VALUE SPACE.                00430000
       01  WS-END-OF-MFILE     PIC   X(01)  VALUE SPACE.                00440000
                                                                        00450000
       01  WS-IN-REC-CNT       PIC   9(02)  VALUE ZERO.                 00460000
       01  WS-OT-REC-CNT       PIC   9(02)  VALUE ZERO.                 00470000
       01  WS-ABENDPGM         PIC   X(08)  VALUE 'ABENDPGM'.           00480000
                                                                        00480101
       01  WS-TOTL-DUE-2-PAY    PIC  S9(05)V9(02)  VALUE ZERO.          00481001
       01  WS-PREV-DUE-AMT      PIC  S9(05)V9(02)  VALUE ZERO.          00481101
       01  WS-DUE-INST          PIC  S9(05)V9(02)  VALUE ZERO.          00481201
       01  WS-MIN-DUE-AMT       PIC  S9(05)V9(02)  VALUE ZERO.          00482001
       01  WS-CURR-DATE-ALPNUM  PIC  X(08)  VALUE SPACE.                00483001
       01  WS-CURR-DATE-NUM     PIC  9(08)  VALUE ZERO.                 00483101
       01  WS-DUE-DATE          PIC  9(08)  VALUE ZERO.                 00484001
       01  WS-DUE-DATE-ALPNUM   PIC  X(08)  VALUE SPACE.                00484101
       01  WS-NUM-OF-DAYS       PIC  9(08)  VALUE ZERO.                 00485001
                                                                        00490000
       PROCEDURE DIVISION.                                              00500000
       000-MAIN-PARA.                                                   00510000
           DISPLAY 'MATCHLP1 STARTED'.                                  00520003
                                                                        00530000
           PERFORM  100-INITIAL-PARA   THRU 100-EXIT                    00540000
           PERFORM  200-GET-INPUT-PARA  THRU 200-EXIT                   00550000
           PERFORM  300-PROCESS-PARA   THRU 300-EXIT                    00560000
                          UNTIL  WS-END-OF-TFILE  = 'Y'.                00570000
                                                                        00580000
           CLOSE  TRAN-INFILE  MAST-INFILE  BILL-OTFILE.                00590000
           DISPLAY  'TOTAL  INPUT RECORD COUNT ' WS-IN-REC-CNT.         00600000
           DISPLAY  'TOTAL  OTPUT RECORD COUNT ' WS-OT-REC-CNT.         00610000
           STOP RUN.                                                    00620000
                                                                        00630000
       100-INITIAL-PARA.                                                00640000
           MOVE   'N'    TO   WS-END-OF-TFILE.                          00650000
           MOVE   'N'    TO   WS-END-OF-MFILE.                          00660000
                                                                        00670000
           MOVE  ZERO    TO  WS-IN-REC-CNT  WS-OT-REC-CNT.              00680000
                                                                        00690000
           OPEN  INPUT  TRAN-INFILE  MAST-INFILE.                       00700000
           OPEN  OUTPUT BILL-OTFILE.                                    00710000
           IF  WS-MF-STATUS NOT = '00'  OR                              00720000
               WS-TF-STATUS NOT = '00'  OR                              00730000
               WS-BF-STATUS NOT = '00'                                  00740000
                  DISPLAY 'ERROR IN 100-PARA'                           00750000
                  DISPLAY 'STATUS CODE TRAN FILE IS ' WS-TF-STATUS      00760000
                  DISPLAY 'STATUS CODE MAST FILE IS ' WS-MF-STATUS      00761000
                  DISPLAY 'STATUS CODE BILL FILE IS ' WS-BF-STATUS      00762000
                  CALL WS-ABENDPGM                                      00770000
           END-IF.                                                      00780000
           INITIALIZE  TRANS-LAYOUT MASTER-LAYOUT BILL-LAYOUT.          00790002
       100-EXIT. EXIT.                                                  00800000
                                                                        00810000
       200-GET-INPUT-PARA.                                              00820000
           PERFORM  210-GET-TRAN-FILE-PARA  THRU 210-EXIT.              00830000
           PERFORM  220-GET-MAST-FILE-PARA  THRU 220-EXIT.              00840000
       200-EXIT. EXIT.                                                  00850000
                                                                        00860000
       210-GET-TRAN-FILE-PARA.                                          00870000
           READ TRAN-INFILE                                             00880000
             AT END                                                     00890000
                MOVE  'Y'   TO  WS-END-OF-TFILE                         00900000
                GO TO 210-EXIT.                                         00910000
           ADD +1   TO   WS-IN-REC-CNT.                                 00920000
       210-EXIT. EXIT.                                                  00930000
                                                                        00940000
       220-GET-MAST-FILE-PARA.                                          00950000
           READ MAST-INFILE                                             00960000
             AT END                                                     00970000
                MOVE  'Y'   TO  WS-END-OF-MFILE                         00980000
                GO TO 220-EXIT.                                         00990000
       220-EXIT. EXIT.                                                  01010000
                                                                        01020000
       300-PROCESS-PARA.                                                01030000
           IF CARD-NUMBER OF TRANS-LAYOUT = CARD-NUMBER OF              01040002
                                               MASTER-LAYOUT            01050000
              PERFORM 310-CAL-TOT-DUE-PARA  THRU 310-EXIT               01060000
              PERFORM 320-CAL-MIN-DUE-PARA  THRU 320-EXIT               01070000
              PERFORM 330-GET-DUE-DATE-PARA THRU 330-EXIT               01080000
              PERFORM 340-MOVE-WRITE-PARA   THRU 340-EXIT               01090000
              PERFORM 200-GET-INPUT-PARA    THRU 200-EXIT               01091000
           ELSE                                                         01100000
           IF CARD-NUMBER OF TRANS-LAYOUT > CARD-NUMBER OF              01110002
                                               MASTER-LAYOUT            01120000
               PERFORM 220-GET-MAST-FILE-PARA  THRU 220-EXIT            01130000
           ELSE                                                         01140000
               DISPLAY 'INVALID CARD-NUMBER IN TRANS-FILE'              01150000
               DISPLAY 'NO RECORD IN MASTER FILE '                      01160000
               DISPLAY 'CARD NUMBER IS  '  CARD-NUMBER OF TRANS-LAYOUT  01170000
               CALL WS-ABENDPGM                                         01180000
           END-IF                                                       01190000
           END-IF.                                                      01200000
       300-EXIT. EXIT.                                                  01210000
                                                                        01220001
       310-CAL-TOT-DUE-PARA.                                            01230001
            MOVE  ZERO   TO   WS-PREV-DUE-AMT                           01231001
                              WS-DUE-INST                               01232001
                              WS-TOTL-DUE-2-PAY.                        01233001
                                                                        01234001
            COMPUTE WS-PREV-DUE-AMT = PREVIOUS-DUE - PREVIOUS-DUE-PAID  01240001
            IF WS-PREV-DUE-AMT > 0                                      01250001
               COMPUTE WS-DUE-INST = WS-PREV-DUE-AMT * .15              01260001
            END-IF.                                                     01270001
            COMPUTE WS-TOTL-DUE-2-PAY =   WS-PREV-DUE-AMT  +            01280001
                                          WS-DUE-INST      +            01290001
                                          DUE-AMT-TO-PAY.               01300001
       310-EXIT. EXIT.                                                  01310001
                                                                        01320001
       320-CAL-MIN-DUE-PARA.                                            01330001
            MOVE   ZERO   TO   WS-MIN-DUE-AMT.                          01331001
            COMPUTE WS-MIN-DUE-AMT = WS-TOTL-DUE-2-PAY * .15.           01340001
       320-EXIT. EXIT.                                                  01350001
                                                                        01360001
       330-GET-DUE-DATE-PARA.                                           01370001
            MOVE FUNCTION CURRENT-DATE  TO  WS-CURR-DATE-ALPNUM.        01380001
            MOVE WS-CURR-DATE-ALPNUM    TO  WS-CURR-DATE-NUM.           01390001
                                                                        01400001
            COMPUTE WS-NUM-OF-DAYS  =  FUNCTION                         01410001
                         INTEGER-OF-DATE(WS-CURR-DATE-NUM)              01420001
            COMPUTE  WS-NUM-OF-DAYS = WS-NUM-OF-DAYS + 20.              01430001
            COMPUTE WS-DUE-DATE  = FUNCTION                             01440001
                        DATE-OF-INTEGER(WS-NUM-OF-DAYS).                01450001
                                                                        01460001
            MOVE  WS-DUE-DATE    TO   WS-DUE-DATE-ALPNUM.               01470001
       330-EXIT. EXIT.                                                  01480001
                                                                        01490001
       340-MOVE-WRITE-PARA.                                             01500001
            MOVE CARD-NUMBER OF MASTER-LAYOUT TO                        01510001
                       CARD-NUMBER OF  BILL-LAYOUT                      01520001
            MOVE CUST-NAME   OF MASTER-LAYOUT TO                        01530001
                       CUST-NAME OF  BILL-LAYOUT.                       01540001
            MOVE WS-TOTL-DUE-2-PAY      TO TOT-DUE-2-PAY                01550001
            MOVE WS-MIN-DUE-AMT         TO MIN-DUE-2-PAY                01560001
            MOVE WS-CURR-DATE-ALPNUM    TO BILLING-DATE                 01570001
            MOVE WS-DUE-DATE-ALPNUM     TO DUE-DATE.                    01580001
            WRITE BILL-LAYOUT.                                          01590001
            IF WS-BF-STATUS  NOT = '00'                                 01600001
                 DISPLAY  'ERROR IN  340-PARA'                          01610001
                 DISPLAY  'WRITE ERROR STATUS CODE IS ' WS-BF-STATUS    01620001
                 DISPLAY  'RECORD IS ' CARD-NUMBER OF MASTER-LAYOUT     01630001
                 CALL  WS-ABENDPGM                                      01640001
            END-IF.                                                     01650001
            ADD +1   TO  WS-OT-REC-CNT.                                 01660001
       340-EXIT. EXIT.                                                  01670001

