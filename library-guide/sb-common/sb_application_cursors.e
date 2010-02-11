class SB_APPLICATION_CURSORS

feature -- Built-in cursors

	app: SB_APPLICATION is
		do
			Result ?= Current
		ensure
			Result /= Void
		end

	hsplit_cursor: SB_CURSOR is
			-- Horizontal splitter cursor
		local
			cbits: HSPLIT
			cmask: HSPLIT_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	vsplit_cursor: SB_CURSOR is
			-- Vertical splitter cursor
		local
			cbits: VSPLIT
			cmask: VSPLIT_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	xsplit_cursor: SB_CURSOR is
			-- Cross splitter cursor
		local
			cbits: XSPLIT
			cmask: XSPLIT_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	swatch_cursor: SB_CURSOR is
			-- Color swatch drag-and-drop cursor
		local
			cbits: SWATCH
			cmask: SWATCH_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	dontdrop_cursor: SB_CURSOR is
			-- NO DROP drag-and-drop cursor
		local
			cbits: DONTDROP
			cmask: DONTDROP_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	resizetop_cursor: SB_CURSOR is
			--	-- Upper or lower side MDI resize cursor
		local
			cbits: RESIZETOP
			cmask: RESIZETOP_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	resizetopright_cursor: SB_CURSOR is
			--	-- Right MDI resize cursor
		local
			cbits: RESIZETOPRIGHT
			cmask: RESIZETOPRIGHT_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	resizetopleft_cursor: SB_CURSOR is
			--	-- Left MDI resize cursor
		local
			cbits: RESIZETOPLEFT
			cmask: RESIZETOPLEFT_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	resizeleft_cursor: SB_CURSOR is
			--	-- Left or right side MDI resize cursor
		local
			cbits: RESIZELEFT
			cmask: RESIZELEFT_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	move_cursor: SB_CURSOR is
			--	-- Move cursor
		local
			cbits: DRAG
			cmask: DRAG_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	dndcopy_cursor: SB_CURSOR is
			--	-- Drag and drop COPY
		local
			cbits: DNDCOPY
			cmask: DNDCOPY_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	dndlink_cursor: SB_CURSOR is
			--	-- Drag and drop LINK
		local
			cbits: DNDLINK
			cmask: DNDLINK_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	dndmove_cursor: SB_CURSOR is
			-- Drag and drop MOVE
		local
			cbits: DNDMOVE
			cmask: DNDMOVE_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	crosshair_cursor: SB_CURSOR is
		local
			cbits: CROSSHAIR
			cmask: CROSSHAIR_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
			--	-- NE,NW,SE,SW corner cursors
	ne_cursor: SB_CURSOR is
		local
			cbits: NE
			cmask: NE_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	nw_cursor: SB_CURSOR is
		local
			cbits: NW
			cmask: NW_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	se_cursor: SB_CURSOR is
		local
			cbits: SE
			cmask: SE_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	sw_cursor: SB_CURSOR is
		local
			cbits: SW
			cmask: SW_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end
		
	rotate_cursor: SB_CURSOR is
			--	-- Rotate cursor
		local
			cbits: ROTATE
			cmask: ROTATE_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (app, cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end


end