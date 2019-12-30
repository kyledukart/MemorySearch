*-----------------------------------------------------------
* Title      : HW4 #2
* Written by : Kyle Dukart
* Date       :
* Description: This is a program to read memory from $7000 to
*   $8000 and look for the pattern in memory.  If the pattern is
*   found, then the address of the word is stored in memory.  If no
*   pattern match is found the program stores $00000000 in memory location.
*   The pattern search algorithm assumes that the pattern is located
*   on the boundary.
*-----------------------------------------------------------
test_st EQU $00007000   ; start of block to fill
test_end    EQU $00008000   ; last address to fill
pattern EQU $AA50       ; pattern to find
stack   EQU $000A0000   ; locate the stack if necessary
start   EQU $400        ; program begins here
exit    EQU $2700       ; simulator stop code
byte    EQU 1           ; advance by 1 byte


    ORG    start        ; start here
    LEA test_st,A0      ; load starting address
    LEA test_end,A1     ; load ending address
    LEA addr_match,A2   ; address of match saved here
    MOVE.B  pattern,D1  ; store pattern in D1
loop:
    CMP.B   (A0),D1     ; test pattern
    BEQ match           ; they're the same, save it and exit
    ADDQ.L  #byte,A0    ; increment pointer
    CMPA.L  A1,A0       ; check if end of addresses
    BGT no_match        ; check if past range, exit
    BRA loop            ; go back and try again
    
match:
    MOVE.L  A0,(A2)     ; Save contents of A0 and exit
    
no match:
    STOP    #exit       ; break out of simulator

* Put program code here

addr_match DC.L $00000000   ; initialize to no match value

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
