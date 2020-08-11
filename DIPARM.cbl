       Identification Division.
       Program-id. Parms.
       Data Division.
       Working-storage Section.
        *> Numbers We Will Perform Operations On
        *> With Verbs

       01 Wparm-teste-1     Pic  X(34) Value 
          'Test,Ssr(Zlen,Abd),Noopt,Opt(0)'.
       01 Wparm-teste-2     Pic  X(34) Value 
          'Test(Dawrf),Ssr(Zlen,Abd),Noopt'.  
       01 Wparm-teste-3     Pic  X(34) Value 
          'Ssr(Zlen,Abd),Nooptmize'.   
       01 Wparm-teste-4     Pic  X(34) Value 
          'Ssr(Zlen,Abd),Nooptmize'.  
       01 Wparm-teste-5     Pic  X(34) Value 
          'Ssr(Zlen,Abd,Teste),Opt(1),Nc'.  
       01 Wparm-teste-6     Pic  X(34) Value 
          'Nonumcheck'.  
       01 Wparm-teste-7     Pic  X(34) Value 
          'Nossr'. 
       01 Wparm-teste-8     Pic  X(34) Value 
          'Nc(Zon(Alphnum),Pac,Bin,Msg)'. 

       01 Wparm-usr         Pic  X(34) Value Spaces.                
       01 Filler Redefines Wparm-usr.
          03 Wparm-r        Pic  X(01) Occurs 34 Times.
       01 Wparm-lista.
          03 Wparm-lista-l  Pic  X(34) Occurs 34 Times.
  
       01 Wind-ini          Pic S9(06) Comp Value Zeros.
       01 Wind-fim          Pic S9(06) Comp Value Zeros.
       01 Wind-1            Pic S9(06) Comp Value Zeros.
       01 Wind-2            Pic S9(06) Comp Value Zeros.
       01 Wopen-scop        Pic S9(06) Comp Value Zeros.
       01 Wfl-escopo        Pic  X(01)      Value Spaces.
       01 Wtam              Pic S9(06) Comp Value Zeros.

       Procedure Division.

       Rtr-process            Section.
           
           Display 'Begin Of Program'

           Display ' '
           Display 'Teste 1  : ' Wparm-teste-1
           Initialize Wparm-usr     
           Move Wparm-teste-1 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 2  : ' Wparm-teste-2
           Initialize Wparm-usr   
           Move Wparm-teste-2 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 3  : ' Wparm-teste-3
           Initialize Wparm-usr   
           Move Wparm-teste-3 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 4  : ' Wparm-teste-4
           Initialize Wparm-usr   
           Move Wparm-teste-4 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 5  : ' Wparm-teste-5
           Initialize Wparm-usr   
           Move Wparm-teste-5 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 6  : ' Wparm-teste-6
           Initialize Wparm-usr   
           Move Wparm-teste-6 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 7  : ' Wparm-teste-7
           Initialize Wparm-usr   
           Move Wparm-teste-7 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'Teste 8  : ' Wparm-teste-8
           Initialize Wparm-usr   
           Move Wparm-teste-8 To Wparm-usr 
           Perform Rtr-check-parm

           Display ' '
           Display 'End Of Program'.

           Stop Run.
       Rtr-process-x.         Exit.

       Rtr-check-parm         Section.
           Initialize           Wparm-lista
           Move 1            To Wind-ini Wind-2  
           Move Zeros        To Wind-fim Wtam  
                                Wopen-scop
           
           Inspect Wparm-usr Tallying Wtam For Characters Before '  '
           Display 'Length: ' Wtam
           Perform Varying Wind-1 From 1 By 1
                     Until Wind-1 Greater Wtam + 1         
               Add  1  To Wind-fim
               Evaluate Wparm-r(Wind-1)
                  When ',' 
                  When Spaces  
                       If   Wopen-scop Equal Zeros
                            Subtract 1 From Wind-fim                      
                            Move Wparm-usr(Wind-ini : Wind-fim) 
                                              To  Wparm-lista-l(Wind-2)
                            Display 'Parameter (' Wind-2 '): ' 
                                    Wparm-lista-l(Wind-2)
                            
                            Add  1            To  Wind-2 Wind-fim
                            Add Wind-fim      To  Wind-ini 
                            Move Zeros        To  Wind-fim                   
                       End-if    
                  When '('
                       Add   1    To   Wopen-scop
                  When ')'
                       Subtract 1 From Wopen-scop
               End-evaluate    
           End-perform.
       Rtr-check-parm-x.        Exit.
    