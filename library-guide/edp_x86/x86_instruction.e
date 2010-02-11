-- X86 Instruction

indexing
	description:	"Base class for AMD-64 / Intel machine Instructions"

	todo_for_64_bit: "[
		Need to pass top register bit to the Rex Prefix when setting the
		register field(s) for which the Rex extension is needed.

		Need to validate prefixes, address size, operand size ...
	]"

deferred class X86_INSTRUCTION

feature {NONE} -- Constants

	Displacement_reset	: INTEGER_8 is 0
	Displacement_32		: INTEGER_8 is 1
	Displacement_64		: INTEGER_8 is 2
	
	Immediate_reset:  INTEGER_8 is 0
	Immediate_8_bit:  INTEGER_8 is 1
	Immediate_16_bit: INTEGER_8 is 2
	Immediate_32_bit: INTEGER_8 is 3

feature -- SIB Scale factor values

	Scale_1: INTEGER is 0x00
	Scale_2: INTEGER is 0x40
	Scale_4: INTEGER is 0x80
	Scale_8: INTEGER is 0xc0

feature -- Prefixes

	Prefix_operand_size_override: INTEGER_8 is 0x66

	Prefix_address_size_override: INTEGER_8 is 0x67

	Prefix_segment_override_CS	: INTEGER_8 is 0x2E
	Prefix_segment_override_DS	: INTEGER_8 is 0x3E
	Prefix_segment_override_ES	: INTEGER_8 is 0x26
	Prefix_segment_override_FS	: INTEGER_8 is 0x64
	Prefix_segment_override_GS	: INTEGER_8 is 0x65
	Prefix_segment_override_SS	: INTEGER_8 is 0x36

	Prefix_lock					: INTEGER_8 is 0xF0

	Prefix_repeat				: INTEGER_8 is 0xF3
	Prefix_repeat_ne			: INTEGER_8 is 0xF2

	-- Rex prefix must *immediately* precede the opcode
	Rex_upper: INTEGER is 0xf0	-- Upper nibble of a REX prefix byte
	Rex_w	 : INTEGER is 0x08	-- Default (0)/ 64-bit (1) operand size
		-- Field extensions are the top bit, adding 8 to the default value
	Rex_r	 : INTEGER is 0x04	-- ModRM Reg field extension
	Rex_x	 : INTEGER is 0x02	-- SIB Index field extension
	Rex_b	 : INTEGER is 0x01	-- Extension to ModRM r/m, SIB base, or opcode reg 

feature -- Adddress mode constants

	Src_register_mode	: INTEGER is 0	-- From Register (default)
	Src_immediate_mode	: INTEGER is 1	-- Literal instruction value
	Src_memory_mode		: INTEGER is 2	-- From memory

	Dst_register_mode: INTEGER is 0	-- To Register (default)
	Dst_memory_mode	 : INTEGER is 1	-- To memory

	Mem_none			 : INTEGER is 0		-- N/A: non memory access
	Mem_abs				 : INTEGER is 1		-- Absolute memory address
	Mem_register_indirect: INTEGER is 2		-- (reg)
	Mem_register_offset	 : INTEGER is 3		-- offs(reg)

feature -- Opcodes

feature -- Attributes

	operand_size_prefix: NATURAL_8
			-- Select the operand size

	address_size_prefix: NATURAL_8
			-- Select the address size

	rep_lock_byte:	NATURAL_8
			-- The REP, REPN or LOCK byte, if /= 0

	rex_byte: NATURAL_8
			-- The REX byte, if /= 0

	opcode_0f: NATURAL_8
			-- Two byte opcode indicator

	opcode: NATURAL_8
			-- The principal opcode byte

	mod_rm: NATURAL_8
			-- The ModRM byte

	rm_is_used: BOOLEAN
			-- Flag indicating in-use mod_rm byte

	sib: NATURAL_8	-- The SIB instruction byte
			-- Scale/Index byte

	sib_is_used: BOOLEAN
			-- Flag indicating in-use SIB byte

	displacement: INTEGER_32
			-- The displacement value

	immediate: INTEGER
			-- The immediate value

