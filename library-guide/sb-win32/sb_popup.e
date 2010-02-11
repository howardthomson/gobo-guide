class SB_POPUP

inherit
	 SB_POPUP_DEF
	 	redefine
	 		window_class_name
	 	end
	 
creation
	make,
	make_opts

feature

	window_class_name: STRING is
		once
			Result := "SBPopup"
		end

end
