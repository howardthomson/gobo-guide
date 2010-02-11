-- x86 Instruction Set

class X86_INSTRUCTION_SET_NAMES

feature

--	x86_aaa,		-- Ascii adjust after addition		(unused)
--	x86_aad,		-- Ascii adjust before division		(unused)
--	x86_aam,		-- Ascii adjust after multiply		(unused)
--	x86_aas,		-- Ascii adjust after subtraction 	(unused)
	
--	x86_adc,		-- Add with carry					(unused)
--	x86_sbb,		-- subtract with borrow
	
	x86_add,		-- integer signed add
	x86_sub,		-- integer signed subtract
	x86_umul,		-- unsigned multiply
	x86_udiv,		-- unsigned divide
	x86_imul,		-- signed multiply
	x86_idiv,		-- signed divide
	x86_neg,		-- negate
	x86_inc,		-- increment
	x86_dec,		-- decrement by one
	
	x86_and,		-- bit and
	x86_or,			-- bit or
	x86_xor,		-- bit xor
	x86_not,		-- ones complement
	
	x86_move,		
	x86_cmov,		-- conditional move
	x86_movd,		-- move double
	x86_movq,		-- move quad
	x86_movs,		-- move string
	x86_movsx,		-- move with sign extension
	x86_movzx,		-- move with zero extend
	
	x86_enter,		-- procedure entry
	x86_leave,	
	
	x86_call,		-- call procedure
	x86_ret,		-- return
	x86_jcc,		-- conditional jump
	x86_jmp,		-- unconditional jump
	
	x86_bsf,	 	-- Bit Scan Forward
	x86_bsr,	 	-- Bit Scan Reverse
	
	x86_bswap,		-- byte swap
	
	x86_bt,			-- bit test
	x86_btc,		-- bit test and complement
	x86_btr,		-- bit test and reset
	x86_bts,		-- bit test and set
	
	x86_cbw,		-- convert byte to word
	x86_cwd,		-- convert word to double word
	
	x86_std,		-- set direction flag
	x86_cld,		-- clear direction flag

	x86_sti,		-- set interrupt flag
	x86_cli,		-- clear interrupt flag
	
	x86_stc,		-- set carry flag
	x86_cmc,		-- complement carry flag
	
	x86_cmp,		-- compare
	x86_cmps,		-- compare string
	x86_cmpxchg,	-- compare and exchange
	x86_cmpxchg8b,	-- compare and exchange 8 bytes
	
	x86_cpuid,	
	x86_cwd,		-- convert word to double
	x86_cdq,		-- convert double to quad
	
	x86_emms,		-- empty mmx state
	x86_hlt,		-- !!!
	x86_intn,		-- sys call
	x86_lea,		-- load effective address
	x86_loop,		-- counted loop branch
	x86_nop,	
	x86_pop,
		
	x86_popa,		-- pop all general registers
	x86_popf,		-- pop eflags register
	x86_push,	
	x86_pusha,		-- push all gen regs
	x86_pushf,		-- push EFLAGS
	x86_rol,	
	x86_ror,		-- rotate
--	x86_rdpmc,		-- read performance monitoring counters
--	x86_rdtsc,		-- read timestamp counter
	x86_rep,		-- repeat prefix
	x86_shl,	
	x86_shr,		-- shift
	x86_setcc,		-- set byte on condition
	x86_stos,		-- store string
	x86_test,	
	x86_ud2,		-- undefined instr: raise invalid opcode
	x86_wait,		-- check pending fp exceptions
	x86_xadd,		-- exchange and add
	x86_xchg,		-- exchange reg/mem with reg

	x86_pand,		-- quad word AND
	x86_pandn,		-- quad AND-NOT
	x86_por,		-- quad OR
	x86_pxor,		-- quad XOR

	x86_f2xm1,		-- 2^x - 1
	x86_fabs,		-- floating pt abs
	x86_fadd,		-- floating add
	x86_fchs,		-- floating change sign
	x86_fclex,		-- floating clear exception
	x86_fcmov,		-- floating conditional move
	x86_fcom,		-- floating compare
	x86_fdecstp,	-- decrement stack top ptr
	x86_fdiv,		-- floating divide
	x86_fdivr,
	x86_ffree
	x86_ficom,		-- floating / integer compare
	x86_fild,		-- load integer
	x86_fincstp,	-- incremetn stack top ptr
	x86_finit,
	x86_fist,		-- store integer
	x86_fld,		-- load real
	x86_fldc,		-- load constant
	x86_fldcw,		-- load control word
	x86_fldenv,		-- loadn fpu environment
	x86_fmul,
	x86_fnop,
	x86_fpatan,		-- partial arc-tangent
	x86_fprem,		-- partial remainder
	x86_fptan,		-- partial tangent
	x86_frndint,	-- round to integer
	x86_frstor,		-- restore fpu state
	x86_fsave,		-- save fpu state
	x86_fscale,
	x86_fsin,
	x86_fsincos,
	x86_fsqrt,
	x86_fst,		-- store real
	x86_fstcw,		-- store control word
	x86_fstenv,		-- store fpu environment
	x86_fstsw,		-- store status word
	x86_fsub,
	x86_fsubr,
	x86_ftst,
	x86_fucom,		-- unordered compare real
	x86_fwait,
	x86_fxam,		-- examine
	x86_fxchg,
	x86_fxtract,
	x86_fyl2x,		-- compute y * log(2)x
	x86_fyl2xp1
		: INTEGER is Unique

end