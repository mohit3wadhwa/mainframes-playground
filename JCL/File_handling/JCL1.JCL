//IBMUSERX JOB NOTIFY=&SYSUID                                           00010000
//STEP1   EXEC PGM=MATCHLP1                                             00020001
//STEPLIB   DD DSN=IBMUSER.T5.LOAD,DISP=SHR                             00030001
//SYSPRINT  DD SYSOUT=*                                                 00040000
//SYSOUT    DD SYSOUT=*                                                 00050000
//TRANSDD1  DD DSN=IBMUSER.T5.CC.TRANS,DISP=SHR                         00060001
//MASTDD01  DD DSN=IBMUSER.T5.CC.MAST,DISP=SHR                          00070001
//BILLDD01  DD DSN=IBMUSER.T5.CC.BILLRPT,DISP=(NEW,CATLG,DELETE),       00080001
//    UNIT=3390,VOL=SER=JASYS1,                                         00090000
//    SPACE=(TRK,(1,1),RLSE),                                           00100000
//    DCB=(DSORG=PS,LRECL=45,RECFM=FB,BLKSIZE=0)                        00110000
//                                                                      00120000

