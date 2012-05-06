class SB_POPUP

inherit
	 SB_POPUP_DEF
	 	redefine
	 		window_class_name
	 	end
	 
create
	make,
	make_opts

feature

	window_class_name: STRING
		once
			Result := "SBPopup"
		end

end
