/* REXX: submit a simple JCL from TSO */
PARSE ARG jcldsn .
IF jcldsn = '' THEN DO
  SAY 'USAGE:  SUBMITJCL  your.jcl.dataset(member)'
  EXIT 8
END
ADDRESS TSO "SUBMIT" jcldsn
SAY 'SUBMITTED JCL:' jcldsn
EXIT 0
