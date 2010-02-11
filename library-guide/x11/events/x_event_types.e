class X_EVENT_TYPES

feature -- event types

  Key_press : 			INTEGER is	2
  Key_release : 		INTEGER is	3
  Button_press : 		INTEGER is	4
  Button_release :		INTEGER is	5
  Motion_notify :		INTEGER is	6
  Enter_notify : 		INTEGER is	7
  Leave_notify : 		INTEGER is	8
  Focus_in : 			INTEGER is	9
  Focus_out : 			INTEGER is	10
  Keymap_notify : 		INTEGER is	11
  Expose : 				INTEGER is	12
  Graphics_expose : 	INTEGER is	13
  No_expose : 			INTEGER is	14
  Visibility_notify : 	INTEGER is	15
  Create_notify : 		INTEGER is	16
  Destroy_notify : 		INTEGER is	17
  Unmap_notify : 		INTEGER is	18
  Map_notify : 			INTEGER is	19
  Map_request : 		INTEGER is	20
  Reparent_notify : 	INTEGER is	21
  Configure_notify : 	INTEGER is	22
  Configure_request : 	INTEGER is	23
  Gravity_notify : 		INTEGER is	24
  Resize_request : 		INTEGER is	25
  Circulate_notify : 	INTEGER is	26
  Circulate_request : 	INTEGER is	27
  Property_notify : 	INTEGER is	28
  Selection_clear : 	INTEGER is	29
  Selection_request : 	INTEGER is	30
  Selection_notify : 	INTEGER is	31
  Colormap_notify : 	INTEGER is	32
  Client_message : 		INTEGER is	33
  Mapping_notify : 		INTEGER is	34

end