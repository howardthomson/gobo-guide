-- X86 ADD Integer Instruction

note
	description: "AMD-64 / Intel ADD Instruction"
	modes: "[
			See p44 x86-64-v1 ... .pdf for operand-size defaults and prefixes
		00 /r		Add reg8 to reg/mem8
		01 /r		Add reg16 to reg/mem16					?? Prefix ?
		01 /r		Add reg32 to reg/mem32					m32
		01 /r		Add reg64 to reg/mem64					m64
		04 ib		Add imm8 to AL
		05 iw		Add imm16 to AX							mxx Prefix 0x66
		05 id		Add imm32 to EAX						m32
		"	"		Add imm32-sign-extended to RAX			m64 Prefix Rex
		80 /0 ib	Add imm8 to reg/mem8					mxx
		81 /0 iw	Add imm16 to reg/mem16					mxx Prefix 0x66
		81 /0 id	Add imm32 to reg/mem32					m32
		"	" "		Add imm32-sign-extended to reg/mem64	m64 Prefix Rex
		83 /0 ib	Add imm8-sign-extended to reg/mem32		m32
					Add imm8-sign-extended to reg/mem64		m64 Prefix Rex
			]"
		
class X86I_ADD

inherit

	X86_INSTRUCTION

create

	make

feature


end -- X86I_ADD