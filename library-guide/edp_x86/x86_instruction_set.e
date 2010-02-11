-- x86 instruction encoding

class X86_INSTRUCTION_SET

inherit

	-- XXX
		-- Mode names

	INSTRUCTION_SET_NAMES
		-- Constants for basic instruction mnemonics

creation

	make

feature

-- Table of all X86-64 instructions, available in all possible
-- execution modes, and all operand sizes etc.
-- Table is processed once to select available options for
-- selected execution mode

-- Mode(s)
-- Instruction
-- Source Mode
-- Destination mode
-- Encoding

	instruction_info: ARRAY [ INSTRUCTION_INFO ]

	execution_mode: INTEGER
	
	make(mode: INTEGER) is
			-- make instruction set table for specified execution mode
		do
			execution_mode := mode
			
			create instruction_info.make

		-- ** IMPORTANT**
		-- Maintain order of routine calls below in the same order as the
		-- declarations of the unique constants for the instruction types
		
		--	add_x86_aaa			-- Ascii adjust after addition		(unused)
		--	add_x86_aad			-- Ascii adjust before division		(unused)
		--	add_x86_aam			-- Ascii adjust after multiply		(unused)
		--	add_x86_aas			-- Ascii adjust after subtraction 	(unused)

		--	add_x86_adc			-- Add with carry					(unused)
		--	add_x86_sbc			-- Subtract with carry
		--	add_x86_add			-- Add
		--	add_x86_sub			-- Subtract
		--	add_x86_umul		-- unsigned multiply
		--	add_x86_udiv		-- unsigned divide
		--	add_x86_imul		-- signed multiply
		--	add_x86_idiv		-- signed divide
		--	add_x86_neg			-- negate
		--	add_x86_inc			-- increment
		--	add_x86_dec			-- decrement by one

		--	add_x86_and			-- bit and
		--	add_x86_or			-- bit or
		--	add_x86_xor			-- bit xor
		--	add_x86_not			-- ones complement

		--	add_x86_move		
		--	add_x86_cmov		-- conditional move
		--	add_x86_movd		-- move double
		--	add_x86_movq		-- move quad
		--	add_x86_movs		-- move string
		--	add_x86_movsx		-- move with sign extension
		--	add_x86_movzx		-- move with zero extend

		--	add_x86_enter		-- procedure entry
		--	add_x86_leave	

			add_x86_call		-- call procedure
			add_x86_ret			-- return
		--	add_x86_jcc			-- conditional jump
		--	add_x86_jmp			-- unconditional jump

		--	add_x86_bsf	 		-- Bit Scan Forward
		--	add_x86_bsr	 		-- Bit Scan Reverse

		--	add_x86_bswap		-- byte swap

		--	add_x86_bt			-- bit test
		--	add_x86_btc			-- bit test and complement
		--	add_x86_btr			-- bit test and reset
		--	add_x86_bts			-- bit test and set

		--	add_x86_cbw			-- convert byte to word
		--	add_x86_cwd			-- convert word to double word

		--	add_x86_cld			-- clear direction flag
		--	add_x86_cli			-- clear interrupt flag
		--	add_x86_cmc			-- complement carry flag
		--	add_x86_cmp			-- compare
		--	add_x86_cmps		-- compare string
		--	add_x86_cmpxchg		-- compare and exchange
		--	add_x86_cmpxchg8b	-- compare and exchange 8 bytes
		--	add_x86_cpuid	
		--	add_x86_cwd			-- convert word to double
		--	add_x86_cdq			-- convert double to quad
		--	add_x86_emms		-- empty mmx state
		--	add_x86_hlt			-- !!!
		--	add_x86_intn		-- sys call
		--	add_x86_lea			-- load effective address
		--	add_x86_loop		-- counted loop branch
		--	add_x86_nop	
		--	add_x86_pop	
		--	add_x86_popa		-- pop all general registers
		--	add_x86_popf		-- pop eflags register
		--	add_x86_push	
		--	add_x86_pusha		-- push all gen regs
		--	add_x86_pushf		-- push EFLAGS
		--	add_x86_rol	
		--	add_x86_ror			-- rotate
		--	add_x86_rdpmc		-- read performance monitoring counters
		--	add_x86_rdtsc		-- read timestamp counter
		--	add_x86_rep			-- repeat prefix
		--	add_x86_shl	
		--	add_x86_shr			-- shift
		--	add_x86_sbb			-- subtract with borrow
		--	add_x86_setcc		-- set byte on condition
		--	add_x86_stc			-- set carry flag
		--	add_x86_std			-- set direction flag
		--	add_x86_sti			-- set interrupt flag
		--	add_x86_stos		-- store string
		--	add_x86_test	
		--	add_x86_ud2			-- undefined instr: raise invalid opcode
		--	add_x86_wait		-- check pending fp exceptions
		--	add_x86_xadd		-- exchange and add
		--	add_x86_xchg		-- exchange reg/mem with reg

		--	add_x86_pand		-- quad word AND
		--	add_x86_pandn		-- quad AND-NOT
		--	add_x86_por			-- quad OR
		--	add_x86_pxor		-- quad XOR

		--	add_x86_f2xm1		-- 2^x - 1
		--	add_x86_fabs		-- floating pt abs
		--	add_x86_fadd		-- floating add
		--	add_x86_fchs		-- floating change sign
		--	add_x86_fclex		-- floating clear exception
		--	add_x86_fcmov		-- floating conditional move
		--	add_x86_fcom		-- floating compare
		--	add_x86_fdecstp		-- decrement stack top ptr
		--	add_x86_fdiv		-- floating divide
		--	add_x86_fdivr
		--	add_x86_ffree
		--	add_x86_ficom		-- floating / integer compare
		--	add_x86_fild		-- load integer
		--	add_x86_fincstp		-- incremetn stack top ptr
		--	add_x86_finit
		--	add_x86_fist		-- store integer
		--	add_x86_fld			-- load real
		--	add_x86_fldc		-- load constant
		--	add_x86_fldcw		-- load control word
		--	add_x86_fldenv		-- loadn fpu environment
		--	add_x86_fmul
		--	add_x86_fnop
		--	add_x86_fpatan		-- partial arc-tangent
		--	add_x86_fprem		-- partial remainder
		--	add_x86_fptan		-- partial tangent
		--	add_x86_frndint		-- round to integer
		--	add_x86_frstor		-- restore fpu state
		--	add_x86_fsave		-- save fpu state
		--	add_x86_fscale
		--	add_x86_fsin
		--	add_x86_fsincos
		--	add_x86_fsqrt
		--	add_x86_fst			-- store real
		--	add_x86_fstcw		-- store control word
		--	add_x86_fstenv		-- store fpu environment
		--	add_x86_fstsw		-- store status word
		--	add_x86_fsub
		--	add_x86_fsubr
		--	add_x86_ftst
		--	add_x86_fucom		-- unordered compare real
		--	add_x86_fwait
		--	add_x86_fxam		-- examine
		--	add_x86_fxchg
		--	add_x86_fxtract
		--	add_x86_fyl2x		-- compute y * log(2)x
		--	add_x86_fyl2xp1
	end
	
