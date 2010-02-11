indexing
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

	class_name: STRING is
		once
			Result := "SB_ROOT_WINDOW"
		end

feature -- creation and resources

   	make (app_ : SB_APPLICATION; vis_ : SB_VISUAL) is
      	do
         	make_root (app_, vis_)
      	end

   	create_resource is
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
print ("Creating resources (in SB_ROOT_WINDOW) for: "); print (c.generating_type); print ("%N")
           		c.create_resource

				check c.is_attached end
           		
           		c := c.next
        	end
      	end

   	detach_resource is
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

   	destroy_resource is
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

	update_so_references is
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

   	move (x, y: INTEGER) is
      	do
      	end

   	position (x, y, w, h: INTEGER) is
      	do
      	end

   	resize (w, h: INTEGER) is
      	do
      	end

   	layout is
      	do
      	end

	recalc is
		do
		end

	set_focus is
		do
		end

	kill_focus is
		do
		end

invariant
	non_zero_size: is_attached implies (width > 0 and height > 0)
end
