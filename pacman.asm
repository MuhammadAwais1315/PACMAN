INCLUDE Irvine32.inc
includelib winmm.lib
Include macros.inc

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD
BUFFER_SIZE = 5000
NumbToStr   PROTO :DWORD,:DWORD


.data

error BYTE "Error opening file",0
buffer BYTE BUFFER_SIZE DUP(?)
sizeofbuffer dd 0
filename    BYTE "HighScore.txt",0
fileHandle  dword ?
space db " ",0
stringLength dd 1000
bbff        db 11 dup(?)

nameprompt BYTE "Enter your name: ",0
username byte 20 dup(?)
level byte 1
allow byte ?
food byte 1

highhhhh db "Score   Level   Playername ",0ah,0
ghostmove dd 0
updownleftrightG db 0
validupG db 0
checkGhost1 db 0
moveLeftRight db 0
moveUpDown db 0
ghostDot db 0
yposg byte 25
xposg byte 80

ground BYTE 119 dup('='),0
ground1 BYTE "||",0ah,0
ground2 BYTE "||",0

temp byte ?
mov_dir byte ?
strScore1 BYTE ": Your score is: ",0
strScore BYTE "Your score is: ",0
score dd 0
chk_score dd 0

xPos BYTE 98
yPos BYTE 49

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?
menubool db 1
prompt db "Enter 1 for Start Game",0
prompt1 db "Enter x for Exit Game",0
pac0 db "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",0ah,0
pac1 db "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",0ah,0
pac2 db "::                                                                                ::",0ah,0
pac3 db "::                                                                                ::",0ah,0
pac4 db "::     8888888b.      d8888  .d8888b.  888b     d888        d8888 888b    888     ::",0ah,0
pac5 db "::     888   Y88b    d88888 d88P  Y88b 8888b   d8888       d88888 8888b   888     ::",0ah,0
pac6 db "::     888    888   d88P888 888    888 88888b.d88888      d88P888 88888b  888     ::",0ah,0
pac7 db "::     888   d88P  d88P 888 888        888Y88888P888     d88P 888 888Y88b 888     ::",0ah,0
pac8 db "::     8888888P",34,"  d88P  888 888        888 Y888P 888    d88P  888 888 Y88b888     ::",0ah,0
pac9 db "::     888       d88P   888 888    888 888  Y8P  888   d88P   888 888  Y88888     ::",0ah,0
pac10 db "::     888      d8888888888 Y88b  d88P 888   ",34,"   888  d8888888888 888   Y8888     ::",0ah,0
pac11 db "::     888     d88P     888  ",34,"Y8888P",34,"  888       888 d88P     888 888    Y888     ::",0ah,0
pac12 db "::                                                                                ::",0ah,0
pac13 db "::                                                                                ::",0ah,0
pac14 db "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",0ah,0
pac15 db "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",0ah,0
                                                                       
startprompt1 db " __     ___  ____   __    ____  ____     ___    __    __  __  ____ ",0ah,0
startprompt2 db "/  )   / __)(_  _) /__\  (  _ \(_  _)   / __)  /__\  (  \/  )( ___)",0ah,0
startprompt3 db " )(    \__ \  )(  /(__)\  )   /  )(    ( (_-. /(__)\  )    (  )__) ",0ah,0
startprompt4 db "(__)() (___/ (__)(__)(__)(_)\_) (__)    \___/(__)(__)(_/\/\_)(____)",0ah,0


levelprompt1 db " ___      __    ____  _  _  ____  __    ___ ",0ah,0
levelprompt2 db "(__ \    (  )  ( ___)( \/ )( ___)(  )  / __)",0ah,0
levelprompt3 db " / _/     )(__  )__)  \  /  )__)  )(__ \__ \",0ah,0
levelprompt4 db "(____)() (____)(____)  \/  (____)(____)(___/",0ah,0

instructionprompt1 db " ___     ____  _  _  ___  ____  ____  __  __  ___  ____  ____  _____  _  _  ___ ",0ah,0
instructionprompt2 db "(__ )   (_  _)( \( )/ __)(_  _)(  _ \(  )(  )/ __)(_  _)(_  _)(  _  )( \( )/ __)",0ah,0
instructionprompt3 db " (_ \    _)(_  )  ( \__ \  )(   )   / )(__)(( (__   )(   _)(_  )(_)(  )  ( \__ \",0ah,0
instructionprompt4 db "(___/() (____)(_)\_)(___/ (__) (_)\_)(______)\___) (__) (____)(_____)(_)\_)(___/",0ah,0

insprompt1 db " ____  _  _  ___  ____  ____  __  __  ___  ____  ____  _____  _  _  ___ ",0ah,0
insprompt2 db "(_  _)( \( )/ __)(_  _)(  _ \(  )(  )/ __)(_  _)(_  _)(  _  )( \( )/ __)",0ah,0
insprompt3 db " _)(_  )  ( \__ \  )(   )   / )(__)(( (__   )(   _)(_  )(_)(  )  ( \__ \",0ah,0
insprompt4 db "(____)(_)\_)(___/ (__) (_)\_)(______)\___) (__) (____)(_____)(_)\_)(___/",0ah,0


exitprompt1 db "  ___     ____  _  _  ____  ____ ",0ah,0
exitprompt2 db " / _ \   ( ___)( \/ )(_  _)(_  _)",0ah,0
exitprompt3 db "( (_) )   )__)  )  (  _)(_   )(  ",0ah,0
exitprompt4 db " \___/() (____)(_/\_)(____) (__) " ,0ah,0

select_l11 db " __      __    ____  _  _  ____  __       ____ ",0ah,0 
select_l12 db "/  )    (  )  ( ___)( \/ )( ___)(  )     (_  _)",0ah,0
select_l13 db " )(      )(__  )__)  \  /  )__)  )(__     _)(_ ",0ah,0
select_l14 db "(__)()  (____)(____)  \/  (____)(____)   (____)",0ah,0

select_l21 db " ___       __    ____  _  _  ____  __      ____  ____ ",0ah,0
select_l22 db "(__ \     (  )  ( ___)( \/ )( ___)(  )    (_  _)(_  _)",0ah,0
select_l23 db " / _/      )(__  )__)  \  /  )__)  )(__    _)(_  _)(_ ",0ah,0
select_l24 db "(____)()  (____)(____)  \/  (____)(____)  (____)(____)",0ah,0

select_l31 db " ___      __    ____  _  _  ____  __      ____  ____  ____ ",0ah,0
select_l32 db "(__ )    (  )  ( ___)( \/ )( ___)(  )    (_  _)(_  _)(_  _)",0ah,0
select_l33 db " (_ \     )(__  )__)  \  /  )__)  )(__    _)(_  _)(_  _)(_ ",0ah,0
select_l34 db "(___/()  (____)(____)  \/  (____)(____)  (____)(____)(____)",0ah,0

select_r1 db "  ___      ____  ____  ____  __  __  ____  _  _ ",0ah,0
select_r2 db " / _ \    (  _ \( ___)(_  _)(  )(  )(  _ \( \( )" ,0ah,0
select_r3 db "( (_) )    )   / )__)   )(   )(__)(  )   / )  ( ",0ah,0
select_r4 db " \___/()  (_)\_)(____) (__) (______)(_)\_)(_)\_)",0ah,0

ins1 db "1. Use ",34,"W",34," key to move PAC-MAN ",34,"UP",34,".",0ah,0
ins2 db "2. Use ",34,"D",34," key to move PAC-MAN ",34,"DOWN",34,".",0ah,0
ins3 db "3. Use ",34,"A",34," key to move PAC-MAN ",34,"LEFT",34,".",0ah,0
ins4 db "4. Use ",34,"D",34," key to move PAC-MAN ",34,"RIGT",34,".",0ah,0
ins5 db "5. Avoid colission with ",34,"GHOSTS",34," to save lives.",0ah,0
ins6 db "6. ",34,"GHOSTS",34," behaviour changes with change in levels.",0ah,0

High_S1 db "  __      _   _  ____  ___  _   _    ___   ___  _____  ____  ____ ",0ah,0
High_S2 db " /. |    ( )_( )(_  _)/ __)( )_( )  / __) / __)(  _  )(  _ \( ___)",0ah,0
High_S3 db "(_  _)    ) _ (  _)(_( (_-. ) _ (   \__ \( (__  )(_)(  )   / )__) ",0ah,0
High_S4 db "  (_)()  (_) (_)(____)\___/(_) (_)  (___/ \___)(_____)(_)\_)(____)",0ah,0

High1 db " _   _  ____  ___  _   _    ___   ___  _____  ____  ____ ",0ah,0
High2 db "( )_( )(_  _)/ __)( )_( )  / __) / __)(  _  )(  _ \( ___)",0ah,0
High3 db " ) _ (  _)(_( (_-. ) _ (   \__ \( (__  )(_)(  )   / )__) ",0ah,0
High4 db "(_) (_)(____)\___/(_) (_)  (___/ \___)(_____)(_)\_)(____)",0ah,0


game_over1 db "  ___    __    __  __  ____    _____  _  _  ____  ____  ",0ah,0
game_over2 db " / __)  /__\  (  \/  )( ___)  (  _  )( \/ )( ___)(  _ \ ",0ah,0
game_over3 db "( (_-. /(__)\  )    (  )__)    )(_)(  \  /  )__)  )   / ",0ah,0
game_over4 db " \___/(__)(__)(_/\/\_)(____)  (_____)  \/  (____)(_)\_) ",0ah,0

resume1 db " __      ____  ____  ___  __  __  __  __  ____ ",0ah,0
        db "/  )    (  _ \( ___)/ __)(  )(  )(  \/  )( ___)",0ah,0
        db " )(      )   / )__) \__ \ )(__)(  )    (  )__) ",0ah,0
        db "(__)()  (_)\_)(____)(___/(______)(_/\/\_)(____)",0ah,0



 grid1_prompt1 db "======================================================================================================================",0ah,0
 grid1_prompt2 db " . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . ",0ah,0
 grid1_prompt3 db "==================== . ================================================================== . ==========================",0ah,0
 grid1_prompt4 db "==================== . ================================================================== . ==========================",0ah,0
 grid1_prompt5 db "==== . . . . . . . . . . . . . . .  . . . ========================= . . . . . . . . . . . . . . . . . . . . . . . ====",0ah,0
 grid1_prompt6 db "==================== . ================================================================== . ==========================",0ah,0
 grid1_prompt7 db "==================== . ================================================================== . ==========================",0ah,0
 grid1_prompt8 db "==================== . . . . . .  . . . . ========================= . . . . . . . . . . . . ==========================",0ah,0
 grid1_prompt9 db "======================================= . ========================= . ================================================",0ah,0
