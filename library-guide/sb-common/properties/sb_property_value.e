note
	description: "[
		This class is the root of the hierarchy of classes by which
		property values are stored and accessed in widget classes
	]"
	author:	"Howard Thomson"

	todo: "[
		Sort out multiple inheritance bug in SmartEiffel ??

		Adapt assignments to xxx in descendant classes to set_xxx with xxx declared as xxx_private,
		to enable updates to displayed values in the property window.
	]"
	bugs: "[
		SmartEiffel 1.1 (and earlier bug): Multiple Inheritance from this
		class compiles without reported error, but the resulting executable
		does not function, with the 'value' attribute, although inherited under
		multiple names via renaming, being a single attribute ??; or possibly
		only one of the multiple attributes being accessed/modified by the code
	]"

-- deferred

class SB_PROPERTY_VALUE [ T ]

feature

-- Original deferred concept does not function with SmartEiffel
-- The EDP project fails to display correctly, only some widgets appearing

--	value: T is
--		deferred
--		end

--	set_value(new_value: like value) is
--		deferred
--		end

--	value: T

--	set_value(new_value: like value) is
--		do
--			value := new_value
--		end

end

