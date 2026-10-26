;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register

                mov   r0,#0x12                      ; (Anw-01) Bewege Konstante in r0 
                mov   r1,#-128                      ; (Anw-02) Bewege Negative-Konstante in r1
                ldr   r2,=0x12345678                ; (Anw-03) mov-Befehl zu klein(max.32-Bit für Befehl,Zieladresse und Ursprungadresse) => ldr-Befehl schreibt die zugroße Zahl ins Offset und über das pc-Register kann er dann die Zahl in das Register r2 laden

; Zugriff auf Variable
                ldr   r0,=VariableA                 ; (Anw-04) Läd Adresse von VarA in r0 (r0 wird überschrieben)
                ldrh  r1,[r0]                       ; (Anw-05) Läd den tatsächlichen Wert über die Adresse in r0 von VarA in r1 (r1 wird überschrieben)
                ldr   r2,[r0]                       ; (Anw-06) Läd 4 Bytes also VarA inhalt und noch mehr.
                str   r2,[r0,#VariableC-VariableA]  ; (Anw-07) Speichert den Wert von r2 an die Position "[r0,#VariableC-VariableA]"(Starte bei der beinhalteten Adresse von r0 und und gehe "Varc-VarA" schritte weiter, wobei beides Adressen darstellen(Errechnet passenden Indexer/Offet)). 

; Zugriff auf Felder (Speicherzellen)
                ldr   r0,=MeinHalbwortFeld          ; (Anw-08) Läd die Adresse von MeinHalbwortFeld in r0
                ldrh  r1,[r0]                       ; (Anw-09) Läd den tatsächlichen Wert, über die Adresse in r0, von MeinHalbwortFeld in r1(nur Halbword)
                ldrh  r2,[r0,#2]                    ; (Anw-10) Läd den Wert 2 Bytes weiter von der MeinHalbwortFeld-Variable in r2
                mov   r3,#10                        ; (Anw-11) Schreibt 10 in r3
                ldrh  r4,[r0,r3]                    ; (Anw-12) Läd den Wert, 10 Bytes weiter, in r4 (ausgehend vo Halbwörtern)

                ldrh  r5,[r0,#2]!                   ; (Anw-13) Läd 2-Byte in r5 den Wert, 2 Bytes weiter von der MeinHalbwortFeld-Variable und erhöht danach die Adresse in r0 um 2 Bytes
                ldrh  r6,[r0,#2]!                   ; (Anw-14) Läd 2-Bytein r6 den Wert, 4 Bytes weiter von der MeinHalbwortFeld-Variable und erhöht danach die Adresse in r0 wieder um 2 Bytes
                strh  r6,[r0,#2]!                   ; (Anw-15) Speichert den Wert von r6, 6 Bytes weiter von der MeinHalbwortFeld-Variable und erhöht danach die Adresse in r0 wieder um 2 Bytes (überschribt 78 mit -52)

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ldr  r0,=MeinWortFeld               ; (Anw-16) Läd Adresse von MeinWortFeld in r0
                ldr  r1,[r0]                        ; (Anw-17) Läd 4-Byte vom Inhalt von MeinWortFeld in r1.
                ldr  r2,[r0,#4]                     ; (Anw-18) Läd von r0 vier-Adressen weiter den Inhalt von MeinWortFeld in r2.
                adds r3,r1,r2                       ; (Anw-19) Addiert die Werte von r1 und r2 und speichert das Ergebnis in r3. (r3 = r1 + r2)

                ldr  r4,[r0,#8]                     ; (Anw-20) Läd von r0 acht-Adressen weiter den Inhalt von MeinWortFeld in r4
                ldr  r5,[r0,#12]                    ; (Anw-21) Läd von r0 zwölf-Adressen weiter den Inhalt von MeinWortFeld in r5
                subs r6,r4,r5                       ; (Anw-22) Subtrahiert den Wert in r5 vom Wert in r4 und speichert das Ergebnis in r6

                ldr  r7,[r0,#16]                    ; (Anw-23) Läd von r0 sechzehn-Adressen weiter den Inhalt von MeinWortFeld in r7
                ldr  r8,[r0,#20]                    ; (Anw-24) Läd von r0 zwanzig-Adressen weiter den Inhalt von MeinWortFeld in r8
                subs r9,r7,r8                       ; (Anw-25) Subtrahiert den Wert in r8 vom Wert in r7 und speichert das Ergebnis in r9

forever         b   forever                         ; (Anw-26) Erstellt eine Endlosschleife, die das Programm am Ende hält.
                ENDP
                END