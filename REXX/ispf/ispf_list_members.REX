/* REXX */
/* ISPF exec: list members of a PDS using LM services
 * Usage from ISPF command line:
 *   TSO LISTMEM 'YOUR.HLQ.LIBRARY'
 */

PARSE UPPER ARG DSN .
IF DSN = '' THEN DO
  SAY "USAGE:  LISTMEM 'your.pds.name'"
  EXIT 8
END

ADDRESS ISPEXEC
"CONTROL ERRORS RETURN"

MEMDATAID = ''
MEMBER    = ''
RCODE     = 0

/* Initialize LM services for the given dataset */
"LMINIT DATAID("MEMDATAID") DATASET('"DSN"')"
IF RC <> 0 THEN DO
  SAY 'LMINIT FAILED FOR ' DSN ' RC=' RC
  EXIT RC
END

/* Open dataset */
"LMOPEN DATAID("MEMDATAID")"
IF RC <> 0 THEN DO
  SAY 'LMOPEN FAILED FOR ' DSN ' RC=' RC
  "LMFREE DATAID("MEMDATAID")"
  EXIT RC
END

/* Allocate ISPF table to show results */
"TBCREATE MEMLIST KEYS(MEMBER) NOWRITE REPLACE"
IF RC <> 0 THEN DO
  SAY 'TBCREATE FAILED RC=' RC
  "LMCLOSE DATAID("MEMDATAID")"
  "LMFREE  DATAID("MEMDATAID")"
  EXIT RC
END

/* Get first member name */
"LMMLIST DATAID("MEMDATAID") MEMBER("MEMBER")"
DO WHILE RC = 0
  MEMNAME = STRIP(MEMBER)
  IF MEMNAME <> '' THEN DO
    /* Put member name into table row */
    TBROW = 'MEMBER('''MEMNAME''')'
    "TBADD MEMLIST "TBROW
  END

  /* Get next member */
  "LMMLIST DATAID("MEMDATAID") MEMBER("MEMBER")"
END

/* Free LM list and close/free dataset */
"LMMLIST DATAID("MEMDATAID") OPTION(FREE)"
"LMCLOSE DATAID("MEMDATAID")"
"LMFREE  DATAID("MEMDATAID")"

/* Display table with standard ISPF panel */
"TBDISPLAY MEMLIST"

/* Delete table in memory */
"TBEND MEMLIST"

EXIT 0
