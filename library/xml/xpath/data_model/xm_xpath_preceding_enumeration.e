indexing

	description:

		"Objects that iterate the XPath preceding axis"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_PRECEDING_ENUMERATION [G -> XM_XPATH_NODE]

inherit

	XM_XPATH_AXIS_ITERATOR [G]

	XM_XPATH_TYPE
		export {NONE} all end

	XM_XPATH_AXIS
		export {NONE} all end

	-- This implementation works for all tree models

create

	make

feature {NONE} -- Initialization

	make (a_starting_node: G; include: BOOLEAN) is
			-- Establish invariant.
		require
			starting_node_not_void: a_starting_node /= Void
		do
			include_ancestors := include
			starting_node := a_starting_node
			create {XM_XPATH_ANCESTOR_ENUMERATION [G]} ancestors.make (starting_node, False)
			inspect
				starting_node.node_type
			when Element_node, Text_node, Comment_node, Processing_instruction_node then
				siblings ?= starting_node.new_axis_iterator (Preceding_sibling_axis)
			else
				create {XM_XPATH_EMPTY_ITERATOR [G]} siblings.make
			end
		ensure
			include_ancestors_set: include_ancestors = include
			starting_node_set: starting_node = a_starting_node
			ancestors_and_maybe_siblings: descendants = Void and ancestors /= Void
		end

feature -- Cursor movement
			
	forth is
			-- Move to next position
		do
			index := index + 1
			advance
		end

feature -- Duplication

	another: like Current is
			-- Another iterator that iterates over the same items as the original
		do
			create Result.make (starting_node, include_ancestors)
		end

feature {NONE} -- Implementation

	starting_node: G
			-- Origin node

	include_ancestors: BOOLEAN
			-- Are ancestors to be included?

	ancestors: XM_XPATH_AXIS_ITERATOR [G]
			-- Ancestors
	
	siblings: XM_XPATH_AXIS_ITERATOR [G]
			-- Following siblings

	descendants: XM_XPATH_AXIS_ITERATOR [G]
			-- Descendants

	advance is
			-- Move to the next position
		local
			finished_advance: BOOLEAN
			a_node, l_default: G
		do
			if descendants /= Void then
				if descendants.before then descendants.start else descendants.forth end
				if descendants.after then
					descendants := Void
				else
					current_item := descendants.item; finished_advance := True
				end
			end
			if not finished_advance then
				if siblings /= Void then
					if siblings.before then siblings.start else siblings.forth end
					if siblings.after then
						descendants := Void
						siblings := Void
					else
						a_node := siblings.item
						if a_node.has_child_nodes then
							create {XM_XPATH_DESCENDANT_ENUMERATION [G]} descendants.make (a_node, True, False)
							advance
						else
							descendants := Void
							current_item := a_node
						end
						finished_advance := True
					end
					
				end
				if not finished_advance then
					if ancestors.before then ancestors.start else ancestors.forth end
					if ancestors.after then
						current_item := l_default
					else
						current_item := ancestors.item
						if current_item.node_type = Document_node then
							create {XM_XPATH_EMPTY_ITERATOR [G]} siblings.make
						else
							siblings ?= current_item.new_axis_iterator (Preceding_sibling_axis)
						end
						if not include_ancestors then advance end
					end
				end
			end	
		end

invariant

	starting_node_not_void: starting_node /= Void

end
	
