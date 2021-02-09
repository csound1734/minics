<Cabbage>
define YELLOWSH colour(255,255,200)
define PINKSAND colour(255,205,180)
define SKYCOLOR colour(80,185,255)
define SEAWATER colour(0,200,180)
define WHITEFONT fontcolour("white")
bounds(0, 0, 0, 0)
form caption("miniCS") size(1420, 420), $PINKSAND, pluginid("def1")
image bounds(55,14,1310,29) $YELLOWSH {
        label text("presets") bounds(0,6,140,20) $PINKSAND fontcolour(5,10,5)
        label text("events") bounds(150,6,140,20) $PINKSAND fontcolour(5,10,5)
        label text("textin") bounds(490,6,140,20) $PINKSAND fontcolour(5,10,5)
        label text("console") bounds(900,6,140,20) $PINKSAND fontcolour(5,10,5)
}
image bounds(55,44,1310, 376) $YELLOWSH {
image bounds(10,10,80,40) $YELLOWSH {
        combobox bounds(0, 0, 40, 20) channeltype("string") populate("*.snaps") channel("preset_selection")
        filebutton bounds(0, 20, 40, 20) text("save") mode("snapshot") channel("save_preset")
}
keyboard bounds(530,280,700,95)  whitenotecolour(0,0,0) mouseoverkeycolour("white") blacknotecolour(255,205,180) keyseparatorcolour(255,205,180)
rslider channel("pitchbend") bounds(1260, 280,50,48) range(0,1,.5,1,.00001)
rslider channel("modulation") bounds(1260, 330,50,48) range(0,1,0,1,.00001)
csoundoutput bounds(900,0,400,180) $SKYCOLOR $WHITEFONT
texteditor channel("textin") wrap(1) bounds(490,0,400,180) $SEAWATER fontcolour(180,180,160)

image bounds(8,60,150,30) $PINKSAND {
        nslider channel("orc_3") text("orc 1") bounds(0,0,75,30) range(0,32674,0,1,1.00)
}

image bounds(168, 60, 150, 30) $PINKSAND {
        nslider channel("orc_2") text("orc 2") bounds(0, 0, 75, 30) range(0, 32674, 0, 1, 1)
}

image bounds(336,60,150,30) $PINKSAND {
        nslider channel("orc_3") text("orc 3")  bounds(0,0,75,30) range(0,32674,0,1,1.00)
}


encoder bounds(0,240,75,75) text("Mac-Enc-1") textcolour(85,170,85) $SEAWATER channel("macEnc1") range(0,1,0,1,.025)
encoder bounds(150,240,75,75) text("Mac-Enc-2") textcolour(85,170,85) $SEAWATER channel("macEnc2") range(0,1,0,1,.025)
encoder bounds(300,240,75,75) text("Mac-Enc-3") textcolour(85,170,85) $SEAWATER channel("macEnc3") range(0,1,0,1,.025)

rslider bounds(74,300,75,75) text("Mac-Rot-1") textcolour(85,170,85) $SEAWATER channel("macRot1") range(0,1,0,1,.025)
rslider bounds(224,300,75,75) text("Mac-Rot-2") textcolour(85,170,85) $SEAWATER channel("macRot2") range(0,1,0,1,.025)
rslider bounds(374,300,75,75) text("Mac-Rot-3") textcolour(85,170,85) $SEAWATER channel("macRot3") range(0,1,0,1,.025)

texteditor channel("textin_events") bounds(150, 0, 330, 50) wrap(1) $SEAWATER fontcolour(180,180,160)
}
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

;#define DEBUG #1#
ksmps = 32
nchnls = 2
alwayson 32

;       OPCODES
 opcode "changeEventk", i, kkOOO
kinstr, kinput, kp2, kp3, kp4 xin
if changed:k(kinput)==1 then
    event "i", kinstr, kp2, kp3, kp4
endif
xout 0;
endop
 opcode "changeEventkS", i, kSOOO
kinstr, Sinput, kp2, kp3, kp4 xin
if changed:k(Sinput)==1 then
    event "i", kinstr, kp2, kp3, kp4
endif
xout 0;
endop

;       GLOBAL VARIABLES
zakinit 256, 256
gStextin init 0
gSevents init 0

;       ALWAYSON
instr 32
        #ifdef DEBUG
printf_i "\n\n\n Initializing Instr %d \n\n\n", 1, p1
        #end
gSevents chnget "textin_events"
gStextin chnget "textin"
kmIn1, kmIn2, kmIn3, kmIn4 midiin
ires changeEventk 161, kmIn1, 0, 0, kmIn1
ires changeEventk 161, kmIn2, 0, 0, kmIn2
ires changeEventk 161, kmIn3, 0, 0, kmIn3
ires changeEventk 161, kmIn4, 0, 0, kmIn4
ires changeEventkS 129, gSevents
ires changeEventkS 197, gStextin
endin

;       STATE MODIFIERS
instr 197
        #ifdef DEBUG
printf_i "\n\n\n Initializing Instr %d \n\n\n", 1, p1
        #end
ires compilestr gStextin
printf_i "Compile result = %d", 1, ires
endin
instr 161
        #ifdef DEBUG
printf_i "\n\n\n Initializing Instr %d \n\n\n", 1, p1
        #end
printf_i "\n %f ", 1, p4
endin
instr 129
        #ifdef DEBUG
printf_i "\n\n\n Initializing Instr %d \n\n\n", 1, p1
        #end
scoreline_i gSevents
endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
