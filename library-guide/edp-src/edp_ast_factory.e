--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
indexing

	todo: "[
		Change result type of new_assign_check and new_assign_force to
		appropriate new classes.

		Redefine copy re Catcalls in ET_LACE_SYSTEM and ET_XACE_SYSTEM ...
	]"

class EDP_AST_FACTORY

inherit

	ET_AST_FACTORY
		redefine
			new_class
		end

creation

	make

feature -- Class creation

	new_class (a_name: ET_CLASS_NAME): EDP_CLASS is
			-- New Eiffel class
		do
			create Result.make (a_name)
print(once "EDP_AST_FACTORY.new_class called%N")
		end

feature -- SE Assignment operators ?:= and ::=

	new_assign_check (a_target: ET_WRITABLE; an_assign: ET_SYMBOL; a_source: ET_EXPRESSION): ET_EXPRESSION is
			-- New assignment check instruction
			-- Writable ?:= Expression
		do
			if a_target /= Void and a_source /= Void then
--#				create Result.make (a_target, a_source)
			end
		end

	new_assign_type_check (a_target: ET_TYPE; an_assign: ET_SYMBOL; a_source: ET_EXPRESSION): ET_EXPRESSION is
			-- New assign type check instruction
			-- {Type} ?:= Expression
		do
			if a_target /= Void and a_source /= Void then
--#				create Result.make (a_target, a_source)
			end
		end

	new_assign_force (a_target: ET_WRITABLE; an_assign: ET_SYMBOL; a_source: ET_EXPRESSION): ET_ASSIGNMENT is
			-- New forced assignment instruction
			-- Writable ::= Expression
		do
			if a_target /= Void and a_source /= Void then
				create Result.make (a_target, a_source)
			end
		end

end