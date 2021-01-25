/* REXX */
rc=isfcalls('ON')
isfsysid="S0W1"
isddate="mmddyyyy /"
currday=date("C")
currday=currday-2
isflogstartdate=date("U",currday,"C")
isflogstarttime=time("N")
isflogstopdate=date("U")
isflogstoptime=time("N")
isffindlim = 999999
isfscrolltype = 'FINDNEXT'
isflinelim = 1
userid = SYSVAR(SYSUID)
data = date("S")
dataset = userid||'.LOGSERCH.'||'DT'||substr(data,3,6)
stat = MSG("OFF") 

if SYSDSN(dataset) = 'OK' then do
  say 'dataset exist'
  ADDRESS TSO "DEL '"dataset"' "
end

"ALLOC FI(outdd) DA('"dataset"') SHR REUSE SPACE(10,10) TRACKS DSORG(ps)
 RECFM(f b) LRECL(133) BLKSIZE(0)"

input = 0
count = 0

do until input == 1 | count >= 5
   say 'Digite sua busca: '
   pull  isffind
   count = count + 1

   if  isffind <> '' then do
       input = 1
       do until isfnextlinetoken = ' '
          address SDSF "ISFLOG READ TYPE(SYSLOG)"
          lrc=rc
          if lrc > 4 then do
             call erromsg
             exit 20
          end
          do ix=1 to isfline.0
             "EXECIO 1 DISKW outdd (STEM isfline. "
          end
          isfstartlinetoken = isfnextlinetoken
       end
   end    
end    

if count < 5 then
   say 'Resultado gravado em: ' dataset


rc = isfcalls("off")   

"EXECIO 0 DISKW outdd (FINIS"
"FREE FI(outdd)"

stat = MSG("ON") 
exit

errormsg: procedure expose isfmsg isfmsg2.
    if isfmsg <> "" then
        say "ERROR   :" isfmsg
        do ix=1 to isfmsg2.0
            say isfmsg2.ix
        end
return