feature -- Address Modes

	src_register	: INTEGER	-- Source register
	dst_register	: INTEGER	-- Destination Register
	base_register	: INTEGER	-- Base Register for Base+Indexed memory access
	index_register	: INTEGER	-- Index register for (reg) and offs(reg) modes

	source_mode: INTEGER
			-- Source mode selection

	destination_mode: INTEGER
			-- Destination mode

	memory_mode: INTEGER
			-- Mode of memory access, if applicable

	displacement_mode: INTEGER_8
			-- If any displacement in use

	immediate_mode: INTEGER_8
			-- If immediate value to be issued

feature -- ModRM

	set_mod_rm_used is
			-- Set ModRM byte marked as used by the instruction
		do
			rm_is_used := True
		end
	
	m_mod: INTEGER is
			-- the mod bits of mod_rm
		do
			Result := mod_rm & 0xc0
		end

	m_reg: INTEGER is
			-- the reg field of mod_rm
		do
			Result := (mod_rm |>>> 3) & 0x07
		end

	m_rm: INTEGER is
			-- the r/m field of mod_rm
		do
			Result := mod_rm & 0x07
		end

	set_m_mod(i: INTEGER) is
			-- assign the mod field of mod_rm
		require
			valid_mod_value: (i & (0xc0).bit_not) = 0
		do
			mod_rm := (mod_rm & 0x3f) | i.as_natural_8
			set_mod_rm_used
		end

	set_m_reg(i: INTEGER) is
			-- assign the reg field of mod_rm
		require
			valid_reg: (i & (0x07).bit_not) = 0
		do
			mod_rm := (mod_rm & 0xc7) | ((i.as_natural_8 & 0x07) |<< 3)
			set_mod_rm_used
		end

	set_m_rm(i: INTEGER) is
			-- assign the r/m field of mod_rm
		require
			valid_reg: (i & (0x07).bit_not) = 0
		do
			mod_rm := (mod_rm & 0xf8) | (i.as_natural_8 & 0x07)
			set_mod_rm_used
		end

feature -- SIB: Scale / Index / Base

	set_sib_is_used is
			-- Mark the SIB byte as used in this instruction
		do
			sib_is_used := True
		end

	sib_scale: INTEGER is
			-- The Scale value in the SIB byte
		do
			Result := sib & 0xc0
		end

	sib_index: INTEGER is
			-- The Index part of the SIB byte
		do
			Result := (sib |>>> 3) & 0x07
		end

	sib_base: INTEGER is
			-- The base part of the SIB byte
		do
			Result := sib & 0x07
		end

	set_sib_scale(i: INTEGER) is
			-- set the SIB scale field
		require
			valid_scale: (i & (0xc0).bit_not) = 0
		do
			sib := (sib & 0x3f) | i.as_natural_8
			set_sib_is_used
		end

	set_sib_index(i: INTEGER) is
			-- Set the SIB index field
		require
			valid_index: (i & (0x0f).bit_not) = 0
		do
			sib := (sib & 0xc7) | ((i.as_natural_8 & 0x03) |<< 3)
			set_sib_is_used
		end

	set_sib_base(i: INTEGER) is
			-- Set the SIB scale field
		require
			valid_base: (i & (0x0f).bit_not) = 0
		do
			sib := (sib & 0xf8) | (i.as_natural_8 & 0x07)
			set_sib_is_used
		end

feature -- Mode queries

	src_is_memory: BOOLEAN is
		do
			Result := source_mode = Src_memory_mode
		end

	dst_is_memory: BOOLEAN is
		do
			Result := destination_mode = Dst_memory_mode
		end

feature -- Address Displacement

	set_displacement_32 (d: INTEGER_32) is
			-- Set 32-bit address displacement
		do
			displacement_mode := Displacement_32
			displacement := d
		end

	set_displacement_64 (d: INTEGER_64) is
			-- Set 64-bit address displacement
		do
			displacement_mode := Displacement_64
			displacement := d
		end

