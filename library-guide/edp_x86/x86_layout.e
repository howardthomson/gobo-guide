indexing

	description: "Encoding of instruction layout"
	
class X86_LAYOUT

feature

	A	-- Direct address, no ModRM
	C	-- Control Register: ModRM reg
	D	-- Debug register
	E	-- General purpose reg/mem
	F	-- rFlags
	G	-- ModRM register
	I	-- Immediate
	J	-- Jump offset
	M	-- ModRM memory
	O	-- Operand offset
	P	-- 64-bit MMX: ModRM reg
	PR	-- 64-bit MMX: ModRM r/m; mod=11b
	Q	-- 64-bit MMX reg
	R	-- Gen Reg ModRM r/m; mod=11b
	S	-- Segment reg from ModRM reg
	V	-- 128-bit XMM register
	VR	-- 128-bit XMM reg
	W	-- 128-bit XMM reg
	X	-- String DS.rSI ??
	Y	-- String ES.rDI ??

	a	-- Two 16-bit or 32-bit memory operands
	b	-- byte
	d	-- double word (32-bit)
	dq	-- double quadword (128-bit)
	p	-- pointer, 32-bit or 48-bit depending on operand size
	pd	-- packed double, 128-bit double-precision FP operand
	pi	-- packed integer, 64-bit MMX operand
	ps	-- packed single, 128-bit single-precision FP operand
	q	-- quad word (64-bit)
	s	-- 6/10 byte
	sd	-- scalar double
	si	-- 32-bit integer
	ss	-- single f-p
	v	-- 16/32/64-bit
	w	-- word (16-bit)
	z	-- word (16-bit) or double-word (32-bits)
	/n

--########################################
-- p43
	creg		-- cReg
	dreg		-- dReg
	imm8		-- immediate 8-bit
	imm16		-- immediate 16-bit
	imm16_or_32	-- immediate 16 or 32 bit
	imm32		-- immediate 32-bit
	imm32_or_64	-- immediate 32 or 64 bit
	imm64		-- immediate 64-bit
	mem			-- mem value, size unspec(!)
	mem8		-- mem 8-bit value
	mem16		-- mem 16-bit value
	mem16_32	-- mem 16-bit or 32-bit value
	mem32		-- mem 32-bit value
	mem32_or_48	-- mem 32-bit or 48-bit value
	mem48		-- mem 48-bit value
	mem64		-- mem 64-bit value
	mem128		-- mem 128-bit value
	mem16_16	-- mem two 16-bit words
	mem16_32	-- mem 16-bit then 32-bit words
	mem32real	-- mem 32-bit single FP
	mem32int	-- mem 32-bit integer
	mem64real
	mem64int
	mem80real
	mem80dec
	mem2env
	mem14_28env