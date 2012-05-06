deferred class X_INPUT_EVENT
  -- Parent of some events
  --
  --| Stephane Hillion
  --| 1998/03/02

inherit

	X_ANY_EVENT

feature -- Consultation

	root: INTEGER
    		-- id of the root window that the event occurred on
    	deferred
    	end

	subwindow: INTEGER
			-- child window
    	deferred
    	end

	time: INTEGER
			-- in milliseconds
		deferred
		end

	x: INTEGER
			-- pointer x coordinate in event window
		deferred
		end

	y: INTEGER
			-- pointer y coordinate in event window
		deferred
		end

	x_root: INTEGER
			-- coordinate relative to root
		deferred
		end

	y_root: INTEGER
			-- coordinate relative to root
		deferred
		end

	state: INTEGER
		deferred
		end

	same_screen: BOOLEAN
		deferred
		end

feature -- Modification

	set_root (v : INTEGER)
    	deferred
    	ensure
      		root = v
    	end

  	set_subwindow (v : INTEGER)
    	deferred
    	ensure 
      		subwindow = v
    	end

  	set_time (v : INTEGER)
    	deferred
    	ensure
      		time = v
    	end

  	set_x (v : INTEGER)
    	deferred
    	ensure
      		x = v
    	end

  	set_y (v : INTEGER)
    	deferred
    	ensure
      		y = v
    	end

  	set_x_root (v : INTEGER)
    	deferred
    	ensure
      		x_root = v
    	end

  	set_y_root (v : INTEGER)
    	deferred
    	ensure
      		y_root = v
    	end

  	set_state (v : INTEGER)
    	deferred
    	ensure
      		state.is_equal (v)
    	end

  	set_same_screen (v : BOOLEAN)
    	deferred
    	ensure
      		same_screen = v
    	end

end 
