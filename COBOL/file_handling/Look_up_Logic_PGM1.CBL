000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. CBLPGM33.                                            00020000
000300 AUTHOR. UR NAME.                                                 00030000
000400 DATE-WRITTEN. TODAY.                                             00040000
000500                                                                  00050000
000600 ENVIRONMENT DIVISION.                                            00060000
000700 INPUT-OUTPUT SECTION.                                            00070000
000800 FILE-CONTROL.                                                    00080000
000900     SELECT LBDETAIL ASSIGN TO LBDDIN01                           00090000
001000     ORGANIZATION IS SEQUENTIAL                                   00100000
001100     ACCESS MODE IS SEQUENTIAL                                    00110000
001200     FILE STATUS IS WS-LBIN-STATUS.                               00120000
001300                                                                  00130000
001400     SELECT WGDETAIL ASSIGN TO LBDDIN02                           00140000
001500     ORGANIZATION IS SEQUENTIAL                                   00150000
001600     ACCESS MODE IS SEQUENTIAL                                    00160000
001700     FILE STATUS IS WS-WGIN-STATUS.                               00170000
001800                                                                  00180000
001900     SELECT PYCHKRPT ASSIGN TO LBDDOT01                           00190000
002000     ORGANIZATION IS SEQUENTIAL                                   00200000
002100     ACCESS MODE IS SEQUENTIAL                                    00210000
002200     FILE STATUS IS WS-LBOUT-STATUS.                              00220000
002300                                                                  00230000
002400 DATA DIVISION.                                                   00240000
002500 FILE SECTION.                                                    00250000
002600 FD LBDETAIL                                                      00260000
002700     LABEL RECORDS ARE STANDARD                                   00270000
002800     RECORDING MODE IS F                                          00280000
002900     RECORD CONTAINS 21 CHARACTERS                                00290000
003000     BLOCK CONTAINS 0 RECORDS.                                    00300000
003100 01 LABOUR-DETAILS.                                               00310000
003200  03 LABOUR-ID          PIC X(05).                                00320000
003300  03 LABOUR-NAME        PIC X(10).                                00330000
003400  03 LABOUR-RG-WORK-HRS PIC 9(02).                                00340000
003500  03 LABOUR-OT-WORK-HRS PIC 9(02).                                00350000
003600  03 LABOUR-WORK-TYPE   PIC X(02).                                00360000
003700                                                                  00370000
003800 FD WGDETAIL                                                      00380000
003900     LABEL RECORDS ARE STANDARD                                   00390000
004000     RECORDING MODE IS F                                          00400000
004100     RECORD CONTAINS 06 CHARACTERS                                00410002
004200     BLOCK CONTAINS 0 RECORDS.                                    00420000
004300 01 WG-DETAILS-IN.                                                00430000
004400   03 LABOUR-WORK-TYPEG PIC X(02).                                00440000
004500   03 RG-HR-PAY-AMTG    PIC 9(02).                                00450000
004600   03 OT-HR-PAY-AMTG    PIC 9(02).                                00460000
004700                                                                  00470000
004800 FD PYCHKRPT                                                      00480000
004900     LABEL RECORDS ARE STANDARD                                   00490000
005000     RECORDING MODE IS F                                          00500000
005100     RECORD CONTAINS 24 CHARACTERS                                00510002
005200     BLOCK CONTAINS 0 RECORDS.                                    00520000
005300 01 LABOUR-DETAILS-OT.                                            00530000
005400  03 LABOUR-ID             PIC X(05).                             00540000
005500  03 LABOUR-NAME           PIC X(10).                             00550000
005600  03 LABOUR-TOTAL-WORK-HRS PIC 9(02).                             00560000
005700  03 LABOUR-WORK-TYPE      PIC X(02).                             00570000
005800  03 LABOUR-TOTAL-SALARY   PIC 9(05).                             00580000
005900                                                                  00590000
006000 WORKING-STORAGE SECTION.                                         00600000
006100                                                                  00610000
006200 01 WS-LBIN-STATUS     PIC X(02) VALUE SPACE.                     00620000
006300 01 WS-WGIN-STATUS     PIC X(02) VALUE SPACE.                     00630000
006400 01 WS-LBOUT-STATUS    PIC X(02) VALUE SPACE.                     00640000
006500 01 WS-END-OF-FILE     PIC X(01) VALUE SPACE.                     00650000
006600 01 WS-END-WG-FILE     PIC X(01) VALUE SPACE.                     00660000
006700 01 WS-WORK-TYPE-FOUND PIC X(01) VALUE SPACE.                     00670001
006800                                                                  00680000
007100 01 WS-RG-WORK-AMT     PIC 9(02) VALUE ZERO.                      00690000
007200 01 WS-OT-WORK-AMT     PIC 9(02) VALUE ZERO.                      00700000
007300 01 WS-TOTAL-RG-AMT    PIC 9(04) VALUE ZERO.                      00710000
007400 01 WS-TOTAL-OT-AMT    PIC 9(04) VALUE ZERO.                      00720000
       01 WS-LABOUR-TOTAL-SALARY PIC 9(05) VALUE ZERO.                  00730000
