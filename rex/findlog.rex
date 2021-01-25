/* REXX */
rc=isfcalls('ON')
isfsysid="S0W1"
isddate="mmddyyyy /"
currday=date("C")
currday=currday-2
isflogstartdate=date("V",currday,"C")
isflogstarttime=time("N")
isflogstopdate=date("V")
isflogstoptime=time("N")
say 'Digite sua busca: '
pull srchitem
isffind = srchitem

isffindlim = 999999
isfscrolltype = 'FINDNEXT'
isflinelim = 1

do until isfnextlinetoken = ' '
    address SDSF "ISFLOG READ TYPE(SYSLOG)"
    lrc=rc
    if lrc > 4 then do
        call erromsg
        exit 20
    end
    do ix=1 to isfline.0
       say isfline.ix
    end
    isfstartlinetoken = isfnextlinetoken
end
rc = isfcalls("off")   

exit

errormsg: procedure expose isfmsg isfmsg2.
    if isfmsg <> "" then
        say "ERROR   :" isfmsg
        do ix=1 to isfmsg2.0
            say isfmsg2.ix
        end
return