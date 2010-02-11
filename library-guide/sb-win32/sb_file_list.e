-- Win32 System Implementation

class SB_FILE_LIST

inherit

	SB_FILE_LIST_DEF

	KL_SHARED_FILE_SYSTEM

creation

	make, make_opts

feature

	list_directory is
		local
			i: SB_FILE_LIST_ITEM
			dir: KL_DIRECTORY
			s: STRING
		do
			wipe_out
			dir := tmp_directory
			dir.reset (directory)
			dir.open_read
			if dir.is_open_read then
				from dir.read_entry until dir.end_of_input loop
					s := dir.last_entry
					if file_system.is_directory_readable (file_system.pathname (directory, s)) then
						i := create_item (s, big_folder, mini_folder, Void)
						i.set_directory (True)
						items.force (i, items.upper + 1)	-- items.add_last (i)
					else
						i := create_item (s, big_doc, mini_doc, Void)
						items.force (i, items.upper + 1)	-- items.add_last (i)
					end

					dir.read_entry
				end
				dir.close
			else
				-- ERROR
			end
		end

feature {NONE} -- Implementation

	dummy_name: STRING is "/"

	tmp_directory: KL_DIRECTORY is
			-- Temporary directory object
		do
			Result := shared_directory
			if not Result.is_closed then
				create Result.make (dummy_name)
			end
		ensure
			directory_not_void: Result /= Void
			directory_closed: Result.is_closed
		end

	shared_directory: KL_DIRECTORY is
			-- Shared directory object
		once
			create Result.make (dummy_name)
		ensure
			directory_not_void: Result /= Void
		end
end