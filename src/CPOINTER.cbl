       id division.
       program-id. CPOINTER.
       author. Diego Correia Elias
      *----------------------------------------------------------------*
      *    Example of linked list using Language Environment utilities:
      *    1) Alloc memory trougth CEECRHP and CEEGTST to build 
      *    an linked list (10 itens) and display it
      *    2) Call subroutine DPOINTER to remove itens from linked list
      *    3) Display linked list after the remove to check if its ok!
      *----------------------------------------------------------------*
       data division.
       working-storage section.
       01  lcount            pic  9(4) usage display value 0.
       01  heapid            pic s9(9) binary value 0.
       01  nbytes            pic s9(9) binary.
       01  incr              pic s9(9) binary value 0.
       01  opts              pic s9(9) binary value 0.

       01  wend              pic  x(1) value 'y'.
       01  fc.
           05  filler        pic  x(8).
           copy CEEIGZCT.
           05  filler        pic  x(4).
       01  addrss usage is pointer value null.
       01  anchor usage is pointer value null.
       01  DPOINTER pic x(08) value 'DPOINTER'.

       linkage section.
           COPY  POINTERW.

       procedure division using pointerw-area list-item.
 
       rt-begin-processing.

           display ' '
           display '-----------------------------'
           display 'CPOINTER - Begin of program  '.
           display '-----------------------------'

      *    Alloc itens
           perform rt-get-storage

      *    Remove itens
           move 3  to qtd
           move 'item0002'  to tab-remove(1)
           move 'item0007'  to tab-remove(2)
           move 'item0010'  to tab-remove(3)
           call DPOINTER using pointerw-area list-item.

      *    List itens after remove operation
           perform rt-list-item.

           display ' '
           display '-----------------------------'
           display 'CPOINTER - End of program    '.
           display '-----------------------------'

           goback.

       rt-get-storage.

           move length of list-item to nbytes

           perform 10 times
             add 1 to lcount

             call "CEECRHP" using heapid, nbytes, incr, opts, fc
             perform rtr-consit-cee-return
             display "CPOINTER - Obtained " nbytes " increase of " incr
                     " options ares "       opts
                     " from heap number "   heapid

             call "CEEGTST" using heapid, nbytes, addrss , fc
             perform rtr-consit-cee-return
             display "CPOINTER - Obtained "  nbytes " bytes of "
                     " storage at location " addrss
                     " from heap number "    heapid

             if   first-item = null 
                  set first-item       to addrss
             else
                  set next-item        to addrss
             end-if

             set  address of list-item to addrss
             set  next-item            to null
              
             string "item" lcount
                    delimited by size into item

             display "CPOINTER - Allocated item : " item 
                     " on address " addrss
             display " "

           end-perform.

       rt-list-item.
           display ' '

           if    first-item  not = nulls
                 set address of list-item to first-item
                 move "n"    to wend
           end-if.

           display "CPOINTER - List of items that are still allocated: "

           perform until wend equal 'y'
              display item
              if    next-item not = nulls
                    set address of list-item to next-item
              else
                    move "y" to wend
              end-if
           end-perform.

           display "CPOINTER - End of list ".

       rtr-consit-cee-return.
           evaluate true
               when CEE0P2
                    display "CPOINTER - Heap storage control "
                            "information was damaged."
                    goback
               when CEE0PA
                    display "CPOINTER - The storage address in a free "
                            "storage (CEEFRST) request was not "
                            "recognized, or heap storage (CEECZST) "
                            "control information was damaged or The "
                            "initial size value supplied in a create "
                            "heap request was unsupported."
                    goback
               when CEE0P5
                    display "CPOINTER - The increment size value "
                            "supplied in a create heap request was "
                            "unsupported."
                    goback
               when CEE0P6
                    display "CPOINTER - The options value supplied in "
                            "a create heap request was unrecognized."
                    goback
               when CEE0PD
                    display "CPOINTER - Insufficient storage was "
                    display "available to satisfy a get storage "
                    display "request. "
                    goback
           end-evaluate.
