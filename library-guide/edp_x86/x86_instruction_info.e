-- Description of a specific X86 instruction encoding

class X86_INSTRUCTION_INFO

inherit
	X86_INSTRUCTION_SET_NAMES
	X86_INSTRUCTION_LAYOUTS

create
	make

feature -- Attributes

	modes: INTEGER
			-- Valid execution modes

	operation: INTEGER
			-- Instruction name from X86_INSTRUCTION_SET_NAMES

	opcode_1,
	opcode_2: INTEGER
			-- Opcode encoding

	layout: INTEGER
			-- Specification of instruction encoding


feature {NONE} -- Creation

	make(a_modes, a_op, a_opc_1, a_opc_2, a_layout: INTEGER)
		do
			modes := a_modes
			operation := a_op
			opcode_1 := a_opc_1
			opcode_2 := a_opc_2
			layout := a_layout
		end

end