note

	description:

		"Eiffel systems, adapted for EDP"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-05-13 13:40:18 +0100 (Tue, 13 May 2008) $"
	revision: "$Revision: 6412 $"

class EDP_SYSTEM

inherit

	ET_LACE_SYSTEM

create

--	make

feature -- Display classes

	XXset_classes_tree (a_target: EDP_DISPLAY_TARGET)
		require
			a_target_not_void: a_target /= Void
		local
			a_cursor: DS_HASH_TABLE_CURSOR [ET_CLASS, ET_CLASS_NAME]
			a_class: ET_CLASS
			an_edp_class: EDP_CLASS
		do
			a_target.classes_wipe_out
			a_cursor := classes.new_cursor
			from a_cursor.start until a_cursor.after loop
				from
					a_class := a_cursor.item
				until
					a_class = Void
				loop
					an_edp_class ?= a_class
					if an_edp_class /= Void then
						a_target.add_class (an_edp_class)
					else
						print("Check fail EDP_CLASS /= Void%N")
						print(a_class.generating_type); print(once "%N")
						check False end
					end
					a_class := a_class.overridden_class
				end
				a_cursor.forth
			end
			a_target.sort_classes
		end
end