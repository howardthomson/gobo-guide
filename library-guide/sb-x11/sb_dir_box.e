-- X Window System Implementation

class SB_DIR_BOX

inherit

	SB_DIR_BOX_DEF

creation

   make, make_opts

feature -- Actions

	set_directory(pathname: STRING) is
			-- Set current directory
		local
         	itt: SB_TREE_LIST_ITEM;
         	string, path: STRING;
         	part: INTEGER;
	      	done: BOOLEAN;
        --	u: expanded SB_UTILS;
        --	ff: expanded SB_FILE;
--#ifdef WIN32
--        	drivename: STRING;
--        	driveletter: CHARACTER;
--	      	drivemask: BIT 32
--	      	drive_type: INTEGER
--	      	wapi_ff: expanded SB_WAPI_FILE_FUNCTIONS
--			wapi_dt: expanded  SB_WAPI_DRIVE_TYPES
--			mem: expanded MEMORY
--#endif
		do
         	if not pathname.is_empty then
            	from
               		path := ff.absolute(pathname);
            	until
               		ff.is_top_directory(path) or else ff.is_directory(path)
            	loop
               		path := ff.up_level(path);
            	end
            	if not directory.is_equal(path) then
               		directory := path;
               		clear_items;
--#ifndef WIN32
	               	itt := create_item_first(Void, PATHSEPSTRING, foldericon, foldericon, Void);	-- WAS add_item_first ??
	               	part := 1;
	               	from
	                  	done := False
	               	until
	                  	done
	               	loop
	                  	string := u.section(directory,PATHSEP,part,1);
	                  	if string.is_empty then
	                     	done := True
	                  	else
	                     	itt := create_item_last(itt,string,foldericon,foldericon,Void);
	                     	part := part + 1
	                  	end
	               	end
	                set_current_item(itt, False);
--#else
--	               drivemask := wapi_ff.GetLogicalDrives;
--	               from
--	                  drivename := "a:\"
--	                  driveletter := 'a'
--	               until
--		                  driveletter > 'z'
--		               loop                  
--		                  if (drivemask and 00000000000000000000000000000001B) /= Zero then
--		                     mem.collection_off
--#ifdef SE
--	                     drive_type := wapi_ff.GetDriveType(drivename.to_external)
--#else
--	                     drive_type := wapi_ff.GetDriveType(drivename.to_c)
--#endif
--	                     mem.collection_on
--	                     if drive_type = wapi_dt.DRIVE_REMOVABLE then
--	                        if driveletter = 'a' or else driveletter = 'b' then
--	                           itt := create_item_last(Void,drivename,floppyicon,floppyicon,Void);
--	                        else
--	                           itt := create_item_last(Void,drivename,zipdiskicon,zipdiskicon,Void);
--	                        end
--	                     elseif drive_type = wapi_dt.DRIVE_FIXED then
--	                        itt := create_item_last(Void,drivename,harddiskicon,harddiskicon,Void);
--	                     elseif drive_type = wapi_dt.DRIVE_REMOTE then
--	                        itt := create_item_last(Void,drivename,networkicon,networkicon,Void);
--	                     elseif drive_type = wapi_dt.DRIVE_CDROM then
--	                        itt := create_item_last(Void,drivename,cdromicon,cdromicon,Void);
--	                     elseif drive_type =  wapi_dt.DRIVE_RAMDISK then
--	                        itt := create_item_last(Void,drivename,harddiskicon,harddiskicon,Void);
--	                     else
--	                        drive_type := wapi_dt.DRIVE_UNKNOWN
--	                     end
--	                     if drive_type /= wapi_dt.DRIVE_UNKNOWN then
--	                        if u.is_lower(drivename.item(1)) then
--	                           directory.put(u.to_lower(directory.item(1)),1);
--	                        else
--	                           directory.put(u.to_upper(directory.item(1)),1);
--	                        end
--	                        if directory.item(1) = driveletter then
--	                           part := 1;
--	                           from
--	                              done := false
--	                           until
--	                              done
--	                           loop
--	                              string := u.section(directory,PATHSEP,part,1);
--	                              if string.is_empty then
--	                                 done := True
--	                              else
--	                                 itt := create_item_last(itt,string,foldericon,foldericon,Void);
--	                                 part := part+1;
--	                              end
--	                           end
--	                           set_current_item(itt,False);
--	                        end
--	                     end
--	                  end
--	                  drivemask := drivemask ^ 1;
--#ifdef SE
--					driveletter := driveletter.next
--#else
--						driveletter.from_integer(driveletter.code+1);
--#endif
--						drivename.put(driveletter,1);
--					end
--#endif
					recalc
				end
			end
		end
end