grid1_prompt10 db " . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . .  . . . . . . . . ",0ah,0 
grid1_prompt11 db " . ==================== . ==================== . ==================== . ==================== . ==================== . ",0ah,0    
grid1_prompt12 db " . | .--------------. | . | .--------------. | . | .--------------. | . | .--------------. | . | .--------------. | . ",0ah,0   
grid1_prompt13 db " . | |      __      | | . | | _____  _____ | | . | |      __      | | . | |     _____    | | . | |    _______   | | . ",0ah,0   
grid1_prompt14 db " . | |     /  \     | | . | ||_   _||_   _|| | . | |     /  \     | | . | |    |_   _|   | | . | |   /  ___  |  | | . ",0ah,0   
grid1_prompt15 db " . | |    / /\ \    | | . | |  | | /\ | |  | | . | |    / /\ \    | | . | |      | |     | | . | |  |  (__ \_|  | | . ",0ah,0   
grid1_prompt16 db " . | |   / ____ \   | | . | |  | |/  \| |  | | . | |   / ____ \   | | . | |      | |     | | . | |   '.___`-.   | | . ",0ah,0   
grid1_prompt17 db " . | | _/ /    \ \_ | | . | |  |   /\   |  | | . | | _/ /    \ \_ | | . | |     _| |_    | | . | |  |`\____) |  | | . ",0ah,0   
grid1_prompt18 db " . | ||____|  |____|| | . | |  |__/  \__|  | | . | ||____|  |____|| | . | |    |_____|   | | . | |  |_______.'  | | . ",0ah,0   
grid1_prompt19 db " . | |              | | . | |              | | . | |              | | . | |              | | . | |              | | . ",0ah,0   
grid1_prompt20 db " . | '--------------' | . | '--------------' | . | '--------------' | . | '--------------' | . | '--------------' | . ",0ah,0   
grid1_prompt21 db " . ==================== . ==================== . ==================== . ==================== . ==================== . ",0ah,0    
grid1_prompt22 db " . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . .  . . . . . . . . ",0ah,0 
grid1_prompt23 db "======================================= . ========================= . ================================================",0ah,0
grid1_prompt24 db "==================== . . . . . .  . . . . ========================= . . . . . . . . . . . . ==========================",0ah,0
grid1_prompt25 db "==================== . ================================================================== . ==========================",0ah,0
grid1_prompt26 db " . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ",0ah,0
grid1_prompt27 db "======================================================================================================================",0ah,0


  grid2_prompt1 db "======================================================================================================================",0ah,0
  grid2_prompt2 db " . . . . . . . . . . . . . . . . . . . . . . . . . . . . | | . . . . . .  . . . . . . . . . . . . . . . . . . . . . . ",0ah,0
  grid2_prompt3 db " . ,_________________________________________________, . | | . ,__________________________________________________, . ",0ah,0
  grid2_prompt4 db " . | ,_____________________________________________, | . | | . | ,______________________________________________, | . ",0ah,0
  grid2_prompt5 db " . | | . . . . . . . . . . . . . . . . . . . . . . | | . | | . | | . . . . . . . . . . . . . . . . . . . .  . . | | . ",0ah,0
  grid2_prompt6 db " . | | . ,_____________________________________, . | | . | | . | | . ,______________________________________, . | | . ",0ah,0
  grid2_prompt7 db " . | | . |                                     | . | | . | | . | | . |                                      | . | | . ",0ah,0
  grid2_prompt8 db " . | | . |_____________________________________| . | | . | | . | | . |______________________________________| . | | . ",0ah,0
  grid2_prompt9 db " . | | . . . . . . . . . . . . . . . . . . . . . . | | . | | . | | . . . . . . . . . . . . .  . . . . . . . . . | | . ",0ah,0
 grid2_prompt10 db " . | |_____________________, . ,___________________| | . | | . | |______________________,   ,___________________| | . ",0ah,0
 grid2_prompt11 db " . |_______________________| . |_____________________| . |_| . |________________________|   |_____________________| . ",0ah,0
 grid2_prompt12 db " . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . ",0ah,0
 grid2_prompt13 db " . ,______________________________________________________________________________________________________________, . ",0ah,0
 grid2_prompt14 db " . |                                                                                                              | . ",0ah,0
 grid2_prompt15 db " . |_____________________________________________________, ,______________________________________________________| . ",0ah,0
 grid2_prompt16 db " . . . . . . . . . . . . . . . . . . . . . . . . . . . . | | . . . . . .  . . . . . . . . . . . . . . . . . . . . . . ",0ah,0
 grid2_prompt17 db " . ,________________________, . ,____________________, . | | . ,_______________________, . ,______________________, . ",0ah,0
 grid2_prompt18 db " . | ,______________________| . |__________________, | . | | . | ,_____________________| . |____________________, | . ",0ah,0
 grid2_prompt19 db " . | | . . . . . . . . . . . . . . . . . . . . . . | | . |_| . | | . . . . . . . . . . . . . . . . . . . .  . . | | . ",0ah,0
 grid2_prompt20 db " . | | . ,_____________________________________, . | | .     . | | . ,______________________________________, . | | . ",0ah,0
 grid2_prompt21 db " . | | . |                                     | . | | . ,-, . | | . |                                      | . | | . ",0ah,0
 grid2_prompt22 db " . | | . |_____________________________________| . | | . | | . | | . |______________________________________| . | | . ",0ah,0
 grid2_prompt23 db " . | | . . . . . . . . . . . . . . . . . . . . . . | | . | | . | | . . . . . . . . . . . . .  . . . . . . . . . | | . ",0ah,0
 grid2_prompt24 db " . | |_____________________________________________| | . | | . | |______________________________________________| | . ",0ah,0
 grid2_prompt25 db " . |_________________________________________________| . | | . |__________________________________________________| . ",0ah,0
 grid2_prompt26 db " . . . . . . . . . . . . . . . . . . . . . . . . . . . . | | . . . . . .  . . . . . . . . . . . . . . . . . . . . . . ",0ah,0
 grid2_prompt27 db "======================================================================================================================",0ah,0



 grid3_prompt1 db "=====================================================================================================================",0ah,0
 grid3_prompt2 db " . . . . . . . . . | | . . . . . . . . . .. . . . . . | | . | | .|.    . .  .  |(###)|     |. . . .|  . . . . . . . ",0ah,0
 grid3_prompt3 db " . ,-----------, . | | . ,------------------------, . | | . | | .|. | |====   .  =====      |. .====|.  . ,________, ",0ah,0
 grid3_prompt4 db " . |           | . |_| . | ,____________________, | . | | . | | .|. | |. . | | .  ======,   |. . . .|.  . |(######)| ",0ah,0
 grid3_prompt5 db " . |           | . . . . | | . . . . . . .. . . | | . |_| . | | .|. |=== . | | .| |(###)|   | ===. .      '--------' ",0ah,0
 grid3_prompt6 db " . |           | . ,-,  -| | . ,------------, . | | .     . | | . . |   |. | | .| ======    |. . . . |. . . . . . . .",0ah,0
 grid3_prompt7 db " . |___________| . | | . | | . |____________| . | | . ,-, . | | .|. |   |. | | .      ========   ================== .",0ah,0
 grid3_prompt8 db " . . . . . . . . . | | . |_|   _________________|_| . |_| . | | .|. |   |. | | .|  |         |  |=                | .",0ah,0
 grid3_prompt9 db "  _________________| | .  .  .  .  .  .  . .  .  .  .     . | | .|. |   |. | | .|  |   ---   | .|=                | .",0ah,0
grid3_prompt10 db " . . . . . . . . . | |----------------------------------, . | | .|. |   |. | |== ==   |$$|   |  |=  ________      | .",0ah,0
grid3_prompt11 db " . ,-----------, . | |__________________________________| . | | .|. . . . . . . . . . . . |$$| .|=  |=^_^=||      | .",0ah,0
grid3_prompt12 db " . |___________| . | | .  ===================== . . . . . . |  =======================| . ,--- .|=  --------      | .",0ah,0
grid3_prompt13 db " . . . . . . . . . | | .  |       _______     |. . . . . .  . |  |. . . . _____. . . .| . |   . |=                | .",0ah,0
grid3_prompt14 db "  -----------------|_| .  |       |(###)|     |. . . . . . .  |  | . . . .|###|. . . .| . |   . |=________________| .",0ah,0          
grid3_prompt15 db " . . . . . . . . |-|   .  |       -------     |. . . . . . . .|  |       -----. . . . | . |         .  .    .    .  .",0ah,0
grid3_prompt16 db " . ,---------, . | |   .  ===================== . . . ===| . . . =====================| .  ===========  =============",0ah,0                       
grid3_prompt17 db " . |  ,___,  | . | |  .  . . . . . . . . .. . . . . . . . . . . . . .  . .. . . . |   | . . . .   . . . . . . . . . .",0ah,0
grid3_prompt18 db " . |  | . |  | . | | .   =========================  . . . . . . . . . . . . . .  . . .|. . . . .  . . . . . . . . . .",0ah,0
grid3_prompt19 db " . |  | . |  | . | | .  | |=====================||. . . . . . . . . . . . . . . . . . . .  ||  .  | ,---------, . | .",0ah,0
grid3_prompt20 db " . . .  . |  | . | | .  | |     __________      || . .  .|.| |\\| | || . |           |  .  ||  .  | |  | .    | . | .",0ah,0
grid3_prompt21 db " . |__| . |  | . | |.   | |                     ||== . . |.| |==| | || . ,------------, .  ||  .  | |  |___,  | . | .",0ah,0
grid3_prompt22 db "  --------'  | . | |  . | |     |         |     || .  . =|.| |\\| | || . |           |  .  ||  .  | |  | . |  | . | .",0ah,0
grid3_prompt23 db "  -----------' . | |   .| |     | (=____=)|     ||=.  .  |.| |\\| | || . |           |  .  ||  .  | |__| . |  | . | .",0ah,0                      
grid3_prompt24 db " . . . . . . . . | |   .| |     |_________|     || .  . =|,| |==| | || . |___________|  .  ||  .  | . .  . |  | . | .",0ah,0                  
grid3_prompt25 db " . --------------| |    | |                     ||==. . . . . . . . . . . . . . . . . . . . . .   '------ .  .  .   .",0ah,0                            
grid3_prompt26 db " . . . . . . . . . .    | |=====================||. . . .| | | | | | |. . . . . . . . . . . . .    ----------------  ",0ah,0                     
grid3_prompt27 db "=====================================================================================================================",0ah,0


SND_FILENAME DWORD 00020000h
SND_LOOP DWORD  00000008h
SND_ASYNC DWORD 00000001h
file BYTE "Music.wav" , 0

resume byte 1
lives byte 3
lives_prompt byte "Lives: ",0


.code



main PROC

  mov eax,SND_FILENAME
  or eax,SND_LOOP
  or eax,SND_ASYNC
  INVOKE PlaySound,addr file, 0, eax
   call username_proc
  call mainmenu

main ENDP


play__m proc
   
    ; INVOKE PlaySound, OFFSET file, NULL, SND_FILENAME
	ret
play__m endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            Take name as input from user and save username                     ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

username_proc proc
call clrscr
call printpacman
mov eax,cyan+(gray*64)
call settextcolor
mov dl,57
mov dh,25
call Gotoxy
mov edx, offset nameprompt
call writestring
mov edx, offset username
mov ecx,20
call readstring
ret
username_proc endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            main menu proc                                                     ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mainmenu proc
 mainmenu_start:
    call clrscr
    call printpacman
    call printstart
    call printlevel
    call printinstruction
    call printhighscore
    call printexit

        call readchar
        cmp al,'1'
           je startgame
           cmp al,'2'
              je level_menu
              cmp al,'3'
                 je instruction_menu
                 cmp al,'4'
					je highscore_menu
                      cmp al,'0'
                         je exitgame
                         call mainmenu
        startgame:
               call startgame
               jmp mainmenu_start
        level_menu:
               call levelmenu
                jmp mainmenu_start
        instruction_menu:
               call instructionmenu
                 jmp mainmenu_start
        highscore_menu:
                call highscoremenu
				 jmp mainmenu_start
        exitgame:
               call exitgame
     
ret
mainmenu endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            pause menu proc                                                    ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Pause_menu proc
 pausemenu_start:
    call clrscr
    call printpacman
    call printresume
    call printlevel
    call printinstruction
    call printhighscore
    call printexit

        call readchar
        cmp al,'1'
           je resumemenu
           cmp al,'2'
              je level_menu
              cmp al,'3'
                 je instruction_menu
                 cmp al,'4'
					je highscore_menu
                      cmp al,'0'
                         je exitgame
                         call pausemenu_start
        resumemenu:
                   mov resume,1
               jmp reeeeeeturn
        level_menu:
               call levelmenu
                jmp pausemenu_start
        instruction_menu:
               call instructionmenu
                 jmp pausemenu_start
        highscore_menu:
                call highscoremenu
				 jmp pausemenu_start
        exitgame:
               call game_over_fun
     reeeeeeturn:

ret
Pause_menu endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the start prompt                                              ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printresume PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,22
	   mov ecx,4
	   mov temp ,dh
	   mov edx, offset resume1
	   L1:
	   push edx
	   mov dh,temp
	    mov dl,57
		
       call Gotoxy
       pop edx
	   call writestring
	   add edx,lengthof resume1
       inc temp
	   loop L1
	   
   ret
printresume ENDP




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            level menu proc                                                    ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


levelmenu proc
call clrscr
call printpacman
 mov eax,cyan+(gray*64)
 call settextcolor
	   mov dl,57
	   mov dh,23
	   call Gotoxy
	   mov edx, offset select_l11
	   call writestring
	   mov dl,57
	   mov dh,24
	   call Gotoxy
	   mov edx, offset select_l12
	   call writestring
	   mov dl,57
	   mov dh,25
	   call Gotoxy
	   mov edx, offset select_l13
	   call writestring
	   mov dl,57
	   mov dh,26
	   call Gotoxy
	   mov edx, offset select_l14
	   call writestring
	   mov dl,57
	   mov dh,29
	   call Gotoxy
	   mov edx, offset select_l21
	   call writestring
	   mov dl,57
	   mov dh,30
	   call Gotoxy
	   mov edx, offset select_l22
	   call writestring
	   mov dl,57
	   mov dh,31
	   call Gotoxy
	   mov edx, offset select_l23
	   call writestring
	   mov dl,57
	   mov dh,32
	   call Gotoxy
	   mov edx, offset select_l24
	   call writestring
	   mov dl,57
	   mov dh,35
	   call Gotoxy
	   mov edx, offset select_l31
	   call writestring
	   mov dl,57
	   mov dh,36
	   call Gotoxy
	   mov edx, offset select_l32
	   call writestring
	   mov dl,57
	   mov dh,37
	   call Gotoxy
	   mov edx, offset select_l33
	   call writestring
	   mov dl,57
	   mov dh,38
	   call Gotoxy
	   mov edx, offset select_l34
	   call writestring
	   
       call printreturn


       call readchar
       cmp al,'1'
          je level1
          cmp al,'2'
             je level2
             cmp al,'3'
                je level3
                cmp al,'0'
                   je return
                     call levelmenu

      level1:
           mov level,1
           jmp return
      level2:
           mov level,2
           jmp return
      level3:
           mov level,3
           jmp return
      return:
           ;call mainmenu

     ret
