//RECEIVEZ JOB IBMUSER,ELIADIE,NOTIFY=&SYSUID,
//   MSGCLASS=X,MSGLEVEL=(1,1),REGION=0M,TIME=(05,00)
//*
//******************************************
//* RECEIVE FILES
//******************************************
//ASMCPY     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.ASMCPY')
  DATASET('SYSP.CMNZMF.V8R2P03.ASMCPY')
//*
//ASMSRC     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.ASMSRC')
  DATASET('SYSP.CMNZMF.V8R2P03.ASMSRC')
//*
//CEXECVB     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.CEXECVB')
  DATASET('SYSP.CMNZMF.V8R2P03.CEXECVB')
//*
//CLIST     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.CLIST')
  DATASET('SYSP.CMNZMF.V8R2P03.CLIST')
//*
//CNTL     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.CNTL')
  DATASET('SYSP.CMNZMF.V8R2P03.CNTL')
//*
//DBRMLIB     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.DBRMLIB')
  DATASET('SYSP.CMNZMF.V8R2P03.DBRMLIB')
//*
//ERR     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.ERR')
  DATASET('SYSP.CMNZMF.V8R2P03.ERR')
//*
//LOAD     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.LOAD')
  DATASET('SYSP.CMNZMF.V8R2P03.LOAD')
//*
//MESSAGES     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.MESSAGES')
  DATASET('SYSP.CMNZMF.V8R2P03.MESSAGES')
//*
//PANELS     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.PANELS')
  DATASET('SYSP.CMNZMF.V8R2P03.PANELS')
//*
//REX     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.REX')
  DATASET('SYSP.CMNZMF.V8R2P03.REX')
//*
//SAMPLES     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.SAMPLES')
  DATASET('SYSP.CMNZMF.V8R2P03.SAMPLES') SPACE(50 10)
//*
//SKELS     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.CMNZMF.V8R2P03.SKELS')
  DATASET('SYSP.CMNZMF.V8R2P03.SKELS')
//*
//ASMCPY     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.ASMCPY')
  DATASET('SYSP.SERCOMC.V8R2P03.ASMCPY')
//*
//ASMSRC     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.ASMSRC')
  DATASET('SYSP.SERCOMC.V8R2P03.ASMSRC')
//*
//CEXEC     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.CEXEC')
  DATASET('SYSP.SERCOMC.V8R2P03.CEXEC')
//*
//CLIST     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.CLIST')
  DATASET('SYSP.SERCOMC.V8R2P03.CLIST')
//*
//CNTL     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.CNTL')
  DATASET('SYSP.SERCOMC.V8R2P03.CNTL')
//*
//LOAD     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.LOAD')
  DATASET('SYSP.SERCOMC.V8R2P03.LOAD')
//*
//PANELS     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.PANELS')
  DATASET('SYSP.SERCOMC.V8R2P03.PANELS')
//*
//SKELS     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.SKELS')
  DATASET('SYSP.SERCOMC.V8R2P03.SKELS')
//*
//XML     EXEC  PGM=IKJEFT01,REGION=0M
//SYSTSPRT DD    SYSOUT=*
//SYSTSIN  DD    *
  RECEIVE INDATASET('SYST.SERCOMC.V8R2P03.XML')
  DATASET('SYSP.SERCOMC.V8R2P03.XML')
//*
