;Mandelbrot set using x86 float point assembly
.586
.MODEL FLAT,C
.STACK
.DATA
x DD 0.0
y DD 0.0
testx DD 0.0
testy DD 0.0
tempx DD 0.0
testxy DD 4.0
xymul DD 2.0
term DD 1.0
term2 DD 0.0
temp_clear DD 0.0
do_new_row db 0Ah,0
star db "*",0
empty db " ",0

x_step DD 0.0
y_step DD 0.0

x_size DD 64.0
y_size DD 32.0

x_min DD -2.5
x_max DD 1.0

y_min DD -1.0
y_max DD 1.0

x_p DD -2.5
y_p DD -1.0

x_p_t DD -2.5
y_p_t DD -1.0

.CODE
includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

extrn printf:near
extrn exit:near

main PROC	
	finit

	; set x_step to step value based on mandel x size
	fld x_max
	fsub x_min
	fdiv x_size
	fstp x_step

	; set y_step to step value based on mandel y size
	fld y_max
	fsub y_min
	fdiv y_size
	fstp y_step

new_row:
	
	fld y_max
	fld y_p_t
	
	fcomp
	fstsw ax
	fwait
	sahf
	jb start_new_row

	fstp temp_clear

	push 0
	call exit

start_new_row:
	
	fstp temp_clear

	; Set a new y_p based on current x_p_t
	fld y_p_t
	fst y_p

	; Add y_step to y_p_t and store as new y_p_t
	fadd y_step
	fstp y_p_t

	; Set x_p_t to x_min to be ready for a new row
	fld x_min
	fstp x_p_t

new_column:

	fld x_max
	fld x_p_t
	
	fcomp
	fstsw ax
	fwait
	sahf
	jb start_new_column

	fstp temp_clear

	push offset do_new_row
    call printf
	add esp, 4

	jmp new_row

start_new_column:

	fstp temp_clear

	; Set a new x_p based on current x_p_t
	fld x_p_t
	fst x_p

	; Add x_step to x_p_t and store as new x_p_t
	fadd x_step
	fstp x_p_t

	FLDZ
	fst x
	fst y
	fstp tempx

	mov ecx, 0
test_x_y:
	fld dword ptr x
	fmul ST(0), ST(0)
	fld dword ptr y
	fmul ST(0), ST(0)
	fadd ST(0), ST(1)
	fld testxy

	cmp ecx, 16
	je cmptru16

	fcomp
	fstsw ax
	fwait
	sahf
	jb cmptru

	fstp temp_clear
	fstp temp_clear

	fld dword ptr x
	fmul ST(0), ST(0)
	fld dword ptr y
	fmul ST(0), ST(0)
	fsub ST(1), ST(0)
	fxch
	fadd x_p ;dword ptr [esp + 4]
	fstp tempx

	fstp temp_clear

	fld xymul
	fmul x
	fmul y
	fadd y_p ;dword ptr [esp + 8]
	fstp y

	fld tempx
	fstp x

	inc ecx
	jmp test_x_y

cmptru16:
	push offset star
    call printf
	add esp, 4
	
	fstp temp_clear
	fstp temp_clear
	fstp temp_clear

	jmp new_column

cmptru:
	push offset empty
    call printf
	add esp, 4
	
	fstp temp_clear
	fstp temp_clear

	jmp new_column

main ENDP

end