levelmenu endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            instruction menu proc                                              ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instructionmenu proc
call clrscr
call printpacman
 mov eax,cyan+(gray*64)
 call settextcolor
 call printins
     mov eax,yellow+(gray*64)
 call settextcolor
  mov dl,57
	   mov dh,28
	   call Gotoxy
	   mov edx, offset ins1
	   call writestring
        mov dl,57
	   mov dh,30
	   call Gotoxy
	   mov edx, offset ins2
	   call writestring
        mov dl,57
	   mov dh,32
	   call Gotoxy
	   mov edx, offset ins3
	   call writestring
        mov dl,57
	   mov dh,34
	   call Gotoxy
	   mov edx, offset ins4
	   call writestring
        mov dl,57
	   mov dh,36
	   call Gotoxy
	   mov edx, offset ins5
	   call writestring
         mov dl,57
	   mov dh,38
	   call Gotoxy
	   mov edx, offset ins6
	   call writestring

 call printreturn

call readchar
cmp al,'0'
je return1
call instructionmenu

return1:
ret
instructionmenu endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            highscore menu proc                                                ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

highscoremenu proc
highstart:
call clrscr
call printpacman
 mov eax,cyan+(gray*64)
 call settextcolor
 call printhigh
	 mov eax,yellow+(gray*64)
 call settextcolor


 call printreturn

 call FileHandling


 call readchar
cmp al,'0'
je return2
  jmp highstart
return2:
ret
highscoremenu endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            exit game proc                                                     ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exitgame proc
call clrscr
exit    
ret
exitgame endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the return prompt                                             ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printreturn proc
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,41
	   call Gotoxy
	   mov edx, offset select_r1
	   call writestring
	   mov dl,57
	   mov dh,42
	   call Gotoxy
	   mov edx, offset select_r2
	   call writestring
	   mov dl,57
	   mov dh,43
	   call Gotoxy
	   mov edx, offset select_r3
	   call writestring
	   mov dl,57
       mov dh,44
	   call Gotoxy
       mov edx, offset select_r4
       call writestring
ret
printreturn endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the pacman prompt                                             ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printpacman PROC
       mov eax,red+(gray*64)
       call settextcolor
       mov dl,57
       mov dh,4
       call Gotoxy
       mov edx, offset pac0
       call writestring
       mov dl,57
       mov dh,5
       call Gotoxy
       mov edx, offset pac1
       call writestring
       mov dl,57
       mov dh,6
       call Gotoxy
       mov edx, offset pac2
       call writestring
       mov dl,57
       mov dh,7
       call Gotoxy
       mov edx, offset pac3
       call writestring
       mov dl,57
       mov dh,8
       call Gotoxy
       mov edx, offset pac4
       call writestring
       mov dl,57
       mov dh,9
       call Gotoxy
       mov edx, offset pac5
       call writestring
       mov dl,57
       mov dh,10
       call Gotoxy
       mov edx, offset pac6
       call writestring
       mov dl,57
       mov dh,11
       call Gotoxy
       mov eax,cyan+(gray*64)
       call settextcolor
       mov edx, offset pac7
       call writestring
       mov dl,57
       mov dh,12
       call Gotoxy
       mov edx, offset pac8
       call writestring
       mov dl,57
       mov dh,13
       call Gotoxy
       mov edx, offset pac9
       call writestring
       mov dl,57
       mov dh,14
       call Gotoxy
       mov eax,red+(gray*64)
       call settextcolor
       mov edx, offset pac10
       call writestring
       mov dl,57
       mov dh,15
       call Gotoxy
       mov edx, offset pac11
       call writestring
       mov dl,57
       mov dh,16
       call Gotoxy
       mov edx, offset pac12
       call writestring 
       mov dl,57
       mov dh,17
       call Gotoxy
       mov edx, offset pac13
       call writestring
       mov dl,57
       mov dh,18
       call Gotoxy
       mov edx, offset pac14
       call writestring
       mov dl,57
       mov dh,19
       call Gotoxy
       mov edx, offset pac15
       call writestring
   ret
printpacman ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the start prompt                                              ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printstart PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,22
       call Gotoxy
       mov edx, offset startprompt1
	   call writestring
	   mov dl,57
	   mov dh,23
       call Gotoxy
	   mov edx, offset startprompt2
	   call writestring
	   mov dl,57
       mov dh,24
       call Gotoxy
       mov edx, offset startprompt3
	   call writestring
	   mov dl,57
	   mov dh,25
       call Gotoxy
       mov edx, offset startprompt4
	   call writestring 
   ret
printstart ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the levels prompt                                             ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
printlevel PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,28
       call Gotoxy
       mov edx, offset levelprompt1
	   call writestring
	   mov dl,57
	   mov dh,29
       call Gotoxy
       mov edx, offset levelprompt2
	   call writestring
	   mov dl,57
	   mov dh,30
       call Gotoxy
	   mov edx, offset levelprompt3
	   call writestring
	   mov dl,57
	   mov dh,31
       call Gotoxy
	   mov edx, offset levelprompt4
	   call writestring
   ret
printlevel ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the istructions prompt                                        ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printinstruction PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,34
       call Gotoxy
       mov edx, offset instructionprompt1
	   call writestring
	   mov dl,57
       mov dh,35
       call Gotoxy
	   mov edx, offset instructionprompt2
	   call writestring
	   mov dl,57
       mov dh,36
       call Gotoxy
	   mov edx, offset instructionprompt3
	   call writestring
	   mov dl,57
	   mov dh,37
       call Gotoxy
       mov edx, offset instructionprompt4
	   call writestring
    ret
printinstruction ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printins PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,62
	   mov dh,21
       call Gotoxy
       mov edx, offset insprompt1
	   call writestring
	   mov dl,62
       mov dh,22
       call Gotoxy
	   mov edx, offset insprompt2
	   call writestring
	   mov dl,62
       mov dh,23
       call Gotoxy
	   mov edx, offset insprompt3
	   call writestring
	   mov dl,62
	   mov dh,24
       call Gotoxy
       mov edx, offset insprompt4
	   call writestring
    ret
printins ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the high score prompt                                         ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printhighscore PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,40
       call Gotoxy
       mov edx, offset high_s1
	   call writestring    
	   mov dl,57           
       mov dh,41           
       call Gotoxy         
	   mov edx, offset high_s2
	   call writestring    
	   mov dl,57           
	   mov dh,42           
       call Gotoxy         
	   mov edx, offset high_s3
	   call writestring    
	   mov dl,57           
	   mov dh,43           
       call Gotoxy         
	   mov edx, offset high_s4
	   call writestring
	ret
printhighscore ENDP



printhigh PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,62
	   mov dh,21
       call Gotoxy
       mov edx, offset high1
	   call writestring
	   mov dl,62
       mov dh,22
       call Gotoxy
	   mov edx, offset high2
	   call writestring
	   mov dl,62
	   mov dh,23
       call Gotoxy
	   mov edx, offset high3
	   call writestring
	   mov dl,62
	   mov dh,24
       call Gotoxy
	   mov edx, offset high4
	   call writestring
	ret
printhigh ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           print the exit prompt                                               ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printexit PROC
       mov eax,cyan+(gray*64)
       call settextcolor
       mov dl,57
	   mov dh,45
       call Gotoxy
       mov edx, offset exitprompt1
	   call writestring
	   mov dl,57
       mov dh,46
       call Gotoxy
	   mov edx, offset exitprompt2
	   call writestring
	   mov dl,57
	   mov dh,47
       call Gotoxy
	   mov edx, offset exitprompt3
	   call writestring
	   mov dl,57
	   mov dh,48
       call Gotoxy
	   mov edx, offset exitprompt4
	   call writestring
	ret
printexit ENDP



draw_grid proc
     call clrscr
	 call printpacman
; draw ground at (0,29):
    mov eax,red ;(black * 16)
    call SetTextColor
    mov dl,40
    mov dh,51
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov dl,40
    mov dh,23
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,27
    mov dh,24
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,39
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    loop l1


    mov ecx,27
    mov dh,24
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,159
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2
    call DrawPlayer

	ret
	draw_grid endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            start game proc                                                    ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


startgame proc


 call clrscr
 call printpacman

   cmp level,1
      je level1_chk
        cmp level,2
		 je level2_chk
		 cmp level,3
			je level3_chk
level1_chk:
       mov chk_score,0
       jmp nexxxxxt
level2_chk:
	   mov chk_score,395
       jmp nexxxxxt
level3_chk:
       mov chk_score,1423
       nexxxxxt:

    call draw_grid

    
   ; mov level ,3
level_change:
    cmp level,1
    je level1
      cmp level,2
       je level2
		cmp level,3
		je level3
level1:
     mov xPos,98
     mov yPos,49
     call PrintGrid1
     call drawplayer
	  call drawghost
     jmp gameLoop
level2:
     mov xPos,99
	 mov yPos,43
	 call PrintGrid2
     call drawplayer
	 call drawghost
	 jmp gameLoop
level3:
	 mov xPos,96
     mov yPos,50
     call PrintGrid3
     call drawplayer
	 call drawghost

	 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 ;;               gameloop label                                   ;;
	 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    gameLoop:
	    


        ; check if level is complete:
         
 
          cmp chk_score,395
            jnae continue_level
              cmp level,1
                jne chk_level2
                  mov level,2
                  jmp level_change
    chk_level2:
               cmp chk_score,1423
				 jnae continue_level
				   cmp level,2
					 jne chk_level3
					   mov level,3
					   jmp level_change
chk_level3:
			   
      
  continue_level:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                          ;
;                      Ghost Movement                                      ;
;                                                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




  ghostmovement:
		cmp moveUpDown,1
		je upaa123
		cmp moveUpDown,0
		je downaa123
Upaa123:
		cmp moveLeftRight,0
		je leftaa1234
		cmp moveLeftRight,1
		je rightaa1234

Downaa123:
		cmp moveLeftRight,0
		je leftaa123
		cmp moveLeftRight,1
		je rightaa123
	
leftaa123:
		mov updownleftrightG,1
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov updownleftrightG,4
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov moveLeftRight,1
		jmp ghostmovement
rightaa123:
		mov updownleftrightG,3
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov updownleftrightG,1
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov moveLeftRight,0
		jmp ghostmovement

leftaa1234:
		mov updownleftrightG,2
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov updownleftrightG,4
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov moveLeftRight,1
		jmp ghostmovement
rightaa1234:
		mov updownleftrightG,3
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov updownleftrightG,2
		call CheckValidMovementG
		cmp validupG,1
		je ghostmovement1
		mov moveLeftRight,0
		jmp ghostmovement

	;	mov eax,5
	;	inc eax
	;	call RandomRange
		ghostmovement1:
		cmp yPosG,25
		jne n1
		mov moveUpDown,0
		n1:
		cmp yPosG,49
		jne n2
		mov moveUpDown,1
		n2:
		;mov updownleftrightG,al
		call CheckValidMovementG
		cmp validupG,1
		jne ghostmovement
		call CheckPosition
		cmp updownleftrightG,2
		je ghostmoveup
		cmp updownleftrightG,1
		je ghostmovedown
		cmp updownleftrightG,4
		je ghostmoveleft
		cmp updownleftrightG,3
		je ghostmoveright
	
		ghostmoveup:

			call UpdateGhost
			mov ghostDot,0
			dec yPosG
			call DrawGhost
			mov eax,80
			call Delay
			jmp nexttttttt1
		ghostmovedown:

			call UpdateGhost
			mov ghostDot,0
			inc yPosG
			call DrawGhost
			mov eax,80
			call Delay
			jmp nexttttttt1
		ghostmoveleft:
	
			call UpdateGhost
			mov ghostDot,0	
			dec xPosG
			call DrawGhost
			mov eax,80
			call Delay
			jmp nexttttttt1
		ghostmoveright:
	
			call UpdateGhost
			mov ghostDot,0
			inc xPosG
			call DrawGhost
			mov eax,80
			call Delay
			jmp nexttttttt1

		
		nexttttttt1:
		mov validupG,0
        mov eax,red (black * 16)
        call SetTextColor






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                          ;
;                      food generation and eating                          ;
;                                                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

cmp food,0
je chkfood
 call CreateRandomCoin
    call DrawCoin
    call Randomize
	mov food,0
