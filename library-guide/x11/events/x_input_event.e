deferred class X_INPUT_EVENT
  -- Parent of some events
  --
  --| Stephane Hillion
  --| 1998/03/02

inherit

	X_ANY_EVENT

feature -- Consultation

	root: INTEGER is
    		-- id of the root window that the event occurred on
    	deferred
    	end

	subwindow: INTEGER is
			-- child window
    	deferred
    	end

	time: INTEGER is
			-- in milliseconds
		deferred
		end

	x: INTEGER is
			-- pointer x coordinate in event window
		deferred
		end

	y: INTEGER is
			-- pointer y coordinate in event window
		deferred
		end

	x_root: INTEGER is
			-- coordinate relative to root
		deferred
		end

	y_root: INTEGER is
			-- coordinate relative to root
		deferred
		end

	state: INTEGER is
		deferred
		end

	same_screen: BOOLEAN is
		deferred
		end

feature -- Modification

	set_root (v : INTEGER) is
    	deferred
    	ensure
      		root = v
    	end

  	set_subwindow (v : INTEGER) is
    	deferred
    	ensure 
      		subwindow = v
    	end

  	set_time (v : INTEGER) is
    	deferred
    	ensure
      		time = v
    	end

  	set_x (v : INTEGER) is
    	deferred
    	ensure
      		x = v
    	end

  	set_y (v : INTEGER) is
    	deferred
    	ensure
      		y = v
    	end

  	set_x_root (v : INTEGER) is
    	deferred
    	ensure
      		x_root = v
    	end

  	set_y_root (v : INTEGER) is
    	deferred
    	ensure
      		y_root = v
    	end

  	set_state (v : INTEGER) is
    	deferred
    	ensure
      		state.is_equal (v)
    	end

  	set_same_screen (v : BOOLEAN) is
    	deferred
    	ensure
      		same_screen = v
    	end

end 
