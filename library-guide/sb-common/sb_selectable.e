indexing
	description: "[
				For displayable widgets that can be selected in design mode,
				provide for remembering the current selected status of this widget
			]"
	author:	"Howard Thomson"

class SB_SELECTABLE

feature

	selected: BOOLEAN	-- Is this widget part of the current selected widget set?

	selectable: BOOLEAN is
			-- Is this a selectable object in design mode
			-- Default True; redefine in Top/Root window
		do
			Result := True
		end

	set_selected(b: BOOLEAN) is
		require
			is_selectable: selectable
		do
			selected := b
		end

invariant
	selected implies selectable
end