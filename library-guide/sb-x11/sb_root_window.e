-- X Window System Implementation

class SB_ROOT_WINDOW

inherit

	SB_ROOT_WINDOW_DEF
		redefine
			default_width,
			default_height
		end

create

	make

feature

	create_resource_imp is
      	do            
			xwin	:= display.root_window (display.default_screen)
			width	:= display.width	   (display.default_screen)
			height	:= display.height	   (display.default_screen)		
      	end

	detach_resource_imp is
		do
		end

	destroy_resource_imp is
		do
		end

	default_width: INTEGER is
      	do
			-- TODO
      	end

   	default_height: INTEGER is
      	do
			-- TODO
      	end

end