         PRINT NOGEN
DCEBR14  CSECT
         SAVE  (14,12)
         BASR  R12,0
         USING *,R12
         ST    R13,SAVEA+4
         LA    R13,SAVEA
         WTO   'DCEBR14 INVOKED'
         L     R13,SAVEA+4
         RETURN (14,12),RC=0
SAVEA    DS    18F
R12      EQU 12
R13      EQU 13
R14      EQU 14
         END ,
