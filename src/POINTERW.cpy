      *----------------------------------------------------------------*
      *    Communication Area to DPOINTER program
      *----------------------------------------------------------------*
        01 pointerw-area.
           05  first-item    usage is pointer.
           05  qtd           pic  9(02) comp.
           05  tab-remove    pic  x(08) occurs 0 to 10 times
                             depending on qtd indexed by ind.
        01 list-item.
           05  item          pic  x(08) usage display.
           05  next-item     usage is  pointer.
