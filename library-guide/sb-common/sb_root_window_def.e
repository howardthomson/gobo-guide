note
	description: "Root window"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_ROOT_WINDOW_DEF

inherit
	SB_COMPOSITE
    	rename
        	make as composite_make
		undefine
         	create_resource_imp,
         	detach_resource_imp,
         	destroy_resource_imp
      	redefine
         	class_name,
         	create_resource,
         	detach_resource, destroy_resource,
			update_so_references,
			move,
			position,
			resize,
			layout,
			recalc,
			set_focus,
			kill_focus
      	end

feature -- class name

	class_name: STRING
		once
			Result := "SB_ROOT_WINDOW"
		end

feature -- creation and resources

   	make (app_ : EV_APPLICATION_IMP; vis_ : SB_VISUAL)
      	do
         	make_root (app_, vis_)
      	end

   	create_resource
      	require else
         	visual /= void
      	local
      		c: SB_WINDOW
      	do
         	if not is_attached then
            		-- Initialize visual
            	visual.create_resource
				create_resource_imp

				check is_attached end

         	end
        		-- Normally create children
        	from
           		c := first_child
        	until
           		c = Void
        	loop
--print ("Creating resources (in SB_ROOT_WINDOW) for: "); print (c.generating_type); print ("%N")
           		c.create_resource

				check c.is_attached end

           		c := c.next
        	end
      	end

   	detach_resource
         	-- Detach server-side resources
      	local
         	c: SB_WINDOW
      	do
         	if is_attached then
            	from
               		c := first_child
            	until
               		c = Void
            	loop
               		c.detach_resource;
               		c := c.next
            	end
				detach_resource_imp
            	visual.detach_resource;
         	end
      	end

   	destroy_resource
         	-- Destroy server-side resources
      	local
         	c : SB_WINDOW
      	do
         	if is_attached then
            	from
               		c := first_child
            	until
               		c = Void
            	loop
               		c.destroy_resource;
               		c := c.next
            	end
				destroy_resource_imp
         	end
      	end

	update_so_references
         	-- Update Shared Object sequence numbers
      	local
         	c : SB_WINDOW
      	do
           	from
           		c := first_child
           	until
           		c = Void
           	loop
           		c.update_so_references
           		c := c.next
           	end
		end

feature -- routines

   	move (x, y: INTEGER)
      	do
      	end

   	position (x, y, w, h: INTEGER)
      	do
      	end

   	resize (w, h: INTEGER)
      	do
      	end

   	layout
      	do
      	end

	recalc
		do
		end

	set_focus
		do
		end

	kill_focus
		do
		end

invariant
	non_zero_size: is_attached implies (width > 0 and height > 0)
end
