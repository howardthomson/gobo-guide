-- Win32 System Implementation

class SB_DIR_BOX

inherit

	SB_DIR_BOX_DEF

creation

   make, make_opts

feature -- Actions

	set_directory (pathname: STRING) is
			-- Set current directory
		local
         	itt: SB_TREE_LIST_ITEM
         	string, path: STRING
         	part: INTEGER
	      	done: BOOLEAN
        	drivename: STRING
        	driveletter: CHARACTER
	      	drivemask: INTEGER_32
	      	drive_type: INTEGER
	      	wapi_ff: SB_WAPI_FILE_FUNCTIONS
			wapi_dt: SB_WAPI_DRIVE_TYPES
		do
         	if not pathname.is_empty then
            	from
               		path := ff.absolute (pathname)
            	until
               		ff.is_top_directory(path) or else ff.is_directory (path)
            	loop
               		path := ff.up_level (path)
            	end
            	if not directory.is_equal (path) then
               		directory := path
               		clear_items
	               drivemask := wapi_ff.GetLogicalDrives
	               from
	                  drivename := "a:\"
	                  driveletter := 'a'
	               until
		                  driveletter > 'z'
		               loop                  
		                  if (drivemask & 0x00000001) /= Zero then
		                     mem.collection_off
	                     drive_type := wapi_ff.GetDriveType (drivename.area.base_address)
	                     mem.collection_on
	                     if drive_type = wapi_dt.DRIVE_REMOVABLE then
	                        if driveletter = 'a' or else driveletter = 'b' then
	                           itt := create_item_last (Void, drivename, floppyicon, floppyicon, Void)
	                        else
	                           itt := create_item_last(Void,drivename, zipdiskicon, zipdiskicon, Void)
	                        end
	                     elseif drive_type = wapi_dt.DRIVE_FIXED then
	                        itt := create_item_last(Void, drivename, harddiskicon, harddiskicon, Void)
	                     elseif drive_type = wapi_dt.DRIVE_REMOTE then
	                        itt := create_item_last(Void, drivename, networkicon, networkicon, Void)
	                     elseif drive_type = wapi_dt.DRIVE_CDROM then
	                        itt := create_item_last(Void, drivename, cdromicon, cdromicon, Void)
	                     elseif drive_type =  wapi_dt.DRIVE_RAMDISK then
	                        itt := create_item_last(Void, drivename, harddiskicon, harddiskicon, Void)
	                     else
	                        drive_type := wapi_dt.DRIVE_UNKNOWN
	                     end
	                     if drive_type /= wapi_dt.DRIVE_UNKNOWN then
	                        if u.is_lower (drivename.item (1)) then
	                           directory.put (u.to_lower (directory.item (1)), 1)
	                        else
	                           directory.put (u.to_upper (directory.item (1)), 1)
	                        end
	                        if directory.item (1) = driveletter then
	                           part := 1
	                           from
	                              done := false
	                           until
	                              done
	                           loop
	                              string := u.section (directory, PATHSEP, part, 1)
	                              if string.is_empty then
	                                 done := True
	                              else
	                                 itt := create_item_last (itt, string, foldericon, foldericon, Void)
	                                 part := part + 1
	                              end
	                           end
	                           set_current_item (itt, False)
	                        end
	                     end
	                  end
	                  drivemask := drivemask.bit_shift_left (1).to_integer	-- GEC/EDP Version
					  driveletter := driveletter.next
					  drivename.put (driveletter, 1)
					end
					recalc
				end
			end
		end
end