chkfood:
	     mov al,xpos
	    cmp al,xCoinPos
		jne noteaten   
		    mov al,ypos
			cmp al,yCoinPos
			jne noteaten
				;call UpdatePlayer
				call DrawPlayer
				mov food,1
				add score,5
				mov eax,red+(black*16)
				call SetTextColor
				mov dl,xCoinPos
				mov dh,yCoinPos
				call Gotoxy
			;	mov al," "
			;	call WriteChar
noteaten:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                          ;
;                      Ghost and player collision                          ;
;                                                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov al,xpos
cmp al,xPosG
jne notcollide
 mov al,ypos
cmp al,yPosG
jne notcollide
  dec lives
    cmp level,1
	je level11
       cmp level,2
        je level22
		 cmp level,3
          je level33
		   jmp notcollide
level11:
      mov xPos,98
      mov yPos,49
	  call DrawPlayer
	  jmp notcollide
level22:
      mov xPos,99
      mov yPos,43
	   call DrawPlayer
	    jmp notcollide
level33:
       mov xPos,96
mov yPos,50
call DrawPlayer
jmp notcollide

notcollide:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                          ;
;                      Draw Score and lives                                ;
;                                                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


        ; draw score:
        mov dl,46
        mov dh,22
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,score
        call Writedec

; draw lives:
 	mov dl,140
      mov dh,22
call Gotoxy
mov eax ,red+(black*16)
call SetTextColor
mov edx,OFFSET lives_prompt
call WriteString
movzx eax,lives
call Writedec

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                          ;
;                      keys input for movement                             ;
;                                                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     cmp lives,0
	 je exitGame_label


        ; get user key input:
        call Readkey
        mov inputChar,al

       
        cmp inputChar,"p"
        je pause_game

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight
         jmp gameLoop
        moveUp:
        mov mov_dir , 'u'
        call check_up
        cmp allow,1
        jne gameLoop

        cmp yPos,25
        jle gameLoop
        ; allow player to jump:
        mov ecx,1
        jumpLoop:
            call UpdatePlayer
            dec yPos
            call DrawPlayer
            mov eax,70
            call Delay
        loop jumpLoop
        jmp gameLoop

        moveDown:
        
        mov mov_dir , 'd'
        call check_up
        cmp allow,1
        jne gameLoop
        cmp yPos,50
        je gameLoop
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

        moveLeft:
mov mov_dir , 'l'
 call check_up
        cmp allow,1
        jne gameLoop
        cmp xPos,42
        je gameLoop
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
mov mov_dir , 'r'
 call check_up
        cmp allow,1
        jne gameLoop
        cmp xPos,157
        je gameLoop
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop

    jmp gameLoop

	pause_game:
	    call Pause_menu
		   cmp resume,1
		   jne ennndddd
		  call draw_grid
            cmp level,1
			 jne  lvl2
			 call printgrid1
			 lvl2:
              cmp level,2
			   jne lvl3 
			   call printgrid2
			   lvl3:
			    cmp level,3
				 jne lvl4
				 call printgrid3
lvl4:
                call drawplayer
                 jmp gameLoop
ennndddd:

    exitGame_label:
    call Game_over_fun

ret
startgame endp
	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;           draw player proc                                                    ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,Green ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

DrawGhost PROC
    ; draw ghost at (xPos,yPos):
    mov eax,Magenta ;(blue*16)
    call SetTextColor
    mov dl,xPosG
    mov dh,yPosG
    call Gotoxy
    mov al,"G"
    call WriteChar
    ret
DrawGhost ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            update player proc                                                 ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP


UpdateGhost PROC
    cmp level,1
	jne lvvl2
	mov eax, cyan + (gray * 64)
	call SetTextColor
	jmp update
lvvl2:
    cmp level,2
	 jne lvvl3
	  mov eax, yellow + (gray * 64)
	   call SetTextColor
	    jmp update
lvvl3: 
      cmp level,3
	   jne lvvl4
	    mov eax, lightred + (gray * 64)
		 call SetTextColor
		  jmp update
lvvl4:
	 update:
    mov dl,xPosG
    mov dh,yPosG
    call Gotoxy
	cmp ghostDot,1
	je ghostDot1
    mov al," "
    call WriteChar
	jmp last
ghostDot1:
mov al,"."
call WriteChar
last:
mov al ,xPosG
cmp xcoinpos,al
   jne notsame
      mov al ,yPosG
cmp ycoinpos,al
   jne notsame
   mov dl,xcoinpos
mov dh,ycoinpos
call Gotoxy
   mov eax,blue ;(red * 16)
    call SetTextColor
	  mov al,"$"
call WriteChar
notsame:
    ret
UpdateGhost ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            draw coin proc                                                     ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCoin PROC
    mov eax,blue ;(red * 16)
    call SetTextColor
    mov dl,xCoinPos
    mov dh,yCoinPos
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawCoin ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            create random coin proc                                            ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CreateRandomCoin PROC
    mov eax,117
    
    call RandomRange
	add eax,42
    mov xCoinPos,al
    mov yCoinPos,25
    ret
CreateRandomCoin ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            level 1 grid print proc                                            ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintGrid1 PROC
	mov eax,cyan+(black*16)
	call SetTextColor
    mov dh,24
	mov dl,41
	call Gotoxy
	mov edx,OFFSET grid1_prompt1
	call WriteString
    mov dh,25
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt2
	call WriteString
	mov dh,26
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt3
	call WriteString
mov dh,27
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt4
	call WriteString
mov dh,28
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt5
	call WriteString
mov dh,29
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt6
	call WriteString
mov dh,30
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt7
	call WriteString
mov dh,31
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt8
	call WriteString
mov dh,32
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt9
	call WriteString
mov dh,33
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt10
	call WriteString
mov dh,34
mov dl,41
	call Gotoxy
   mov edx,OFFSET grid1_prompt11
call WriteString
mov dh,35
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt12
	call WriteString
mov dh,36
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt13
	call WriteString
mov dh,37
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt14
	call WriteString
mov dh,38
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt15
	call WriteString
mov dh,39
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt16
	call WriteString
mov dh,40
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt17
	call WriteString
mov dh,41
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt18
	call WriteString
mov dh,42
    mov dl,41
call Gotoxy
mov edx,OFFSET grid1_prompt19
	call WriteString
mov dh,43
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt20
	call WriteString
mov dh,44
mov dl,41
   call Gotoxy
mov edx,OFFSET grid1_prompt21
	call WriteString
mov dh,45
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt22
	call WriteString
mov dh,46
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt23
	call WriteString
mov dh,47
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt24
	call WriteString
mov dh,48
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt25
	call WriteString
mov dh,49
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt26
	call WriteString
mov dh,50
mov dl,41
	call Gotoxy
mov edx,OFFSET grid1_prompt27
	call WriteString
	ret
PrintGrid1 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            level 3 grid print proc                                            ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintGrid3 PROC
	mov eax,lightred+(black*16)
	call SetTextColor
    mov dh,24
	mov dl,41
	call Gotoxy
	mov edx,OFFSET grid3_prompt1
	call WriteString
    mov dh,25
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt2
	call WriteString
	mov dh,26
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt3
	call WriteString
mov dh,27
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt4
	call WriteString
mov dh,28
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt5
	call WriteString
mov dh,29
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt6
	call WriteString
mov dh,30
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt7
	call WriteString
mov dh,31
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt8
	call WriteString
mov dh,32
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt9
	call WriteString
mov dh,33
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt10
	call WriteString
mov dh,34
mov dl,41
	call Gotoxy
   mov edx,OFFSET grid3_prompt11
call WriteString
mov dh,35
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt12
	call WriteString
mov dh,36
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt13
	call WriteString
mov dh,37
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt14
	call WriteString
mov dh,38
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt15
	call WriteString
mov dh,39
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt16
	call WriteString
mov dh,40
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt17
	call WriteString
mov dh,41
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt18
	call WriteString
mov dh,42
    mov dl,41
call Gotoxy
mov edx,OFFSET grid3_prompt19
	call WriteString
mov dh,43
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt20
	call WriteString
mov dh,44
mov dl,41
   call Gotoxy
mov edx,OFFSET grid3_prompt21
	call WriteString
mov dh,45
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt22
	call WriteString
mov dh,46
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt23
	call WriteString
mov dh,47
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt24
	call WriteString
mov dh,48
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt25
	call WriteString
mov dh,49
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt26
	call WriteString
mov dh,50
mov dl,41
	call Gotoxy
mov edx,OFFSET grid3_prompt27
	call WriteString
	ret
PrintGrid3 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;            level 2 grid print proc                                            ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintGrid2 PROC
	mov eax,brown+(black*16)
	call SetTextColor
    mov dh,24
	mov dl,41
	call Gotoxy
	mov edx,OFFSET grid2_prompt1
	call WriteString
    mov dh,25
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt2
	call WriteString
	mov dh,26
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt3
	call WriteString
mov dh,27
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt4
	call WriteString
mov dh,28
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt5
	call WriteString
mov dh,29
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt6
	call WriteString
mov dh,30
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt7
	call WriteString
mov dh,31
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt8
	call WriteString
mov dh,32
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt9
	call WriteString
mov dh,33
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt10
	call WriteString
mov dh,34
mov dl,41
	call Gotoxy
   mov edx,OFFSET grid2_prompt11
call WriteString
mov dh,35
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt12
	call WriteString
mov dh,36
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt13
	call WriteString
mov dh,37
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt14
	call WriteString
mov dh,38
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt15
	call WriteString
mov dh,39
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt16
	call WriteString
mov dh,40
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt17
	call WriteString
mov dh,41
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt18
	call WriteString
mov dh,42
    mov dl,41
call Gotoxy
mov edx,OFFSET grid2_prompt19
	call WriteString
mov dh,43
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt20
	call WriteString
mov dh,44
mov dl,41
   call Gotoxy
mov edx,OFFSET grid2_prompt21
	call WriteString
mov dh,45
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt22
	call WriteString
mov dh,46
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt23
	call WriteString
mov dh,47
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt24
	call WriteString
mov dh,48
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt25
	call WriteString
mov dh,49
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt26
	call WriteString
mov dh,50
mov dl,41
	call Gotoxy
mov edx,OFFSET grid2_prompt27
	call WriteString
	ret
PrintGrid2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;               movement check  proc                                            ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


check_up proc
    pushad
   
   cmp mov_dir,'u'
   jne down_chk
    mov allow,0
    movzx ebx , xpos
    sub ebx,41
     mov edx,0
    mov dl, ypos
    sub dl,24
    jmp start_check
 down_chk:
cmp mov_dir,'d'
   jne left_chk
    mov allow,0
    movzx ebx , xpos
    sub ebx,41
     mov edx,0
    mov dl, ypos
    sub dl,22
    jmp start_check
left_chk:
cmp mov_dir,'l'
   jne right_chk
	mov allow,0
	movzx ebx , xpos
	sub ebx,42
	 mov edx,0
	mov dl, ypos
	sub dl,23
jmp start_check

right_chk:
cmp mov_dir,'r'
   jne end_chk
	mov allow,0
	movzx ebx , xpos
	sub ebx,40
	 mov edx,0
	mov dl, ypos
	sub dl,23
jmp start_check

start_check:
      cmp level ,1
		je start_check_1
		cmp level,2
		  je start_check_2
		  cmp level,3
			je start_check_3

start_check_1:

    cmp dl,1
     jne check_up1
       cmp grid1_prompt1[ebx],' '
           je allow_mov1
               cmp grid1_prompt1[ebx],'.'
				jne end_chk
                 mov grid1_prompt1[ebx] ,' '
                  mov allow,1
                   
                  inc score
                  inc chk_score
              jmp end_chk
check_up1:
        cmp dl,2
        jne check_up2
            cmp grid1_prompt2[ebx],' '
		   je allow_mov1
               cmp grid1_prompt2[ebx],'.'
				jne end_chk
                 mov grid1_prompt2[ebx],' '
                  mov allow,1
                   
                  inc score
                   inc chk_score
                
			  jmp end_chk
check_up2:
		cmp dl,3
		jne check_up3
			cmp grid1_prompt3[ebx],' '
             je allow_mov1
               cmp grid1_prompt3[ebx],'.'
				jne end_chk
                mov  grid1_prompt3[ebx],' '
                  mov allow,1
                   
                  inc score
                   inc chk_score
				jmp end_chk
