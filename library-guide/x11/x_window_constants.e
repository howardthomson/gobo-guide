indexing

	description: "X11 constants for windows"

	author: "Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_WINDOW_CONSTANTS

inherit

	X_H

feature -- window's class values

	Input_output:	INTEGER is 1	-- FIXME
	Input_only:		INTEGER is 2	-- FIXME

feature -- grab constants

--	Grab_mode_sync : INTEGER is 99	-- FIXME
--	Grab_mode_async : INTEGER is 99	-- FIXME
--	Grab_success : INTEGER is 99	-- FIXME

feature -- bit_gravity and win_gravity values
  
	Forget_gravity : 		INTEGER is	0

	North_west_gravity :	INTEGER is	1
	North_gravity : 		INTEGER is	2
	North_east_gravity : 	INTEGER is	3

	West_gravity :			INTEGER is	4
	Center_gravity : 		INTEGER is	5
	East_gravity : 			INTEGER is	6

	South_west_gravity :	INTEGER is	7
	South_gravity :			INTEGER is	8
	South_east_gravity : 	INTEGER is	9

	Static_gravity : 		INTEGER is	10

feature -- backing_store values

	Not_useful	: INTEGER is 0
	When_mapped	: INTEGER is 1
	Always		: INTEGER is 2

feature -- Revert_to values

--	Revert_to_none
--	Revert_to_parent

feature -- input masks

	No_event_mask : 				INTEGER is	0
	Key_press_mask : 				INTEGER is	0x00000001
	Key_release_mask : 				INTEGER is	0x00000002
	Button_press_mask : 			INTEGER is	0x00000004
	Button_release_mask : 			INTEGER is	0x00000008
	Enter_window_mask : 			INTEGER is	0x00000010
	Leave_window_mask : 			INTEGER is	0x00000020
	Pointer_motion_mask : 			INTEGER is	0x00000040
	Pointer_motion_hint_mask : 		INTEGER is	0x00000080
	Button1_motion_mask : 			INTEGER is	0x00000100
	Button2_motion_mask : 			INTEGER is	0x00000200
	Button3_motion_mask : 			INTEGER is	0x00000400
	Button4_motion_mask : 			INTEGER is	0x00000800
	Button5_motion_mask : 			INTEGER is	0x00001000
	Button_motion_mask : 			INTEGER is	0x00002000
	Keymap_state_mask : 			INTEGER is	0x00004000
	Exposure_mask : 				INTEGER is	0x00008000
	Visibility_change_mask : 		INTEGER is	0x00010000
	Structure_notify_mask : 		INTEGER is	0x00020000
	Resize_redirect_mask : 			INTEGER is	0x00040000
	Substructure_notify_mask : 		INTEGER is	0x00080000
	Substructure_redirect_mask : 	INTEGER is 	0x00100000
	Focus_change_mask : 			INTEGER is 	0x00200000
	Property_change_mask : 			INTEGER is 	0x00400000
	Colormap_change_mask : 			INTEGER is 	0x00800000
	Owner_grab_button_mask :		INTEGER is 	0x01000000

end 