--##############################

-- Note p76/77 AMD-v3 listing of assembler syntax for instruction encoding
-- ~ p397 => ~ p404 AMD-v3 detailed appendix of instructions

--	add_x86_aaa is		-- Ascii adjust after addition		(unused)
--	add_x86_aad is		-- Ascii adjust before division		(unused)
--	add_x86_aam is		-- Ascii adjust after multiply		(unused)
--	add_x86_aas is		-- Ascii adjust after subtraction 	(unused)

--	add_x86_adc is		-- Add with carry					(unused)
--	add_x86_sbc is
--	add_x86_add is
--	add_x86_sub is	
--	add_x86_umul is		-- unsigned multiply
--	add_x86_udiv is		-- unsigned divide
--	add_x86_imul is		-- signed multiply
--	add_x86_idiv is		-- signed divide
--	add_x86_neg is		-- negate
--	add_x86_inc is		-- increment
--	add_x86_dec is		-- decrement by one

--	add_x86_and is	
--	add_x86_or is	
--	add_x86_xor is	
--	add_x86_not is		-- ones complement

--	add_x86_move is		
--	add_x86_cmov is		-- conditional move
--	add_x86_movd is		-- move double
--	add_x86_movq is		-- move quad
--	add_x86_movs is		-- move string
--	add_x86_movsx is	-- move with sign extension
--	add_x86_movzx is	-- move with zero extend

--	add_x86_enter is	-- procedure entry

	add_x86_leave is
			-- restore frame pointer
		do
			-- p179 AMD-v3
			-- leave	C9
			instruction_info.extend(create {INSTRUCTION_INFO}.make(Xm_all, x86_leave, 0xC9, 0, xxx))	-- Leave instruction, restore frame pointer
		end

	add_x86_call is
			-- call procedure
		do
			-- p118 AMD-v3
			-- call rel16off	E8 iw	16-bit mode
			-- call rel32off	E8 id	32/64-bit mode
			-- call reg/mem16	FF /2	
			-- call reg/mem32	FF /2
			-- call reg/mem64	FF /2	
			instruction_info.extend(create {INSTRUCTION_INFO}.make(Xm_64, x86_call, 0xFF, 0, xxx))	-- Call to absolute (calculated) address
		--	instruction_info.extend(create {INSTRUCTION_INFO}.make(Xm_64, x86_call, 0xE8, 0, xxx))	-- Call to relative address

		--	xxx.put(instruction_info.count, x86_call)
 		end
		
	add_x86_ret is
			-- return
		do
			-- p240 AMD-v3
			-- ret			C3
			-- ret imm16	C2 iw
			instruction_info.extend(create {INSTRUCTION_INFO}.make(Xm_64, x86_ret, 0xC3, 0, xxx))	-- Return: pop return address
			instruction_info.extend(create {INSTRUCTION_INFO}.make(Xm_64, x86_ret, 0xC2, 0, xxx))	-- Return: pop return address and arg bytes
		end

