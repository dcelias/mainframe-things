       IDENTIFICATION DIVISION.
       PROGRAM-ID. RETSPACE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  WS-FIELDS.
           05  WSTRING       PIC X(80) VALUE SPACES.
           05  WSTRING2      PIC X(80) VALUE SPACES.
           05  WTAM          PIC S9(06) COMP VALUE ZEROS.
           05  WQTD          PIC S9(06) COMP VALUE ZEROS.
           05  IN1           PIC S9(06) COMP VALUE ZEROS.
           05  IN2           PIC S9(06) COMP VALUE ZEROS.
           05  WFL-FASE      PIC  9(01) VALUE ZEROS.

       LINKAGE SECTION.
       PROCEDURE DIVISION.
       
       RTR-PRINCIPAL.
           MOVE '  RUN RUN   PROGRAM (ZI0BT01)  '
                             TO   WSTRING
      *     DISPLAY 'String com espacos em excesso: ' WSTRING
      *     PERFORM RTR-RETIRA-ESPACOS.
           
           PERFORM RTR-VALIDA-COMANDO.

           GOBACK.

      * RTR-RETIRA-ESPACOS.
*
      *     MOVE LENGTH OF WSTRING TO WTAM
      *     DISPLAY 'Tamanho da String            : ' WTAM
      *     MOVE 1 TO WQTD
*
      *     PERFORM VARYING IN1 FROM 1 BY 1 
      *               UNTIL IN1 GREATER WTAM  
      *             IF WSTRING(IN1:1)  NOT EQUAL SPACE
      *                DISPLAY 'Posicao nao tem espaco, moveu: '
      *                WSTRING(IN1:1)
      *                ADD 1 TO IN2 
      *                MOVE WSTRING(IN1:1) TO WSTRING2(IN2:1)
      *                MOVE 1 TO WQTD
      *             ELSE 
      *                IF WQTD EQUAL 1 AND WSTRING(IN1 + 1 : 1) 
      *                    NOT EQUAL '('
      *                   DISPLAY 'Primeiro espaco da posicao'
      *                   ADD 1 TO IN2 
      *                   MOVE WSTRING(IN1:1) TO WSTRING2(IN2:1) 
      *                   ADD  1 TO WQTD
      *                END-IF   
      *             END-IF   
      *     END-PERFORM.
           
      *     DISPLAY 'String sem espacos em excesso: ' WSTRING2.

           RTR-VALIDA-COMANDO.

           MOVE    1 TO WFL-FASE
           MOVE LENGTH OF WSTRING TO WTAM
           PERFORM VARYING IN1 FROM 1 BY 1 
                     UNTIL IN1 GREATER WTAM  
                   IF WSTRING(IN1:1)  NOT EQUAL SPACE
                      EVALUATE WFL-FASE
                          WHEN 1
                            IF WSTRING(IN1:4) NOT EQUAL 'RUN ' 
                               DISPLAY 'Erro 1: Cade o comando RUN?'
                               GOBACK
                            ELSE 
                               display 'o comando esta correto'
                               ADD 4 TO IN1 
                               MOVE 2 TO WFL-FASE
                            END-IF 
                          WHEN 2
                            IF WSTRING(IN1:8) NOT EQUAL 'PROGRAM(' 
                               DISPLAY 'Erro 2: Cade o comando PROGRAM?'
                               GOBACK
                            ELSE 
                               display 'o comando esta correto'
                               ADD 8 TO IN1 
                               MOVE 3 TO WFL-FASE
                            END-IF 
                       END-EVALUATE
           END-PERFORM.

       END PROGRAM RETSPACE.
