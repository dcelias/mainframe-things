       IDENTIFICATION DIVISION.
       PROGRAM-ID. PARMS.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
        *> numbers we will perform operations on
        *> with verbs

       01 WPARM-TESTE-1     PIC  X(34) VALUE 
          'TEST,SSR(ZLEN,ABD),NOOPT,OPT(0)'.
       01 WPARM-TESTE-2     PIC  X(34) VALUE 
          'TEST(DAWRF),SSR(ZLEN,ABD),NOOPT'.  
       01 WPARM-TESTE-3     PIC  X(34) VALUE 
          'SSR(ZLEN,ABD),NOOPTMIZE'.   
       01 WPARM-TESTE-4     PIC  X(34) VALUE 
          'SSR(ZLEN,ABD),NOOPTMIZE'.  
       01 WPARM-TESTE-5     PIC  X(34) VALUE 
          'SSR(ZLEN,ABD,TESTE),OPT(1),NC'.  
       01 WPARM-TESTE-6     PIC  X(34) VALUE 
          'NONUMCHECK'.  
       01 WPARM-TESTE-7     PIC  X(34) VALUE 
          'NOSSR'. 
       01 WPARM-TESTE-8     PIC  X(34) VALUE 
          'NC(ZON(ALPHNUM),PAC,BIN,MSG)'. 

       01 WPARM-USR         PIC  X(34) VALUE SPACES.                
       01 FILLER REDEFINES WPARM-USR.
          03 WPARM-R        PIC  X(01) OCCURS 34 TIMES.
       01 WPARM-LISTA.
          03 WPARM-LISTA-L  PIC  X(34) OCCURS 34 TIMES.
  
       01 WIND-INI          PIC S9(06) COMP VALUE ZEROS.
       01 WIND-FIM          PIC S9(06) COMP VALUE ZEROS.
       01 WIND-1            PIC S9(06) COMP VALUE ZEROS.
       01 WIND-2            PIC S9(06) COMP VALUE ZEROS.
       01 WOPEN-SCOP        PIC S9(06) COMP VALUE ZEROS.
       01 WFL-ESCOPO        PIC  X(01)      VALUE SPACES.
       01 WTAM              PIC S9(06) COMP VALUE ZEROS.

       PROCEDURE DIVISION.

       RTR-PROCESS            SECTION.
           
           DISPLAY 'Begin of program'

           DISPLAY ' '
           DISPLAY 'TESTE 1  : ' WPARM-TESTE-1
           INITIALIZE WPARM-USR     
           MOVE WPARM-TESTE-1 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 2  : ' WPARM-TESTE-2
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-2 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 3  : ' WPARM-TESTE-3
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-3 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 4  : ' WPARM-TESTE-4
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-4 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 5  : ' WPARM-TESTE-5
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-5 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 6  : ' WPARM-TESTE-6
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-6 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 7  : ' WPARM-TESTE-7
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-7 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'TESTE 8  : ' WPARM-TESTE-8
           INITIALIZE WPARM-USR   
           MOVE WPARM-TESTE-8 TO WPARM-USR 
           PERFORM RTR-CHECK-PARM

           DISPLAY ' '
           DISPLAY 'End of program'.

           STOP RUN.
       RTR-PROCESS-X.         EXIT.

       RTR-CHECK-PARM         SECTION.
           INITIALIZE           WPARM-LISTA
           MOVE 1            TO WIND-INI WIND-2  
           MOVE ZEROS        TO WIND-FIM WTAM  
                                WOPEN-SCOP
           
           INSPECT WPARM-USR TALLYING WTAM FOR CHARACTERS BEFORE '  '
           DISPLAY 'Length: ' WTAM
           PERFORM VARYING WIND-1 FROM 1 BY 1
                     UNTIL WIND-1 GREATER WTAM + 1         
               ADD  1  TO WIND-FIM
               EVALUATE WPARM-R(WIND-1)
                  WHEN ',' 
                  WHEN SPACES  
                       IF   WOPEN-SCOP EQUAL ZEROS
                            SUBTRACT 1 FROM WIND-FIM                      
                            MOVE WPARM-USR(WIND-INI : WIND-FIM) 
                                              TO  WPARM-LISTA-L(WIND-2)
                            DISPLAY 'Parameter (' WIND-2 '): ' 
                                    WPARM-LISTA-L(WIND-2)
                            
                            ADD  1            TO  WIND-2 WIND-FIM
                            ADD WIND-FIM      TO  WIND-INI 
                            MOVE ZEROS        TO  WIND-FIM                   
                       END-IF    
                  WHEN '('
                       ADD   1    TO   WOPEN-SCOP
                  WHEN ')'
                       SUBTRACT 1 FROM WOPEN-SCOP
               END-EVALUATE    
           END-PERFORM.
       RTR-CHECK-PARM-X.        EXIT.
    