--	add_x86_jcc is			-- conditional jump
--	add_x86_jmp is			-- unconditional jump

--	add_x86_bsf is	 		-- Bit Scan Forward
--	add_x86_bsr is	 		-- Bit Scan Reverse

--	add_x86_bswap is		-- byte swap

--	add_x86_bt is			-- bit test
--	add_x86_btc is			-- bit test and complement
--	add_x86_btr is			-- bit test and reset
--	add_x86_bts is			-- bit test and set

--	add_x86_cbw is			-- convert byte to word
--	add_x86_cwd is			-- convert word to double word

--	add_x86_std is			-- set direction flag
--	add_x86_cld is			-- clear direction flag

--	add_x86_sti is			-- set interrupt flag
--	add_x86_cli is			-- clear interrupt flag

--	add_x86_stc is			-- set carry flag
--	add_x86_cmc is			-- complement carry flag

--	add_x86_cmp is			-- compare
--	add_x86_cmps is			-- compare string

--	add_x86_cmpxchg is		-- compare and exchange
--	add_x86_cmpxchg8b is	-- compare and exchange 8 bytes

--	add_x86_cpuid is	

--	add_x86_cwd is			-- convert word to double
--	add_x86_cdq is			-- convert double to quad

--	add_x86_emms is			-- empty mmx state
--	add_x86_hlt is			-- !!!
--	add_x86_intn is			-- sys call
--	add_x86_lea is			-- load effective address
--	add_x86_loop is			-- counted loop branch
--	add_x86_nop is	
--	add_x86_pop is	
--	add_x86_popa is			-- pop all general registers
--	add_x86_popf is			-- pop eflags register
--	add_x86_push is	
--	add_x86_pusha is		-- push all gen regs
--	add_x86_pushf is		-- push EFLAGS
--	add_x86_rol is	
--	add_x86_ror is			-- rotate
--	add_x86_rdpmc is		-- read performance monitoring counters
--	add_x86_rdtsc is		-- read timestamp counter
--	add_x86_rep is			-- repeat prefix
--	add_x86_shl is			-- shift left
--	add_x86_shr is			-- shift right
--	add_x86_sbb is			-- subtract with borrow
--	add_x86_setcc is		-- set byte on condition
--	add_x86_stos is			-- store string
--	add_x86_test is			-- test
--	add_x86_ud2 is			-- undefined instr: raise invalid opcode
--	add_x86_wait is			-- check pending fp exceptions
--	add_x86_xadd is			-- exchange and add
--	add_x86_xchg is			-- exchange reg/mem with reg

--	add_x86_pand is			-- quad word AND
--	add_x86_pandn is		-- quad AND-NOT
--	add_x86_por is			-- quad OR
--	add_x86_pxor is			-- quad XOR

--	add_x86_f2xm1 is		-- 2^x - 1
--	add_x86_fabs is			-- floating pt abs
--	add_x86_fadd is			-- floating add
--	add_x86_fchs is			-- floating change sign
--	add_x86_fclex is		-- floating clear exception
--	add_x86_fcmov is		-- floating conditional move
--	add_x86_fcom is			-- floating compare
--	add_x86_fdecstp is		-- decrement stack top ptr
--	add_x86_fdiv is			-- floating divide
--	add_x86_fdivr is
--	add_x86_ffree is
--	add_x86_ficom is		-- floating / integer compare
--	add_x86_fild is			-- load integer
--	add_x86_fincstp is		-- incremetn stack top ptr
--	add_x86_finit is
--	add_x86_fist is			-- store integer
--	add_x86_fld is			-- load real
--	add_x86_fldc is			-- load constant
--	add_x86_fldcw is		-- load control word
--	add_x86_fldenv is		-- loadn fpu environment
--	add_x86_fmul is
--	add_x86_fnop is
--	add_x86_fpatan is		-- partial arc-tangent
--	add_x86_fprem is		-- partial remainder
--	add_x86_fptan is		-- partial tangent
--	add_x86_frndint is		-- round to integer
--	add_x86_frstor is		-- restore fpu state
--	add_x86_fsave is		-- save fpu state
--	add_x86_fscale is
--	add_x86_fsin is
--	add_x86_fsincos is
--	add_x86_fsqrt is
--	add_x86_fst is			-- store real
--	add_x86_fstcw is		-- store control word
--	add_x86_fstenv is		-- store fpu environment
--	add_x86_fstsw is		-- store status word
--	add_x86_fsub is
--	add_x86_fsubr is
--	add_x86_ftst is
--	add_x86_fucom is		-- unordered compare real
--	add_x86_fwait is
--	add_x86_fxam is			-- examine
--	add_x86_fxchg is
--	add_x86_fxtract is
--	add_x86_fyl2x is		-- compute y * log(2)x
--	add_x86_fyl2xp1 is

	
	