feature -- Immediate value

	set_immediate_8 (v: INTEGER) is
			-- Set immediate 8-bit value
		require
			not_set: immediate_mode = Immediate_reset
		do
			immediate := v
			immediate_mode := Immediate_8_bit
		end

	set_immediate_16 (v: INTEGER) is
			-- Set immediate 16-bit value
		require
			not_set: immediate_mode = Immediate_reset
		do
			immediate := v
			immediate_mode := Immediate_16_bit
		end

	set_immediate_32 (v: INTEGER) is
			-- Set immediate 32-bit value
		require
			not_set: immediate_mode = Immediate_reset
		do
			immediate := v
			immediate_mode := Immediate_32_bit
		end

feature -- Flags status processing

	flags_status: INTEGER
			-- Set of status flags that are valid after
			-- this instruction, for conditional testing

	flags_modified: INTEGER is
			-- The set of flags modified by this instruction
		do
		--	Result := 0
		end

	flags_undefined: INTEGER is
			-- Set of status flags that are undefined after
			-- this instruction, (not) for conditional testing
		do
		--	Result := 0
		end

feature -- Emit instruction encoding

	x86_emit_code (mc: LLVM_MACHINE_CODE) is
			-- Commit the instruction to the output stream
		require
			is_valid: valid
		do
				--	emit_prefixes
			if rep_lock_byte /= 0 then
				mc.emit_byte (rep_lock_byte)
			end
				--	emit_rex
			if rex_byte /= 0 then
				mc.emit_byte (rex_byte)
			end
				--	emit_opcode
			if opcode_0f /= 0 then
				mc.emit_byte (opcode_0f)
			end
			mc.emit_byte (opcode)
				--	emit mod_rm
			if rm_is_used then
				mc.emit_byte (mod_rm)
			end
				--	emit sib
			if sib_is_used then
				mc.emit_byte (sib)
			end
				--	emit_displacement
			if displacement_mode = Displacement_32 then
				--
			elseif displacement_mode = Displacement_64 then
				--
			end
				--	emit_immediate
			if immediate_mode = Immediate_8_bit then
--				mc.emit_byte (immediate.as_integer_8)
			elseif immediate_mode = Immediate_16_bit then
				
			elseif immediate_mode = Immediate_32_bit then
			end
		end

	x86_print_code is
			-- Print the instruction encoding
		require
			is_valid: valid
		do
				--	emit_prefixes
			if rep_lock_byte /= 0 then
				print (rep_lock_byte.out)
				print (once " ")
			end
				--	emit_rex
			if rex_byte /= 0 then
				print (rex_byte.out)
				print (once " ")
			end
				--	emit_opcode
			if opcode_0f /= 0 then
				print (opcode_0f.out)
				print (once " ")
			end
			print (opcode.out)
			print (once " ")
				--	emit mod_rm
			if rm_is_used then
				print (mod_rm.out)
				print (once " ")
			end
				--	emit sib
			if sib_is_used then
				print (sib.out)
				print (once " ")
			end
				--	emit_displacement
			if displacement_mode = Displacement_32 then
				--
			elseif displacement_mode = Displacement_64 then
				--
			end
				--	emit_immediate
			if immediate_mode = Immediate_8_bit then
				print (immediate.as_integer_8.out)
				print (once " ")
			elseif immediate_mode = Immediate_16_bit then
				
			elseif immediate_mode = Immediate_32_bit then
			end
		end


feature -- Display

-- Display format, aligned:
--

	display_string: STRING is
			-- Displayable text version of this instruction
		do
			Result := once "Undefined"
		ensure
			Result /= Void and then Result.count > 0
		end

feature -- Reset

	reset is
			-- Reset all instruction attributes to default
		do
			rm_is_used := False
			sib_is_used := False
			memory_mode := Mem_none
			source_mode := Src_register_mode
			destination_mode := Dst_register_mode
		end

invariant
	memory_mode /= Mem_none implies (src_is_memory or else dst_is_memory)
	not_src_and_dst_memory: src_is_memory implies not dst_is_memory
end