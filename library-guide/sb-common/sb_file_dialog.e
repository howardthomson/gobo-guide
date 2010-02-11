indexing

		description: "File selection dialog"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FILE_DIALOG

inherit

	SB_DIALOG_BOX
		rename
			make as window_make
		end

creation

	make, make_opts -- , make_once

feature {NONE} -- Implementation attributes

	filebox: SB_FILE_SELECTOR

feature -- Creation

	make_once is
		do
		end

	make (ownr: SB_WINDOW; name: STRING; opts: INTEGER) is
			-- Construct File Dialog Box
		require
        	name /= Void
      	do
        	make_opts (ownr, name, opts, 0,0, 500,300)
      	end

	make_opts (ownr: SB_WINDOW; name: STRING; opts: INTEGER; x,y,w,h: INTEGER) is
			-- Construct File Dialog Box
		do
			make_child_opts (ownr, name, opts | Decor_title | Decor_border | Decor_resize, x,y,w,h, 0,0,0,0, 4,4)
			create filebox.make (Current, Layout_fill_x | Layout_fill_y)
			filebox.accept_button.set_target_and_message (Current, ID_ACCEPT)
			filebox.cancel_button.set_target_and_message (Current, ID_CANCEL)
		end

feature -- Queries

	filename: STRING is
			-- Return file name, if any
		do
			Result := filebox.filename
		end

	filenames: ARRAY [ STRING ] is
			-- Return array of strings containing the selected file names, terminated
			-- by an is_empty string.
			-- If no files were selected, a Void is returned.
		do
			Result := filebox.filenames
		end

	pattern: STRING is
			-- Return file pattern
		do
			Result := filebox.pattern
		end

   current_pattern: INTEGER is
         -- Return current pattern number
      do
         Result := filebox.current_pattern
      end

   pattern_text(patno: INTEGER): STRING is
         -- Get pattern text for given pattern number
      do
         Result := filebox.pattern_text(patno)
      end

   directory: STRING is
         -- Return directory
      do
         Result := filebox.directory
      end

   item_space: INTEGER is
         -- Return the inter-item spacing (in pixels)
      do
         Result := filebox.item_space
      end

   file_box_style: INTEGER is
         -- Return file list style
      do
         Result := filebox.file_box_style
      end

   select_mode: INTEGER is
         -- Return file selection mode
      do
         Result := filebox.select_mode
      end

   read_only_shown: BOOLEAN is
         -- Return True if readonly is is_shown
      do
         Result := filebox.read_only_shown
      end

   read_only_state: INTEGER is
         -- Get readonly state
      do
         Result := filebox.read_only_state
      end

feature -- Actions

   set_filename(path: STRING) is
         -- Change file name
      require
         path /= Void
      do
         filebox.set_filename(path);
      end

   set_pattern(a_pattern: STRING) is
         -- Change file pattern
      do
         filebox.set_pattern (a_pattern)
      end

   set_pattern_list (ptrns: STRING) is
         -- Change the list of file patterns is_shown in the file dialog.
         -- Each pattern comprises an optional name, followed by a pattern in
         -- parentheses.  The patterns are separated by newlines.
         -- For example,
         --
         --  "*%N*.cpp,*.cc%N*.hpp,*.hh,*.h"
         --
         -- and
         --
         --  "All Files (*)%NC++ Sources (*.cpp,*.cc)%NC++ Headers (*.hpp,*.hh,*.h)"
         --
         -- will set the same three patterns, but the former shows no pattern names.
      do
         filebox.set_pattern_list (ptrns)
      end

   set_pattern_list_arr(ptrns: ARRAY [ STRING ]) is
         -- Set list of patterns as name,pattern pairs.
      do
         filebox.set_pattern_list_arr (ptrns)
      end

   set_current_pattern (n: INTEGER) is
         -- After setting the list of patterns, this call will
         -- initially select pattern n as the active one.
      do
         filebox.set_current_pattern (n)
      end

   set_pattern_text (patno: INTEGER; text: STRING) is
         -- Change pattern text for pattern number
      do
         filebox.set_pattern_text (patno, text)
      end

   set_directory (path: STRING) is
         -- Change directory
      do
         filebox.set_directory (path)
      end

   set_item_space (s: INTEGER) is
         -- Set the inter-item spacing (in pixels)
      do
         filebox.set_item_space (s)
      end

   set_file_box_style (style: INTEGER) is
         -- Change file list style
      do
         filebox.set_file_box_style (style)
      end

   set_select_mode (mode: INTEGER) is
         -- Change file selection mode
      do
         filebox.set_select_mode (mode)
      end

   set_read_only_state (st: INTEGER) is
         -- Set initial state of readonly button
      do
         filebox.set_read_only_state (st)
      end

end
