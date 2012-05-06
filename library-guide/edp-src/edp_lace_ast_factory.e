--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
class EDP_LACE_AST_FACTORY

inherit

	ET_LACE_AST_FACTORY
		redefine
			new_system,
			new_ast_factory
		end

create

	make

feature -- EDP adapted SYSTEM creation routine

	new_system: ET_LACE_SYSTEM
			-- New Eiffel system adapted for EDP
		do
			create {EDP_SYSTEM} Result.make
print(once "EDP_LACE_AST_FACTORY.new_system called%N")
		end

feature -- Eiffel AST factory

	new_ast_factory: ET_AST_FACTORY
			-- New Eiffel AST factory
		local
			f: EDP_AST_FACTORY
		do
			if ast_factory /= Void then
				Result := ast_factory
			else
				create f.make
				Result := f
			end
		ensure then
			ast_factory_not_void: Result /= Void
		end
end