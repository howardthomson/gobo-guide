class SB_APPLICATION_CURSORS

feature -- Built-in cursors

--	app: SB_APPLICATION
--		do
--			Result ?= Current
--		ensure
--			Result /= Void
--		end

	hsplit_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	vsplit_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	xsplit_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	swatch_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	dontdrop_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	resizetop_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	resizetopright_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	resizetopleft_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	resizeleft_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	move_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	dndcopy_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	dndlink_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	dndmove_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	crosshair_cursor: SB_CURSOR
		local
			cbits: CROSSHAIR
			cmask: CROSSHAIR_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

			--	-- NE,NW,SE,SW corner cursors
	ne_cursor: SB_CURSOR
		local
			cbits: NE
			cmask: NE_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	nw_cursor: SB_CURSOR
		local
			cbits: NW
			cmask: NW_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	se_cursor: SB_CURSOR
		local
			cbits: SE
			cmask: SE_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	sw_cursor: SB_CURSOR
		local
			cbits: SW
			cmask: SW_MASK
		once
			check	cbits.width = cmask.width
				and cbits.height = cmask.height
				and cbits.x_hot = cmask.x_hot
				and cbits.y_hot = cmask.y_hot
			end
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end

	rotate_cursor: SB_CURSOR
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
			create Result.make_from_bits (cbits.bits, cmask.bits, cbits.width, cbits.height, cbits.x_hot, cbits.y_hot)
		end


end
