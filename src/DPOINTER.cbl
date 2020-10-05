       id division.
       program-id. DPOINTER initial.
       author. Diego Correia Elias
      *----------------------------------------------------------------*
      *    Example of a program that removes several items from a
      *    linked list using Language Environment utilities.
      *----------------------------------------------------------------*
       data division.
       working-storage section.
       01  wfim              pic x(1) value 'y'.
       01  fc.
           05  filler        pic x(8).
           copy CEEIGZCT.
           05  filler        pic x(4).
       01  msgdest           pic S9(9) binary value 2.
       01  atu-item          usage is pointer value null.
       01  ant-item          usage is pointer value null.
       01  next-item-aux     usage is pointer value null.

       linkage section.
           COPY  POINTERW.

       procedure division using pointerw-area list-item.
           display ' '
           display '-----------------------------'
           display 'DPOINTER - Begin of program  '.
           display '-----------------------------'

           if    first-item  not = nulls
      *          Posiciona memória no primeiro item da lista
                 set address of list-item to first-item
                 set atu-item             to first-item

      *          mostra como estao os ponteiros
                 display ' '
                 display 'DPOINTER - item: ' item
                 perform rt-display-pointers
                 move 'n'    to wfim
           end-if.

           perform until wfim equal 'y'

              perform varying ind  from 1 by 1
                                      until ind  greater qtd
                   perform rt-remove-item
              end-perform

              if    next-item not = nulls
      *             Salva o ponteiro como anterior e...
                    set ant-item to address of list-item

      *             ... vai para o proximo item!
                    set address of list-item to next-item
                    set atu-item to address of list-item

      *             mostra como estao os ponteiros
                    display ' '
                    display 'DPOINTER - item: ' item
                    perform rt-display-pointers
              else
                    move 'y' to wfim
              end-if
           end-perform.

           display ' '
           display '-----------------------------'
           display 'DPOINTER - End of program    '.
           display '-----------------------------'

           goback.

       rt-remove-item.
           if    item equal tab-remove(ind)
                 display ' '
                 display "DPOINTER - item: " item
                         " will be removed "
                 display "DPOINTER - Adjusting the pointers to "
                         "remove references to this occurrence:"
      *          Salva a referencia do proximo item que o item que
      *          estamos removendo apontava
                 set next-item-aux        to next-item

      *          Reposiciona a lista no item anterior ao que queremos
      *          remover
                 set address of list-item to ant-item

      *          Alteramos a referencia ao proximo item para nao
      *          referenciar mais o item que removemos e sim o proximo
                 set next-item            to next-item-aux
                 display "DPOINTER - The address of item (atu-item) "
                          ant-item
                         " now points to address of the next item "
                         "(atu-item) " next-item
                 perform rt-freestor
           end-if.

       rt-freestor.
           display "DPOINTER - Free storage for address " atu-item

           call "CEEFRST" using atu-item , fc.
           perform rtr-consit-cee-return.

       rt-display-pointers.
           display 'DPOINTER - address of first-item: ' first-item
           display 'DPOINTER - address of ant-item  : ' ant-item
           display 'DPOINTER - address of atu-item  : ' atu-item
           display 'DPOINTER - address of next-item : ' next-item.

       rtr-consit-cee-return.

           call "CEEMSG" using fc, msgdest, omitted
           if    not CEE000
                 goback
           end-if.       