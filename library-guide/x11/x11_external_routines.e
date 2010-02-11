indexing
	description: "[
		Eiffel external routine declarations for the X Window System Version 11
		Implementation is inherited, to either use wrapped calls for debug tracing,
		or direct external C calls.
	]"
	author:	"Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X11_EXTERNAL_ROUTINES

inherit

	X11_EXTERNAL_ROUTINES_WRAPPED	-- X routines wrapped to trace / debug
--	X11_EXTERNAL_ROUTINES_DIRECT	-- X routines direct to C external
end