007500                                                                  00740000
008100 01 SUB   PIC  9(01) VALUE ZERO.                                  00750000
008200 01 WS-ABENDPGM   PIC  X(08) VALUE 'ABENDPGM'.                    00760000
007600 01 WS-WAGE-DETAILS.                                              00770000
007700   03 WG-DETAILS OCCURS 2 TIMES INDEXED BY IDX.                   00780000
007800     05 WS-LABOUR-WORK-TYPE PIC X(02).                            00790000
007900     05 WS-RG-HR-PAY-AMT    PIC 9(02).                            00800000
008000     05 WS-OT-HR-PAY-AMT    PIC 9(02).                            00810000
008300 PROCEDURE DIVISION.                                              00820000
008400 0000-MAIN-PARA.                                                  00830000
008500     PERFORM 1000-INITIAL-PARA THRU 1000-EXIT.                    00840000
           PERFORM 1700-GET-LB-PARA THRU 1700-EXIT.                     00850000
008600     PERFORM 2000-PROCESS-PARA THRU 2000-EXIT                     00860000
008700                   UNTIL WS-END-OF-FILE = 'Y'.                    00870000
008800     CLOSE LBDETAIL WGDETAIL PYCHKRPT.                            00880000
008900     STOP RUN.                                                    00890000
009000                                                                  00900000
009100 1000-INITIAL-PARA.                                               00910000
009200     MOVE 'N' TO WS-END-OF-FILE.                                  00920000
009300     MOVE 'N' TO WS-END-WG-FILE.                                  00930000
009400     MOVE 'Y' TO WS-WORK-TYPE-FOUND.                              00940000
009500                                                                  00950000
009600     OPEN INPUT LBDETAIL, WGDETAIL.                               00960000
009700     OPEN OUTPUT PYCHKRPT.                                        00970000
009800      IF WS-LBIN-STATUS NOT = '00' OR                             00980000
009900         WS-WGIN-STATUS NOT = '00' OR                             00990000
010000         WS-LBOUT-STATUS NOT = '00'                               01000000
010100       DISPLAY 'ERROR IN 1000-PARA TO OPEN FILE '                 01010000
010200       DISPLAY 'STATUS CODES  ARE ' WS-LBIN-STATUS ' '            01020000
010300                        WS-WGIN-STATUS ' ' WS-LBOUT-STATUS        01030000
             CALL WS-ABENDPGM                                           01040000
010500      END-IF.                                                     01050000
010600      PERFORM 1500-BLD-WAGE-TABLE-PARA THRU 1500-EXIT             01060001
010700        UNTIL WS-END-WG-FILE = 'Y'.                               01070000
010800                                                                  01080000
010900  1000-EXIT. EXIT.                                                01090000
011000                                                                  01100000
011100 1500-BLD-WAGE-TABLE-PARA.                                        01110001
011200     READ WGDETAIL                                                01120000
011300        AT END MOVE 'Y' TO WS-END-WG-FILE                         01130000
011400         GO TO 1500-EXIT.                                         01140000
011500     ADD +1 TO SUB.                                               01150000
011600                                                                  01160000
011700     MOVE LABOUR-WORK-TYPEG TO WS-LABOUR-WORK-TYPE (SUB)          01170000
011800     MOVE RG-HR-PAY-AMTG TO WS-RG-HR-PAY-AMT (SUB)                01180000
011900     MOVE OT-HR-PAY-AMTG TO WS-OT-HR-PAY-AMT (SUB).               01190000
012000                                                                  01200000
012100 1500-EXIT. EXIT.                                                 01210000
                                                                        01220000
