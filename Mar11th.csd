<CsoundSynthesizer>
<CsOptions>
--port=1234 -odac -+rtmidi=virtual -Ma --midi-key-cps=5 --midi-velocity-amp=4
</CsOptions>
; ==============================================
<CsInstruments>

sr	=	48000
ksmps	=	128
;nchnls	=	2
;0dbfs	=	1

instr 1	
ares vco2 p4/2, p5, 0, .5, .5
out ares
endin

instr 17
ifileN = p4
Sfile sprintf "%d.orc", ifileN ;file name is N.orc
ires compileorc Sfile          ;compile the code
if ires!=0 then                ;if unsuccessful...
printf "\nError! Attempted file %d \n Result: %d\n", 1, ires
endif
endin

instr 18
ifileN = p4
Sfile sprintf "%d.udo", ifileN ;file name is N.udo
ires compileorc Sfile          ;compile the code
if ires!=0 then                ;if unsuccessful...
printf "\nError! Attempted file %d \n Result: %d\n", 1, ires
endif
endin

instr 19
ifileN = p4
Sfile sprintf "%d", ifileN ;file name is N (no extension)
ires compileorc Sfile          ;compile the code
if ires!=0 then                ;if unsuccessful...
printf "\nError! Attempted file %d \n Result: %d\n", 1, ires
endif
endin

</CsInstruments>
; ==============================================
<CsScore>



</CsScore>
</CsoundSynthesizer>

