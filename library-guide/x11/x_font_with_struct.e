note

	description: "Interface to Xlib's Font resource"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_FONT_WITH_STRUCT

inherit

	ANY -- ISE ??

  	X_FONT
    	rename
      		make as x_font_make
    	redefine
      		query_font
    	end

create

  	make

feature -- Creation

  	make (disp: X_DISPLAY; name: STRING)
    	require
      		disp /= Void
      		name /= Void
      		not is_valid
    	local
      		p : POINTER

--			s: SPECIAL[CHARACTER]
    	do
      		display := disp

		--	edp_trace.start(0, "X_FONT_WITH_STRUCT::make: ")					.next(name)							.done
		--	edp_trace.start(0, "X_FONT_WITH_STRUCT::make: to_c: ")				.next(name.to_c.out)				.done
		--	edp_trace.start(0, "X_FONT_WITH_STRUCT::make: area: ")				.next(name.area.out)				.done
		--	edp_trace.start(0, "X_FONT_WITH_STRUCT::make: to_external: ")		.next(name.to_external.out)			.done
		--	edp_trace.start(0, "X_FONT_WITH_STRUCT::make: string_to_external: ").next(string_to_external(name).out)	.done

--## debug
--			s := name.area
--			edp_trace.start(0, "X_FONT_WITH_STRUCT::make ==>")
--					.next(" name: ") 			.next(name)
--					.next(" name.area.count: ") .next(s.count.out)
--					.next(" name.count: ") 		.next(name.count.out)
--					.next("%Nname.to_c: ") 		.next(name.to_c.out)
--					.next(" name.to_external: ").next(name.to_external.out)
--				.done
--
--## debug end

      	--	p := x_load_query_font (display.to_external, string_to_external(name))
      		p := x_load_query_font (display.to_external, name.area.item_address (0))
      		if p /= default_pointer then
      			create font_struct.from_external (p)
      			id := font_struct.fid
      		end
    	end

feature -- Query

	is_valid: BOOLEAN
		do
			Result := font_struct /= Void
		end

feature -- Destruction

  	free
      		-- unloads font and frees the font struct.
    	do
      		unload
      		font_struct.free
    	end

feature

	query_font : X_FONT_STRUCT
    		-- returns a X_FONT_STRUCT which contains information associated
			-- with the font.
		do
      		Result := font_struct
    	end

feature {NONE} -- Implementation attributes

--	font_struct : X_FONT_STRUCT

feature {NONE} -- External functions

	x_load_query_font (p1, p2 : POINTER): POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XLoadQueryFont"
    	end

end