012200 1700-GET-LB-PARA.                                                01230000
012500     READ LBDETAIL                                                01240000
012600         AT END                                                   01250000
012700           MOVE 'Y' TO WS-END-OF-FILE                             01260000
012800         GO TO 2000-EXIT.                                         01270000
009800      IF WS-LBIN-STATUS NOT = '00'                                01280000
010100       DISPLAY 'ERROR IN 2000-PARA TO READ LABOUR FILE '          01290000
010200       DISPLAY 'STATUS CODE IS ' WS-LBIN-STATUS                   01300000
010400       CALL WS-ABENDPGM                                           01310000
010500      END-IF.                                                     01320000
       1700-EXIT. EXIT.                                                 01330000
                                                                        01340000
012300 2000-PROCESS-PARA.                                               01350000
012900     MOVE 'Y'  TO WS-WORK-TYPE-FOUND.                             01360003
013000     PERFORM 2600-GET-WAGE-DETAILS-PARA THRU 2600-EXIT.           01370000
013100     IF WS-WORK-TYPE-FOUND = 'Y'                                  01380000
013200                                                                  01390000
013300      COMPUTE LABOUR-TOTAL-WORK-HRS =                             01400000
013300                   LABOUR-RG-WORK-HRS + LABOUR-OT-WORK-HRS        01410000
013400      COMPUTE WS-TOTAL-RG-AMT =                                   01420000
013400                    LABOUR-RG-WORK-HRS * WS-RG-WORK-AMT           01430000
013500      COMPUTE WS-TOTAL-OT-AMT =                                   01440000
013500                    LABOUR-OT-WORK-HRS * WS-OT-WORK-AMT           01450000
013600      COMPUTE WS-LABOUR-TOTAL-SALARY =                            01460000
013600                          WS-TOTAL-RG-AMT + WS-TOTAL-OT-AMT       01470000
013700      PERFORM 2700-WRITE-OUTPUT-PARA THRU 2700-EXIT               01480000
013800     ELSE                                                         01490000
013900      DISPLAY 'ERROR WITH INPUT LABOUR DATA '                     01500000
014000      DISPLAY 'INVALID WORK-TYPE INPUT ' LABOUR-DETAILS           01510000
014100     END-IF.                                                      01520000
014200     PERFORM 1700-GET-LB-PARA  THRU 1700-EXIT.                    01530000
014300 2000-EXIT. EXIT.                                                 01540000
014310                                                                  01550000
014400 2600-GET-WAGE-DETAILS-PARA.                                      01560000
014500     SET IDX TO 1.                                                01570000
014600                                                                  01580000
014700     SEARCH WG-DETAILS                                            01590000
014800       AT END                                                     01600000
014900         MOVE 'N' TO WS-WORK-TYPE-FOUND                           01610000
015100      WHEN LABOUR-WORK-TYPE OF LABOUR-DETAILS                     01620000
015100                             = WS-LABOUR-WORK-TYPE (IDX)          01630000
015200        MOVE WS-RG-HR-PAY-AMT (IDX) TO  WS-RG-WORK-AMT            01640000
015300        MOVE WS-OT-HR-PAY-AMT (IDX) TO  WS-OT-WORK-AMT            01650000
015500     END-SEARCH.                                                  01660000
015600                                                                  01670000
015700 2600-EXIT. EXIT.                                                 01680000
015800                                                                  01690000
015900 2700-WRITE-OUTPUT-PARA.                                          01700000
016000     MOVE LABOUR-ID OF LABOUR-DETAILS                             01710000
016000                        TO LABOUR-ID OF LABOUR-DETAILS-OT.        01720000
016300     MOVE LABOUR-NAME OF LABOUR-DETAILS                           01730000
016300                        TO LABOUR-NAME OF LABOUR-DETAILS-OT.      01740000
016300     MOVE LABOUR-WORK-TYPE OF LABOUR-DETAILS                      01750000
016400                        TO LABOUR-WORK-TYPE OF LABOUR-DETAILS-OT. 01760000
016500     MOVE WS-LABOUR-TOTAL-SALARY                                  01770000
016500                   TO LABOUR-TOTAL-SALARY OF LABOUR-DETAILS-OT.   01780000
016600     WRITE LABOUR-DETAILS-OT.                                     01790000
009800     IF WS-LBOUT-STATUS NOT = '00'                                01800000
010100       DISPLAY 'ERROR IN 2700-PARA TO WRITE LB-OUTFILE  '         01810000
010200       DISPLAY 'STATUS CODE IS ' WS-LBOUT-STATUS                  01820000
010400       CALL WS-ABENDPGM                                           01830000
010500     END-IF.                                                      01840000
016700                                                                  01850000
016800 2700-EXIT. EXIT.                                                 01860000

