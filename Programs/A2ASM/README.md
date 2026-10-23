Zeilen Beschreibung von Anw01 bis Anw06.

Ausgangslage:
- VariableA = 0xbeef
- VariableB = 0x1234
- ConstByteA = 0xaffe (const)

Programmcode:
ldr     R0,=VariableA   ; (Anw01) Nehme die RAM-Adresse von VariableA und lade sie in r0 rein. 
ldrb    R2,[R0]         ; (Anw02) Lade das erste Byte vom Wert VariableA (durch littel Endien: 0xef und nicht 0xde!) in r2.
ldrb    R3,[R0,#1]      ; (Anw03) Gehe in r0 ans zweite Byte (0xde) und lade dieses in r3. 
lsl     R2, #8          ; (Anw04) Schiffte das Register um 8 Bits nach links (0xef ist jetzt ganz vorne im r2)
orr     R2, R3          ; (Anw05) Odiere r2 und r3 also r2=0xef00 und r3=0x00de, r2|r3 = 0xefde 
strh    R2,[R0]         ; (Anw06) Speichere den inhalt von r2(0xefbe) an die adresse von r0(wo unsere VariableA ist). Im Speicher wird usere Hex-Zahl durch littel Endien wieder umgedreht(0xdeef).