check_up3:
 	cmp dl,4
		jne check_up4
			cmp grid1_prompt4[ebx],' '
			 je allow_mov1
               cmp grid1_prompt4[ebx],'.'
				jne end_chk
                 mov grid1_prompt4[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				jmp end_chk
check_up4:
         cmp dl,5
		jne check_up5
			cmp grid1_prompt5[ebx],' '
			 je allow_mov1
               cmp grid1_prompt5[ebx],'.'
				jne end_chk
                mov  grid1_prompt5[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				jmp end_chk
check_up5:
		 cmp dl,6
           jne check_up6
cmp grid1_prompt6[ebx],' '
			 je allow_mov1
               cmp grid1_prompt6[ebx],'.'
				jne end_chk
                mov  grid1_prompt6[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				jmp end_chk
check_up6:
    cmp dl,7
		   jne check_up7
               cmp grid1_prompt7[ebx],' '
                je allow_mov1
               cmp grid1_prompt7[ebx],'.'
				jne end_chk
                 mov grid1_prompt7[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                 jmp end_chk
check_up7:
          cmp dl,8
		   jne check_up8
			   cmp grid1_prompt8[ebx],' '
				je allow_mov1
               cmp grid1_prompt8[ebx],'.'
				jne end_chk
                  mov grid1_prompt8[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				 jmp end_chk
check_up8:
		  cmp dl,9
           jne check_up9
			   cmp grid1_prompt9[ebx],' '
                je allow_mov1
               cmp grid1_prompt9[ebx],'.'
				jne end_chk
                  mov grid1_prompt9[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                 jmp end_chk 
check_up9:
           cmp dl,10
		   jne check_up10
			   cmp grid1_prompt10[ebx],' '
				je allow_mov1
               cmp grid1_prompt10[ebx],'.'
				jne end_chk
                 mov  grid1_prompt10[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				 jmp end_chk
check_up10: 
           cmp dl,11
		   jne check_up11
			   cmp grid1_prompt11[ebx],' '
				je allow_mov1
               cmp grid1_prompt11[ebx],'.'
				jne end_chk
                 mov grid1_prompt11[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				 jmp end_chk
check_up11:
		   cmp dl,12
             jne check_up12
			   cmp grid1_prompt12[ebx],' '
                 je allow_mov1
               cmp grid1_prompt12[ebx],'.'
				jne end_chk
                 mov grid1_prompt12[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                    jmp end_chk
check_up12:
           cmp dl,13
			 jne check_up13
			   cmp grid1_prompt13[ebx],' '
				je allow_mov1
               cmp grid1_prompt13[ebx],'.'
				jne end_chk
                 mov grid1_prompt13[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk
check_up13:
		   cmp dl,14
             jne check_up14
			   cmp grid1_prompt14[ebx],' '
                je allow_mov1
               cmp grid1_prompt14[ebx],'.'
				jne end_chk
                 mov grid1_prompt14[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk
check_up14:
           cmp dl,15
			 jne check_up15
			   cmp grid1_prompt15[ebx],' '
				je allow_mov1
               cmp grid1_prompt15[ebx],'.'
				jne end_chk
                 mov grid1_prompt15[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk
check_up15:
           cmp dl,16
			 jne check_up16
			   cmp grid1_prompt16[ebx],' '
				je allow_mov1
               cmp grid1_prompt16[ebx],'.'
				jne end_chk
                 mov grid1_prompt16[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk
check_up16:
		   cmp dl,17
             jne check_up17
			   cmp grid1_prompt17[ebx],' '
				je allow_mov1
               cmp grid1_prompt17[ebx],'.'
				jne end_chk
                 mov grid1_prompt17[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                 jmp end_chk
check_up17:
              cmp dl,18
			 jne check_up18
			   cmp grid1_prompt18[ebx],' '
			je allow_mov1
               cmp grid1_prompt18[ebx],'.'
				jne end_chk
                 mov grid1_prompt18[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk
check_up18:
            cmp dl,19
			 jne check_up19
			   cmp grid1_prompt19[ebx],' '
				je allow_mov1
               cmp grid1_prompt19[ebx],'.'
				jne end_chk
                 mov grid1_prompt19[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                  jmp end_chk
check_up19:
		   cmp dl,20
jne check_up20
			   cmp grid1_prompt20[ebx],' '
je allow_mov1
               cmp grid1_prompt20[ebx],'.'
				jne end_chk
                 mov grid1_prompt20[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
jmp end_chk
check_up20:
		   cmp dl,21
jne check_up21
			   cmp grid1_prompt21[ebx],' '
je allow_mov1
               cmp grid1_prompt21[ebx],'.'
				jne end_chk
                 mov grid1_prompt21[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                  jmp end_chk
check_up21:
		   cmp dl,22
            jne check_up22
			   cmp grid1_prompt22[ebx],' '
               je allow_mov1
               cmp grid1_prompt22[ebx],'.'
				jne end_chk
                 mov grid1_prompt22[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				 jmp end_chk
check_up22:
            cmp dl,23
			 jne check_up23
			   cmp grid1_prompt23[ebx],' '
			je allow_mov1
               cmp grid1_prompt23[ebx],'.'
				jne end_chk
                 mov grid1_prompt23[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
				 jmp end_chk
check_up23:
              cmp dl,24
			 jne check_up24
			   cmp grid1_prompt24[ebx],' '
				je allow_mov1
               cmp grid1_prompt24[ebx],'.'
				jne end_chk
                 mov grid1_prompt24[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk
check_up24:
			cmp dl,25
              jne check_up25
			   cmp grid1_prompt25[ebx],' '
                  je allow_mov1
               cmp grid1_prompt25[ebx],'.'
				jne end_chk
                 mov grid1_prompt25[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
                     jmp end_chk
 check_up25:
         cmp dl,26
			 jne check_up26
			   cmp grid1_prompt26[ebx],' '
				je allow_mov1
               cmp grid1_prompt26[ebx],'.'
				jne end_chk
                 mov grid1_prompt26[ebx],' '
                  mov allow,1
                   
                  inc score
                   inc chk_score
					jmp end_chk
check_up26:
               cmp dl,27
			 jne end_chk
			   cmp grid1_prompt27[ebx],' '
				je allow_mov1
               cmp grid1_prompt27[ebx],'.'
				jne end_chk
                 mov grid1_prompt27[ebx],' '
                  mov allow,1
                  inc score
                   inc chk_score
					jmp end_chk

start_check_2:

    cmp dl,1
     jne check2_up1
       cmp grid2_prompt1[ebx],' '
           je allow_mov1
               cmp grid2_prompt1[ebx],'.'
				jne end_chk
                 mov grid2_prompt1[ebx] ,' '
                  mov allow,1
                  add score,2
                  add chk_score,2
              jmp end_chk
check2_up1:
        cmp dl,2
        jne check2_up2
            cmp grid2_prompt2[ebx],' '
		   je allow_mov1
               cmp grid2_prompt2[ebx],'.'
				jne end_chk
                 mov grid2_prompt2[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                
			  jmp end_chk
check2_up2:
		cmp dl,3
		jne check2_up3
			cmp grid2_prompt3[ebx],' '
             je allow_mov1
               cmp grid2_prompt3[ebx],'.'
				jne end_chk
                mov  grid2_prompt3[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				jmp end_chk
check2_up3:
 	cmp dl,4
		jne check2_up4
			cmp grid2_prompt4[ebx],' '
			 je allow_mov1
               cmp grid2_prompt4[ebx],'.'
				jne end_chk
                 mov grid2_prompt4[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				jmp end_chk
check2_up4:
         cmp dl,5
		jne check2_up5
			cmp grid2_prompt5[ebx],' '
			 je allow_mov1
               cmp grid2_prompt5[ebx],'.'
				jne end_chk
                mov  grid2_prompt5[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				jmp end_chk
check2_up5:
		 cmp dl,6
           jne check2_up6
cmp grid2_prompt6[ebx],' '
			 je allow_mov1
               cmp grid2_prompt6[ebx],'.'
				jne end_chk
                mov  grid2_prompt6[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				jmp end_chk
check2_up6:
    cmp dl,7
		   jne check2_up7
               cmp grid2_prompt7[ebx],' '
                je allow_mov1
               cmp grid2_prompt7[ebx],'.'
				jne end_chk
                 mov grid2_prompt7[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                 jmp end_chk
check2_up7:
          cmp dl,8
		   jne check2_up8
			   cmp grid2_prompt8[ebx],' '
				je allow_mov1
               cmp grid2_prompt8[ebx],'.'
				jne end_chk
                  mov grid2_prompt8[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				 jmp end_chk
check2_up8:
		  cmp dl,9
           jne check2_up9
			   cmp grid2_prompt9[ebx],' '
                je allow_mov1
               cmp grid2_prompt9[ebx],'.'
				jne end_chk
                  mov grid2_prompt9[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                 jmp end_chk 
check2_up9:
           cmp dl,10
		   jne check2_up10
			   cmp grid2_prompt10[ebx],' '
				je allow_mov1
               cmp grid2_prompt10[ebx],'.'
				jne end_chk
                 mov  grid2_prompt10[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				 jmp end_chk
check2_up10: 
           cmp dl,11
		   jne check2_up11
			   cmp grid2_prompt11[ebx],' '
				je allow_mov1
               cmp grid2_prompt11[ebx],'.'
				jne end_chk
                 mov grid2_prompt11[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				 jmp end_chk
check2_up11:
		   cmp dl,12
             jne check2_up12
			   cmp grid2_prompt12[ebx],' '
                 je allow_mov1
               cmp grid2_prompt12[ebx],'.'
				jne end_chk
                 mov grid2_prompt12[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                    jmp end_chk
check2_up12:
           cmp dl,13
			 jne check2_up13
			   cmp grid2_prompt13[ebx],' '
				je allow_mov1
               cmp grid2_prompt13[ebx],'.'
				jne end_chk
                 mov grid2_prompt13[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk
check2_up13:
		   cmp dl,14
             jne check2_up14
			   cmp grid2_prompt14[ebx],' '
                je allow_mov1
               cmp grid2_prompt14[ebx],'.'
				jne end_chk
                 mov grid2_prompt14[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk
check2_up14:
           cmp dl,15
			 jne check2_up15
			   cmp grid2_prompt15[ebx],' '
				je allow_mov1
               cmp grid2_prompt15[ebx],'.'
				jne end_chk
                 mov grid2_prompt15[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk
check2_up15:
           cmp dl,16
			 jne check2_up16
			   cmp grid2_prompt16[ebx],' '
				je allow_mov1
               cmp grid2_prompt16[ebx],'.'
				jne end_chk
                 mov grid2_prompt16[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk
check2_up16:
		   cmp dl,17
             jne check2_up17
			   cmp grid2_prompt17[ebx],' '
				je allow_mov1
               cmp grid2_prompt17[ebx],'.'
				jne end_chk
                 mov grid2_prompt17[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                 jmp end_chk
check2_up17:
              cmp dl,18
			 jne check2_up18
			   cmp grid2_prompt18[ebx],' '
			je allow_mov1
               cmp grid2_prompt18[ebx],'.'
				jne end_chk
                 mov grid2_prompt18[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk
check2_up18:
            cmp dl,19
			 jne check2_up19
			   cmp grid2_prompt19[ebx],' '
				je allow_mov1
               cmp grid2_prompt19[ebx],'.'
				jne end_chk
                 mov grid2_prompt19[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                  jmp end_chk
check2_up19:
		   cmp dl,20
jne check2_up20
			   cmp grid2_prompt20[ebx],' '
je allow_mov1
               cmp grid2_prompt20[ebx],'.'
				jne end_chk
                 mov grid2_prompt20[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
jmp end_chk
check2_up20:
		   cmp dl,21
jne check2_up21
			   cmp grid2_prompt21[ebx],' '
je allow_mov1
               cmp grid2_prompt21[ebx],'.'
				jne end_chk
                 mov grid2_prompt21[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                  jmp end_chk
check2_up21:
		   cmp dl,22
            jne check2_up22
			   cmp grid2_prompt22[ebx],' '
               je allow_mov1
               cmp grid2_prompt22[ebx],'.'
				jne end_chk
                 mov grid2_prompt22[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				 jmp end_chk
check2_up22:
            cmp dl,23
			 jne check2_up23
			   cmp grid2_prompt23[ebx],' '
			je allow_mov1
               cmp grid2_prompt23[ebx],'.'
				jne end_chk
                 mov grid2_prompt23[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
				 jmp end_chk
check2_up23:
              cmp dl,24
			 jne check2_up24
			   cmp grid2_prompt24[ebx],' '
				je allow_mov1
               cmp grid2_prompt24[ebx],'.'
				jne end_chk
                 mov grid2_prompt24[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk
check2_up24:
			cmp dl,25
              jne check2_up25
			   cmp grid2_prompt25[ebx],' '
                  je allow_mov1
               cmp grid2_prompt25[ebx],'.'
				jne end_chk
                 mov grid2_prompt25[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
                     jmp end_chk
 check2_up25:
         cmp dl,26
			 jne check2_up26
			   cmp grid2_prompt26[ebx],' '
				je allow_mov1
               cmp grid2_prompt26[ebx],'.'
				jne end_chk
                 mov grid2_prompt26[ebx],' '
                  mov allow,1
                  add score,2
                  
                  add chk_score,2
					jmp end_chk
check2_up26:
               cmp dl,27
			 jne end_chk
			   cmp grid2_prompt27[ebx],' '
				je allow_mov1
               cmp grid2_prompt27[ebx],'.'
				jne end_chk
                 mov grid2_prompt27[ebx],' '
                  mov allow,1
                  add score,2
                  add chk_score,2
					jmp end_chk



start_check_3:

    cmp dl,1
     jne check3_up1
       cmp grid3_prompt1[ebx],' '
           je allow_mov1
               cmp grid3_prompt1[ebx],'.'
				jne end_chk
                 mov grid3_prompt1[ebx] ,' '
                  mov allow,1
                  add score,3
                  add chk_score,3
              jmp end_chk
check3_up1:
        cmp dl,2
        jne check3_up2
            cmp grid3_prompt2[ebx],' '
		   je allow_mov1
               cmp grid3_prompt2[ebx],'.'
				jne end_chk
                 mov grid3_prompt2[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                
			  jmp end_chk
check3_up2:
		cmp dl,3
		jne check3_up3
			cmp grid3_prompt3[ebx],' '
             je allow_mov1
               cmp grid3_prompt3[ebx],'.'
				jne end_chk
                mov  grid3_prompt3[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				jmp end_chk
check3_up3:
 	cmp dl,4
		jne check3_up4
			cmp grid3_prompt4[ebx],' '
			 je allow_mov1
               cmp grid3_prompt4[ebx],'.'
				jne end_chk
                 mov grid3_prompt4[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				jmp end_chk
check3_up4:
         cmp dl,5
		jne check3_up5
			cmp grid3_prompt5[ebx],' '
			 je allow_mov1
               cmp grid3_prompt5[ebx],'.'
				jne end_chk
                mov  grid3_prompt5[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				jmp end_chk
check3_up5:
		 cmp dl,6
           jne check3_up6
cmp grid3_prompt6[ebx],' '
			 je allow_mov1
               cmp grid3_prompt6[ebx],'.'
				jne end_chk
                mov  grid3_prompt6[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				jmp end_chk
check3_up6:
    cmp dl,7
		   jne check3_up7
               cmp grid3_prompt7[ebx],' '
                je allow_mov1
               cmp grid3_prompt7[ebx],'.'
				jne end_chk
                 mov grid3_prompt7[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                 jmp end_chk
check3_up7:
          cmp dl,8
		   jne check3_up8
			   cmp grid3_prompt8[ebx],' '
				je allow_mov1
               cmp grid3_prompt8[ebx],'.'
				jne end_chk
                  mov grid3_prompt8[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				 jmp end_chk
check3_up8:
		  cmp dl,9
           jne check3_up9
			   cmp grid3_prompt9[ebx],' '
                je allow_mov1
               cmp grid3_prompt9[ebx],'.'
				jne end_chk
                  mov grid3_prompt9[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                 jmp end_chk 
check3_up9:
           cmp dl,10
		   jne check3_up10
			   cmp grid3_prompt10[ebx],' '
				je allow_mov1
               cmp grid3_prompt10[ebx],'.'
				jne end_chk
                 mov  grid3_prompt10[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				 jmp end_chk
check3_up10: 
           cmp dl,11
		   jne check3_up11
			   cmp grid3_prompt11[ebx],' '
				je allow_mov1
               cmp grid3_prompt11[ebx],'.'
				jne end_chk
                 mov grid3_prompt11[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				 jmp end_chk
check3_up11:
		   cmp dl,12
             jne check3_up12
			   cmp grid3_prompt12[ebx],' '
                 je allow_mov1
               cmp grid3_prompt12[ebx],'.'
				jne end_chk
                 mov grid3_prompt12[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                    jmp end_chk
check3_up12:
           cmp dl,13
			 jne check3_up13
			   cmp grid3_prompt13[ebx],' '
				je allow_mov1
               cmp grid3_prompt13[ebx],'.'
				jne end_chk
                 mov grid3_prompt13[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up13:
		   cmp dl,14
             jne check3_up14
			   cmp grid3_prompt14[ebx],' '
                je allow_mov1
               cmp grid3_prompt14[ebx],'.'
				jne end_chk
                 mov grid3_prompt14[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up14:
           cmp dl,15
			 jne check3_up15
			   cmp grid3_prompt15[ebx],' '
				je allow_mov1
               cmp grid3_prompt15[ebx],'.'
				jne end_chk
                 mov grid3_prompt15[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up15:
           cmp dl,16
			 jne check3_up16
			   cmp grid3_prompt16[ebx],' '
				je allow_mov1
               cmp grid3_prompt16[ebx],'.'
				jne end_chk
                 mov grid3_prompt16[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up16:
		   cmp dl,17
             jne check3_up17
			   cmp grid3_prompt17[ebx],' '
				je allow_mov1
               cmp grid3_prompt17[ebx],'.'
				jne end_chk
                 mov grid3_prompt17[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                 jmp end_chk
check3_up17:
              cmp dl,18
			 jne check3_up18
			   cmp grid3_prompt18[ebx],' '
			je allow_mov1
               cmp grid3_prompt18[ebx],'.'
				jne end_chk
                 mov grid3_prompt18[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up18:
            cmp dl,19
			 jne check3_up19
			   cmp grid3_prompt19[ebx],' '
				je allow_mov1
               cmp grid3_prompt19[ebx],'.'
				jne end_chk
                 mov grid3_prompt19[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                  jmp end_chk
check3_up19:
		   cmp dl,20
jne check3_up20
			   cmp grid3_prompt20[ebx],' '
je allow_mov1
               cmp grid3_prompt20[ebx],'.'
				jne end_chk
                 mov grid3_prompt20[ebx],' '
                  mov allow,1
                  add chk_score,3
                  add score,3
jmp end_chk
check3_up20:
		   cmp dl,21
jne check3_up21
			   cmp grid3_prompt21[ebx],' '
je allow_mov1
               cmp grid3_prompt21[ebx],'.'
				jne end_chk
                 mov grid3_prompt21[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                  jmp end_chk
check3_up21:
		   cmp dl,22
            jne check3_up22
			   cmp grid3_prompt22[ebx],' '
               je allow_mov1
               cmp grid3_prompt22[ebx],'.'
				jne end_chk
                 mov grid3_prompt22[ebx],' '
                  mov allow,1
                  add chk_score,3
                  add score,3
				 jmp end_chk
check3_up22:
            cmp dl,23
			 jne check3_up23
			   cmp grid3_prompt23[ebx],' '
			je allow_mov1
               cmp grid3_prompt23[ebx],'.'
				jne end_chk
                 mov grid3_prompt23[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
				 jmp end_chk
check3_up23:
              cmp dl,24
			 jne check3_up24
			   cmp grid3_prompt24[ebx],' '
				je allow_mov1
               cmp grid3_prompt24[ebx],'.'
				jne end_chk
                 mov grid3_prompt24[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up24:
			cmp dl,25
              jne check3_up25
			   cmp grid3_prompt25[ebx],' '
                  je allow_mov1
               cmp grid3_prompt25[ebx],'.'
				jne end_chk
                 mov grid3_prompt25[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
                     jmp end_chk
 check3_up25:
         cmp dl,26
			 jne check3_up26
			   cmp grid3_prompt26[ebx],' '
				je allow_mov1
               cmp grid3_prompt26[ebx],'.'
				jne end_chk
                 mov grid3_prompt26[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk
check3_up26:
               cmp dl,27
			 jne end_chk
			   cmp grid3_prompt27[ebx],' '
				je allow_mov1
               cmp grid3_prompt27[ebx],'.'
				jne end_chk
                 mov grid3_prompt27[ebx],' '
                  mov allow,1
                  add score,3
                  add chk_score,3
					jmp end_chk

allow_mov1:
	  mov allow,1
      
end_chk:
popad
ret
check_up endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                               ;;
;;              Game over menu  proc                                             ;;
;;                                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Game_over_fun proc

      call clrscr
      call printpacman

      mov dl , 62
      mov dh,21
call Gotoxy
mov edx,OFFSET game_over1
call WriteString
mov dl , 62
	  mov dh,22
call Gotoxy
mov edx,OFFSET game_over2
call WriteString
mov dl , 62
	  mov dh,23
call Gotoxy
mov edx,OFFSET game_over3
call WriteString

mov dl , 62
	  mov dh,24
call Gotoxy
mov edx,OFFSET game_over4
call WriteString


mov dl , 62
	  mov dh,27
call Gotoxy
mov edx,OFFSET username
call WriteString

dec dl
mov edx,OFFSET strscore1
call WriteString
mov eax,score
        call Writedec

        call printexit

		


        input___char:
        call readchar
        cmp al,0
        jne input___char
		call filehandlingfunc 
        exit

ret
Game_over_fun endp






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;;                   CheckValidMovementG                     ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CheckValidMovementG PROC
	pushad
	movzx eax,xPosG
	sub eax,41
	mov ecx,eax
	movzx ebx,yPosG
	cmp updownleftrightG,1
	je downaaG
	cmp updownleftrightG,2
	je upaaG
	cmp updownleftrightG,3
	je rightaaG
	cmp updownleftrightG,4
	je leftaaG
upaaG:
	cmp ebx,50
	je checkgrid26
	cmp ebx,49
	je checkgrid25
	cmp ebx,48
	je checkgrid24
	cmp ebx,47
	je checkgrid23
	cmp ebx,46
	je checkgrid22
	cmp ebx,45
	je checkgrid21
	cmp ebx,44
	je checkgrid20
	cmp ebx,43
	je checkgrid19
	cmp ebx,42
	je checkgrid18
	cmp ebx,41
	je checkgrid17
	cmp ebx,40
	je checkgrid16
	cmp ebx,39
	je checkgrid15
	cmp ebx,38
	je checkgrid14
	cmp ebx,37
	je checkgrid13
	cmp ebx,36
	je checkgrid12
	cmp ebx,35
	je checkgrid11
	cmp ebx,34
	je checkgrid10
	cmp ebx,33
	je checkgrid9
	cmp ebx,32
	je checkgrid8
	cmp ebx,31
	je checkgrid7
	cmp ebx,30
	je checkgrid6
	cmp ebx,29
	je checkgrid5
	cmp ebx,28
	je checkgrid4
	cmp ebx,27
	je checkgrid3
	cmp ebx,26
	je checkgrid2
	jmp return12a
downaaG:
	cmp ebx,25
	je checkgrid3
	cmp ebx,26
	je checkgrid4
	cmp ebx,27
	je checkgrid5
	cmp ebx,28
	je checkgrid6
	cmp ebx,29
	je checkgrid7
	cmp ebx,30
	je checkgrid8
	cmp ebx,31
	je checkgrid9
	cmp ebx,32
	je checkgrid10
	cmp ebx,33
	je checkgrid11
	cmp ebx,34
	je checkgrid12
	cmp ebx,35
	je checkgrid13
	cmp ebx,36
	je checkgrid14
	cmp ebx,37
	je checkgrid15
	cmp ebx,38
	je checkgrid16
	cmp ebx,39
	je checkgrid17
	cmp ebx,40
	je checkgrid18
	cmp ebx,41
	je checkgrid19
	cmp ebx,42
	je checkgrid20
	cmp ebx,43
	je checkgrid21
	cmp ebx,44
	je checkgrid22
	cmp ebx,45
	je checkgrid23
	cmp ebx,46
	je checkgrid24
	cmp ebx,47
	je checkgrid25
	cmp ebx,48
	je checkgrid26
	jmp return12a
rightaaG:
	cmp ecx,119
	jge return12a
	add eax,1
	cmp ebx,49
	je checkgrid26
	cmp ebx,48
	je checkgrid25
	cmp ebx,47
	je checkgrid24
	cmp ebx,46
	je checkgrid23
	cmp ebx,45
	je checkgrid22
	cmp ebx,44
	je checkgrid21
	cmp ebx,43
	je checkgrid20
	cmp ebx,42
	je checkgrid19
	cmp ebx,41
	je checkgrid18
	cmp ebx,40
	je checkgrid17
	cmp ebx,39
	je checkgrid16
	cmp ebx,38
	je checkgrid15
	cmp ebx,37
	je checkgrid14
	cmp ebx,36
	je checkgrid13
	cmp ebx,35
	je checkgrid12
	cmp ebx,34
	je checkgrid11
	cmp ebx,33
	je checkgrid10
	cmp ebx,32
	je checkgrid9
	cmp ebx,31
	je checkgrid8
	cmp ebx,30
	je checkgrid7
	cmp ebx,29
	je checkgrid6
	cmp ebx,28
	je checkgrid5
	cmp ebx,27
	je checkgrid4
	cmp ebx,26
	je checkgrid3
	cmp ebx,25
	je checkgrid2
	jmp return12a
leftaaG:
	cmp ecx,0
	jle return12a
	sub eax,1
	cmp ebx,49
	je checkgrid26
	cmp ebx,48
	je checkgrid25
	cmp ebx,47
	je checkgrid24
	cmp ebx,46
	je checkgrid23
	cmp ebx,45
	je checkgrid22
	cmp ebx,44
	je checkgrid21
	cmp ebx,43
	je checkgrid20
	cmp ebx,42
	je checkgrid19
	cmp ebx,41
	je checkgrid18
	cmp ebx,40
	je checkgrid17
	cmp ebx,39
	je checkgrid16
	cmp ebx,38
	je checkgrid15
	cmp ebx,37
	je checkgrid14
	cmp ebx,36
	je checkgrid13
	cmp ebx,35
	je checkgrid12
	cmp ebx,34
	je checkgrid11
	cmp ebx,33
	je checkgrid10
	cmp ebx,32
	je checkgrid9
	cmp ebx,31
	je checkgrid8
	cmp ebx,30
	je checkgrid7
	cmp ebx,29
	je checkgrid6
	cmp ebx,28
	je checkgrid5
	cmp ebx,27
	je checkgrid4
	cmp ebx,26
	je checkgrid3
	cmp ebx,25
	je checkgrid2
	jmp return12a
checkgrid26:
	cmp level,1
	jne l2checkgrid26
	cmp	grid1_prompt26[eax],' '
	je validuponG
	cmp	grid1_prompt26[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid26:
		cmp level,2
		jne l3checkgrid26		
		cmp	grid2_prompt26[eax],' '
		je validuponG
		cmp	grid2_prompt26[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid26:
			cmp	grid3_prompt26[eax],' '
			je validuponG
			cmp	grid3_prompt26[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid25:
    cmp level,1
	jne l2checkgrid25
	cmp	grid1_prompt25[eax],' '
	je validuponG
	cmp	grid1_prompt25[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid25:
		cmp level,2
		jne l3checkgrid25
		cmp	grid2_prompt25[eax],' '
		je validuponG
		cmp	grid2_prompt25[eax],'.'
		jne return12a
		jmp validuponG
		l3checkgrid25:
			cmp	grid3_prompt25[eax],' '
			je validuponG
			cmp	grid3_prompt25[eax],'.'
			jne return12a
			jmp validuponG
checkgrid24:
    cmp level,1
	jne l2checkgrid24
	cmp	grid1_prompt24[eax],' '
	je validuponG
	cmp	grid1_prompt24[eax],'.'
	jne return12a
	jmp validuponG
	l2checkgrid24:
		cmp	level,2
		jne l3checkgrid24
		cmp	grid2_prompt24[eax],' '
		je validuponG
		cmp	grid2_prompt24[eax],'.'
		jne return12a
		jmp validuponG
		l3checkgrid24:
			cmp	grid3_prompt24[eax],' '
			je validuponG
			cmp	grid3_prompt24[eax],'.'
			jne return12a
			jmp validuponG
checkgrid23:
	cmp level,1
	jne l2checkgrid23
	cmp	grid1_prompt23[eax],' '
	je validuponG
	cmp	grid1_prompt23[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid23:
		cmp	level,2
		jne l3checkgrid23
		cmp	grid2_prompt23[eax],' '
		je validuponG
		cmp	grid2_prompt23[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid23:
			cmp	grid3_prompt23[eax],' '
			je validuponG
			cmp	grid3_prompt23[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid22:
	cmp level,1
	jne l2checkgrid22
	cmp	grid1_prompt22[eax],' '
	je validuponG
	cmp	grid1_prompt22[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid22:
		cmp	level,2
		jne l3checkgrid22
		cmp	grid2_prompt22[eax],' '
		je validuponG
		cmp	grid2_prompt22[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid22:
			cmp	grid3_prompt22[eax],' '
			je validuponG
			cmp	grid3_prompt22[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid21:
	cmp level,1
	jne l2checkgrid21
	cmp	grid1_prompt21[eax],' '
	je validuponG
	cmp	grid1_prompt21[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid21:
		cmp	level,2
		jne l3checkgrid21
		cmp	grid2_prompt21[eax],' '
		je validuponG
		cmp	grid2_prompt21[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid21:
			cmp	grid3_prompt21[eax],' '
			je validuponG
			cmp	grid3_prompt21[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid20:
    cmp level,1
	jne l2checkgrid20
	cmp	grid1_prompt20[eax],' '
	je validuponG
	cmp	grid1_prompt20[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid20:
		cmp	level,2
		jne l3checkgrid20
		cmp	grid2_prompt20[eax],' '
		je validuponG
		cmp	grid2_prompt20[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid20:
			cmp	grid3_prompt20[eax],' '
			je validuponG
			cmp	grid3_prompt20[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid19:
	cmp level,1
	jne l2checkgrid19
	cmp	grid1_prompt19[eax],' '
	je validuponG
	cmp	grid1_prompt19[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid19:
		cmp level,2
		jne l3checkgrid19
		cmp	grid2_prompt19[eax],' '
		je validuponG
		cmp	grid2_prompt19[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid19:
			cmp	grid3_prompt19[eax],' '
			je validuponG
			cmp	grid3_prompt19[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid18:
	cmp level,1
	jne l2checkgrid18
	cmp	grid1_prompt18[eax],' '
	je validuponG
	cmp	grid1_prompt18[eax],'.'
	jne return12a
	
	jmp validuponG
	l2checkgrid18:
	cmp level,2
	jne l3checkgrid18
		cmp	grid2_prompt18[eax],' '
		je validuponG
		cmp	grid2_prompt18[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid18:
			cmp	grid3_prompt18[eax],' '
			je validuponG
			cmp	grid3_prompt18[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid17:
	cmp level,1
	jne l2checkgrid17
	cmp	grid1_prompt17[eax],' '
	je validuponG
	cmp	grid1_prompt17[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid17:
		cmp	level,2
		jne l3checkgrid17
		cmp	grid2_prompt17[eax],' '
		je validuponG
		cmp	grid2_prompt17[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid17:
			cmp	grid3_prompt17[eax],' '
			je validuponG
			cmp	grid3_prompt17[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid16:
	cmp level,1
	jne l2checkgrid16
	cmp	grid1_prompt16[eax],' '
	je validuponG
	cmp	grid1_prompt16[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid16:
		cmp	level,2
		jne l3checkgrid16
		cmp	grid2_prompt16[eax],' '
		je validuponG
		cmp	grid2_prompt16[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid16:
			cmp	grid3_prompt16[eax],' '
			je validuponG
			cmp	grid3_prompt16[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid15:
	cmp level,1
	jne l2checkgrid15
	cmp	grid1_prompt15[eax],' '
	je validuponG
	cmp	grid1_prompt15[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid15:
		cmp	level,2
		jne l3checkgrid15
		cmp	grid2_prompt15[eax],' '
		je validuponG
		cmp	grid2_prompt15[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid15:
			cmp	grid3_prompt15[eax],' '
			je validuponG
			cmp	grid3_prompt15[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid14:
	cmp level,1
	jne l2checkgrid14
	cmp	grid1_prompt14[eax],' '
	je validuponG
	cmp	grid1_prompt14[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid14:
		cmp	level,2
		jne l3checkgrid14
		cmp	grid2_prompt14[eax],' '
		je validuponG
		cmp	grid2_prompt14[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid14:
			cmp	grid3_prompt14[eax],' '
			je validuponG
			cmp	grid3_prompt14[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid13:
	cmp level,1
	jne l2checkgrid13
	cmp	grid1_prompt13[eax],' '
	je validuponG
	cmp	grid1_prompt13[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid13:
		cmp	level,2
		jne l3checkgrid13
		cmp	grid2_prompt13[eax],' '
		je validuponG
		cmp	grid2_prompt13[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid13:
			cmp	grid3_prompt13[eax],' '
			je validuponG
			cmp	grid3_prompt13[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid12:
	cmp level,1
	jne l2checkgrid12
	cmp	grid1_prompt12[eax],' '
	je validuponG
	cmp	grid1_prompt12[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid12:
		cmp	level,2
		jne l3checkgrid12
		cmp	grid2_prompt12[eax],' '
		je validuponG
		cmp	grid2_prompt12[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid12:
			cmp	grid3_prompt12[eax],' '
			je validuponG
			cmp	grid3_prompt12[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid11:
	cmp level,1
	jne l2checkgrid11
	cmp	grid1_prompt11[eax],' '
	je validuponG
	cmp	grid1_prompt11[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid11:
		cmp	level,2
		jne l3checkgrid11
		cmp	grid2_prompt11[eax],' '
		je validuponG
		cmp	grid2_prompt11[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid11:
			cmp	grid3_prompt11[eax],' '
			je validuponG
			cmp	grid3_prompt11[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid10:
	cmp level,1
	jne l2checkgrid10
	cmp	grid1_prompt10[eax],' '
	je validuponG
	cmp	grid1_prompt10[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid10:
		cmp	level,2
		jne l3checkgrid10
		cmp	grid2_prompt10[eax],' '
		je validuponG
		cmp	grid2_prompt10[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid10:
			cmp	grid3_prompt10[eax],' '
			je validuponG
			cmp	grid3_prompt10[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid9:
	cmp level,1
	jne l2checkgrid9
	cmp	grid1_prompt9[eax],' '
	je validuponG
	cmp	grid1_prompt9[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid9:
		cmp	level,2
		jne l3checkgrid9
		cmp	grid2_prompt9[eax],' '
		je validuponG
		cmp	grid2_prompt9[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid9:
			cmp	grid3_prompt9[eax],' '
			je validuponG
			cmp	grid3_prompt9[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid8:
	cmp level,1
	jne l2checkgrid8
	cmp	grid1_prompt8[eax],' '
	je validuponG
	cmp	grid1_prompt8[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid8:
		cmp	level,2
		jne l3checkgrid8
		cmp	grid2_prompt8[eax],' '
		je validuponG
		cmp	grid2_prompt8[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid8:
			cmp	grid3_prompt8[eax],' '
			je validuponG
			cmp	grid3_prompt8[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid7:
	cmp level,1
	jne l2checkgrid7
	cmp	grid1_prompt7[eax],' '
	je validuponG
	cmp	grid1_prompt7[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid7:
		cmp	level,2
		jne l3checkgrid7
		cmp	grid2_prompt7[eax],' '
		je validuponG
		cmp	grid2_prompt7[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid7:
			cmp	grid3_prompt7[eax],' '
			je validuponG
			cmp	grid3_prompt7[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid6:
	cmp level,1
	jne l2checkgrid6
	cmp	grid1_prompt6[eax],' '
	je validuponG
	cmp	grid1_prompt6[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid6:
		cmp	level,2
		jne l3checkgrid6
		cmp	grid2_prompt6[eax],' '
		je validuponG
		cmp	grid2_prompt6[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid6:
			cmp	grid3_prompt6[eax],' '
			je validuponG
			cmp	grid3_prompt6[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid5:
	cmp level,1
	jne l2checkgrid5
	cmp	grid1_prompt5[eax],' '
	je validuponG
	cmp	grid1_prompt5[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid5:
		cmp	level,2
		jne l3checkgrid5
		cmp	grid2_prompt5[eax],' '
		je validuponG
		cmp	grid2_prompt5[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid5:
			cmp	grid3_prompt5[eax],' '
			je validuponG
			cmp	grid3_prompt5[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid4:
	cmp level,1
	jne l2checkgrid4
	cmp	grid1_prompt4[eax],' '
	je validuponG
	cmp	grid1_prompt4[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid4:
		cmp	level,2
		jne l3checkgrid4
		cmp	grid2_prompt4[eax],' '
		je validuponG
		cmp	grid2_prompt4[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid4:
			cmp	grid3_prompt4[eax],' '
			je validuponG
			cmp	grid3_prompt4[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid3:
	cmp level,1
	jne l2checkgrid3
	cmp	grid1_prompt3[eax],' '
	je validuponG
	cmp	grid1_prompt3[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid3:
		cmp	level,2
		jne l3checkgrid3
		cmp	grid2_prompt3[eax],' '
		je validuponG
		cmp	grid2_prompt3[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid3:
			cmp	grid3_prompt3[eax],' '
			je validuponG
			cmp	grid3_prompt3[eax],'.'
			jne return12a
			
			
			jmp validuponG
checkgrid2:
	cmp level,1
	jne l2checkgrid2
	cmp	grid1_prompt2[eax],' '
	je validuponG
	cmp	grid1_prompt2[eax],'.'
	jne return12a
	
	
	jmp validuponG
	l2checkgrid2:
		cmp	level,2
		jne l3checkgrid2
		cmp	grid2_prompt2[eax],' '
		je validuponG
		cmp	grid2_prompt2[eax],'.'
		jne return12a
		
		
		jmp validuponG
		l3checkgrid2:
			cmp	grid3_prompt2[eax],' '
			je validuponG
			cmp	grid3_prompt2[eax],'.'
			jne return12a
			jmp validuponG
validuponG:
	mov validupG,1
	jmp return12a
return12a:
	popad
	ret
CheckValidMovementG ENDP


CheckPosition PROC
	pushad
	movzx eax,xPosG
	sub eax,41
	movzx ebx,yPosG
	cmp ebx,49
	je checkgrid26
	cmp ebx,48
	je checkgrid25
	cmp ebx,47
	je checkgrid24
	cmp ebx,46
	je checkgrid23
	cmp ebx,45
	je checkgrid22
	cmp ebx,44
	je checkgrid21
	cmp ebx,43
	je checkgrid20
	cmp ebx,42
	je checkgrid19
	cmp ebx,41
	je checkgrid18
	cmp ebx,40
	je checkgrid17
	cmp ebx,39
	je checkgrid16
	cmp ebx,38
	je checkgrid15
	cmp ebx,37
	je checkgrid14
	cmp ebx,36
	je checkgrid13
	cmp ebx,35
	je checkgrid12
	cmp ebx,34
	je checkgrid11
	cmp ebx,33
	je checkgrid10
	cmp ebx,32
	je checkgrid9
	cmp ebx,31
	je checkgrid8
	cmp ebx,30
	je checkgrid7
	cmp ebx,29
	je checkgrid6
	cmp ebx,28
	je checkgrid5
	cmp ebx,27
	je checkgrid4
	cmp ebx,26
	je checkgrid3
	cmp ebx,25
	je checkgrid2
	jmp return12a
checkgrid26:
	cmp level,1
	jne l2checkgrid26
	cmp	grid1_prompt26[eax],'.'
	jne return12a	
	jmp PositionDotOn
	l2checkgrid26:
		cmp level,2
		jne l3checkgrid26
		cmp	grid2_prompt26[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid26:
			cmp	grid3_prompt26[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid25:
    cmp level,1
	jne l2checkgrid25
	cmp	grid1_prompt25[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid25:
		cmp level,2
		jne l3checkgrid25
		cmp	grid2_prompt25[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid25:
			cmp	grid3_prompt25[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid24:
    cmp level,1
	jne l2checkgrid24
	cmp	grid1_prompt24[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid24:
		cmp	level,2
		jne l3checkgrid24
		cmp	grid2_prompt24[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid24:
			cmp	grid3_prompt24[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid23:
	cmp level,1
	jne l2checkgrid23
	cmp	grid1_prompt23[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid23:
		cmp	level,2
		jne l3checkgrid23
		cmp	grid2_prompt23[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid23:
			cmp	grid3_prompt23[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid22:
	cmp level,1
	jne l2checkgrid22
	cmp	grid1_prompt22[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid22:
		cmp	level,2
		jne l3checkgrid22
		cmp	grid2_prompt22[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid22:
			cmp	grid3_prompt22[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid21:
	cmp level,1
	jne l2checkgrid21
	cmp	grid1_prompt21[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid21:
		cmp	level,2
		jne l3checkgrid21
		cmp	grid2_prompt21[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid21:
			cmp	grid3_prompt21[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid20:
    cmp level,1
	jne l2checkgrid20
	cmp	grid1_prompt20[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid20:
		cmp	level,2
		jne l3checkgrid20
		cmp	grid2_prompt20[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid20:
			cmp	grid3_prompt20[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid19:
	cmp level,1
	jne l2checkgrid19
	cmp	grid1_prompt19[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid19:
		cmp level,2
		jne l3checkgrid19
		cmp	grid2_prompt19[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid19:
			cmp	grid3_prompt19[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid18:
	cmp level,1
	jne l2checkgrid18
	cmp	grid1_prompt18[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid18:
	cmp level,2
	jne l3checkgrid18
		cmp	grid2_prompt18[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid18:
			cmp	grid3_prompt18[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid17:
	cmp level,1
	jne l2checkgrid17
	cmp	grid1_prompt17[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid17:
		cmp	level,2
		jne l3checkgrid17
		cmp	grid2_prompt17[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid17:
			cmp	grid3_prompt17[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid16:
	cmp level,1
	jne l2checkgrid16
	cmp	grid1_prompt16[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid16:
		cmp	level,2
		jne l3checkgrid16
		cmp	grid2_prompt16[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid16:
			cmp	grid3_prompt16[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid15:
	cmp level,1
	jne l2checkgrid15
	cmp	grid1_prompt15[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid15:
		cmp	level,2
		jne l3checkgrid15
		cmp	grid2_prompt15[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid15:
			cmp	grid3_prompt15[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid14:
	cmp level,1
	jne l2checkgrid14
	cmp	grid1_prompt14[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid14:
		cmp	level,2
		jne l3checkgrid14
		cmp	grid2_prompt14[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid14:
			cmp	grid3_prompt14[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid13:
	cmp level,1
	jne l2checkgrid13
	cmp	grid1_prompt13[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid13:
		cmp	level,2
		jne l3checkgrid13
		cmp	grid2_prompt13[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid13:
			cmp	grid3_prompt13[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid12:
	cmp level,1
	jne l2checkgrid12
	cmp	grid1_prompt12[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid12:
		cmp	level,2
		jne l3checkgrid12
		cmp	grid2_prompt12[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid12:
			cmp	grid3_prompt12[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid11:
	cmp level,1
	jne l2checkgrid11
	cmp	grid1_prompt11[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid11:
		cmp	level,2
		jne l3checkgrid11
		cmp	grid2_prompt11[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid11:
			cmp	grid3_prompt11[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid10:
	cmp level,1
	jne l2checkgrid10
	cmp	grid1_prompt10[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid10:
		cmp	level,2
		jne l3checkgrid10
		cmp	grid2_prompt10[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid10:
			cmp	grid3_prompt10[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid9:
	cmp level,1
	jne l2checkgrid9
	cmp	grid1_prompt9[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid9:
		cmp	level,2
		jne l3checkgrid9
		cmp	grid2_prompt9[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid9:
			cmp	grid3_prompt9[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid8:
	cmp level,1
	jne l2checkgrid8
	cmp	grid1_prompt8[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid8:
		cmp	level,2
		jne l3checkgrid8
		cmp	grid2_prompt8[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid8:
			cmp	grid3_prompt8[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid7:
	cmp level,1
	jne l2checkgrid7
	cmp	grid1_prompt7[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid7:
		cmp	level,2
		jne l3checkgrid7
		cmp	grid2_prompt7[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid7:
			cmp	grid3_prompt7[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid6:
	cmp level,1
	jne l2checkgrid6
	cmp	grid1_prompt6[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid6:
		cmp	level,2
		jne l3checkgrid6
		cmp	grid2_prompt6[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid6:
			cmp	grid3_prompt6[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid5:
	cmp level,1
	jne l2checkgrid5
	cmp	grid1_prompt5[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid5:
		cmp	level,2
		jne l3checkgrid5
		cmp	grid2_prompt5[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid5:
			cmp	grid3_prompt5[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid4:
	cmp level,1
	jne l2checkgrid4
	cmp	grid1_prompt4[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid4:
		cmp	level,2
		jne l3checkgrid4
		cmp	grid2_prompt4[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid4:
			cmp	grid3_prompt4[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid3:
	cmp level,1
	jne l2checkgrid3
	cmp	grid1_prompt3[eax],'.'
	jne return12a
	jmp PositionDotOn
	l2checkgrid3:
		cmp	level,2
		jne l3checkgrid3
		cmp	grid2_prompt3[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid3:
			cmp	grid3_prompt3[eax],'.'
			jne return12a
			jmp PositionDotOn
checkgrid2:
	cmp level,1
	jne l2checkgrid2
	cmp	grid1_prompt2[eax],'.'
	jne return12a	
	jmp PositionDotOn
	l2checkgrid2:
		cmp	level,2
		jne l3checkgrid2
		cmp	grid2_prompt2[eax],'.'
		jne return12a
		jmp PositionDotOn
		l3checkgrid2:
			cmp	grid3_prompt2[eax],'.'
			jne return12a
			jmp PositionDotOn
PositionDotOn:
	mov ghostDot,1
	jmp return12a
return12a:
	popad
	ret
CheckPosition ENDP


FileHandling PROC
	mov edx,OFFSET filename
	call OpenInputFile
	mov fileHandle,eax
	cmp eax,INVALID_HANDLE_VALUE
	jne file_ok
	mWrite <"Cannot open file",0dh,0ah>
	jmp quit
	file_ok:
	mov edx,OFFSET buffer
	mov ecx,BUFFER_SIZE
	call ReadFromFile
	jnc check_buffer_size
	mWrite "Error reading file. "
	call WriteWindowsMsg
	jmp close_file
	check_buffer_size:
	cmp eax,BUFFER_SIZE
	jb buf_size_ok
	mWrite <"Error: Buffer too small for the file",0dh,0ah>
	jmp quit
	buf_size_ok:
	mov buffer[eax],0
    mov ebx,0
    mov ecx,3
 
	mov dh ,30
	 mov dl,65
	 call Gotoxy
	 mov edx,OFFSET highhhhh

	  call writestring 




    mov dh ,32
mov temp,dh
L1:
    mov dl,65
    mov dh,temp
call Gotoxy
L2: 
   cmp buffer[ebx],0ah
je endloop
 call gotoxy
     mov al,buffer[ebx]
	call Writechar
     inc dl
    inc ebx
jmp L2
endloop:
inc ebx
	inc temp
	inc temp
	loop L1
	call Crlf
	close_file:

	mov eax,fileHandle
	call CloseFile
quit:
ret
FileHandling ENDP



NumbToStr PROC uses ebx,x:DWORD,bbffff:DWORD

    mov     ecx,bbffff
    mov     eax,x
    mov     ebx,10
    add     ecx,ebx             ; ecx = buffer + max size of string
@@:
    xor     edx,edx
    div     ebx
    add     edx,48              ; convert the digit to ASCII
    mov     BYTE PTR [ecx],dl   ; store the character in the buffer
    dec     ecx                 ; decrement ecx pointing the buffer
    test    eax,eax             ; check if the quotient is 0
    jnz     @b

    inc     ecx
    mov     eax,ecx             ; eax points the string in the buffer
    ret

NumbToStr ENDP


filehandlingfunc PROC

 mov edx, OFFSET filename
    call OpenInputFile
    mov fileHandle, eax

    cmp eax, INVALID_HANDLE_VALUE; error opening file ?
    jne file_ok1

        mWrite <"Cannot open file", 0dh, 0ah>
        jmp quit1
    file_ok1:
    mov edx, OFFSET buffer
    mov ecx, BUFFER_SIZE
    call ReadFromFile
    jnc check_buffer_size
        mWrite "Error reading file. "
        call WriteWindowsMsg
        jmp close_file1
    check_buffer_size:
    mov sizeofbuffer, eax
    cmp eax, BUFFER_SIZE
    jb buf_size_ok1
    mWrite <"Error: Buffer too small for the file", 0dh, 0ah>
    jmp quit1
    buf_size_ok1:
    mov buffer[eax], 0
   
    call WriteDec
    call Crlf
    mov dl, 45
    mov dh, 17
    call GOTOXY
    mov edx, OFFSET buffer
   ; call WriteString
    call Crlf
    close_file1:
    mov eax, fileHandle
    call CloseFile

    quit1:


   mov edx, OFFSET filename
call CreateOutputFile
mov fileHandle, eax

cmp eax, INVALID_HANDLE_VALUE; error found ?
jne file_ok
    mov edx, OFFSET error
    call WriteString
    jmp quit

file_ok:

mov eax, OFFSET buffer

mov eax,fileHandle
mov edx, offset buffer
mov ecx, sizeofbuffer
call WriteToFile

mov ecx, eax
mov sizeofbuffer, ecx
mov stringLength, ecx
mov edi, offset buffer


;mov eax,0
;mov eax,score
;add eax, 0
; aaa
;or eax, 3030h
;mov[edi], ah
;inc edi
invoke  NumbToStr,score,ADDR bbff
push eax
push ecx
push esi
mov esi,offset bbff
mov ecx,lengthof bbff
l1111111:
     mov dl,[esi]
mov[edi], dl
inc edi
inc esi
loop l1111111
pop esi
pop ecx
pop eax
mov esi, offset space
mov dl, [esi]
mov[edi], dl
inc edi

mov eax,0
mov al,level
add eax, 0
aas
or eax, 303030h

mov[edi], al
inc edi
mov esi, offset space
mov dl, [esi]
mov[edi], dl
inc edi

mov esi,offset username
mov ecx,lengthof username
l1:
mov dl,[esi]
mov[edi], dl
inc edi
inc esi
loop l1
mov al,0ah
mov [edi],al
inc edi


mov eax, fileHandle
add sizeofbuffer, 27

mov edx, OFFSET buffer
;mov stringLength, sizeofarr
mov ecx, sizeofbuffer

call WriteToFile

mov edx, offset filename
mov eax, filehandle
call CloseFile


call Crlf

quit:
ret
filehandlingfunc ENDP

             
END main