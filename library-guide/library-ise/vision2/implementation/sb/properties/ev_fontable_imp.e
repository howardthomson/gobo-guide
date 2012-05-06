note
	description: "EiffelVision fontable, SlyBoots implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date: 2006-12-29 15:13:47 -0800 (Fri, 29 Dec 2006) $";
	revision: "$Revision: 65780 $"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I
		redefine
			interface
		end

feature -- Access

	font: EV_FONT
			-- Character appearance for `Current'.
		do
			if private_font = void then
				create Result
				-- Default create is standard gtk font
			else
				Result := private_font.twin
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		do
			if private_font /= a_font then
				private_font := a_font.twin
			end
		end

feature {NONE} -- Implementation

	private_font: EV_FONT

	interface: EV_FONTABLE;	-- Gobo syntax error if ';' removed

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FONTABLE_IMP

