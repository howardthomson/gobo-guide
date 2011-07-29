indexing
	description:"Base class for objects that can handle messages"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Rename as SB_EVENT_PROCESSOR ?
	]"

deferred class SB_MESSAGE_HANDLER

inherit

	SB_MESSAGE_COMMON

	SB_MESSAGE_HANDLER_COMMANDS

	SB_COMMON_MACROS

	SB_DEFS

	SB_MESSAGE_REFFER

	SB_SEL_TYPE	-- For event_ ...

feature -- Actions

	frozen on_default (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
			-- Called for unhandled messages
		require
			sender_not_void: sender /= Void
      	do
--	print(once "on_default called%N")
      	end

feature -- Actions: Split key

   frozen do_handle_2 (sender: SB_MESSAGE_HANDLER; cmd, id: INTEGER; data: ANY) is
         -- Handle message, and forget the result
		require
			sender /= Void
		local
			tmp: BOOLEAN
		do
			tmp := handle_2 (sender, cmd, id, data)
		end

	handle_2 (sender: SB_MESSAGE_HANDLER; cmd, id: INTEGER; data: ANY): BOOLEAN is
    		-- Handle message, and return the result
		require else
			sender /= Void
		do
			Result := on_default_2 (sender, cmd, id, data)
		end

	on_default_2 (sender: SB_MESSAGE_HANDLER; cmd, id: INTEGER; data: ANY): BOOLEAN is
			-- Called for unhandled messages
		require
        	sender /= Void
      	do
--print(once "on_default_2 called%N")
      	end

feature

	process_event (an_event: SB_EVENT)
		do
			handled := handle_2 (an_event.event_originator, an_event.type, an_event.event_id, an_event.data)
		end

	message_target: SB_MESSAGE_HANDLER
    		-- Message target object

	handled: BOOLEAN
			-- Was the last event 'handled' ?

feature

	event_key_press 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_KEYPRESS)			end	-- Key
	event_key_release 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_KEYRELEASE)			end
	event_left_button_press 	: SB_EVENT is do Result := new_event; Result.set_type (SEL_LEFTBUTTONPRESS)		end	-- Buttons
	event_left_button_release 	: SB_EVENT is do Result := new_event; Result.set_type (SEL_LEFTBUTTONRELEASE)	end
	event_middle_button_press 	: SB_EVENT is do Result := new_event; Result.set_type (SEL_MIDDLEBUTTONPRESS)	end
	event_middle_button_release : SB_EVENT is do Result := new_event; Result.set_type (SEL_MIDDLEBUTTONRELEASE)	end
	event_right_button_press 	: SB_EVENT is do Result := new_event; Result.set_type (Sel_rightbuttonpress)	end
	event_right_button_release 	: SB_EVENT is do Result := new_event; Result.set_type (Sel_rightbuttonrelease)	end
	event_motion 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_MOTION)				end	-- Mouse motion
	event_enter 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_ENTER)				end -- Mouse enters window
	event_leave 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_LEAVE)				end	-- Mouse leaves window
	event_focus_in 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUSIN)				end
	event_focus_out 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUSOUT)			end
	event_keymap 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_KEYMAP)				end
	event_ungrabbed 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_UNGRABBED)			end	-- Lost the grab (Windows)
	event_paint 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_PAINT)				end	-- Must repaint window
	event_create 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_CREATE)				end
	event_destroy 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_DESTROY)				end
	event_unmap 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_UNMAP)				end
	event_map 					: SB_EVENT is do Result := new_event; Result.set_type (SEL_MAP)					end
	event_configure 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_CONFIGURE)			end	-- Resize
	event_selection_lost 		: SB_EVENT is do Result := new_event; Result.set_type (SEL_SELECTION_LOST)		end	-- Widget lost selection
	event_selection_gained 		: SB_EVENT is do Result := new_event; Result.set_type (SEL_SELECTION_GAINED)	end	-- Widget gained selection
	event_selection_request 	: SB_EVENT is do Result := new_event; Result.set_type (SEL_SELECTION_REQUEST)	end	-- Inquire selection data
	event_raised 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_RAISED)				end
	event_lowered 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_LOWERED)				end
	event_close 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLOSE)				end	-- Close window
	event_close_all 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLOSEALL)			end	-- Close all windows
	event_delete 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_DELETE)				end	-- Delete window
	event_minimize 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_MINIMIZE)			end	-- Iconified
	event_restore 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_RESTORE)				end	-- No longer iconified or maximized
	event_maximize 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_MAXIMIZE)			end	-- Maximized
	event_update 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_UPDATE)				end	-- GUI update
	event_command 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_COMMAND)				end	-- GUI command
	event_clicked 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLICKED)				end	-- Clicked
	event_double_clicked 		: SB_EVENT is do Result := new_event; Result.set_type (SEL_DOUBLECLICKED)		end	-- Double-clicked
	event_triple_clicked 		: SB_EVENT is do Result := new_event; Result.set_type (SEL_TRIPLECLICKED)		end	-- Triple-clicked
	event_mouse_wheel			: SB_EVENT is do Result := new_event; Result.set_type (SEL_MOUSEWHEEL)			end	-- GUI will change
	event_changed 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_CHANGED)				end	-- GUI has changed
	event_verify 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_VERIFY)				end	-- Verify change
	event_deselected 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_DESELECTED)			end	-- Deselected
	event_selected 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_SELECTED)			end	-- Selected
	event_inserted 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_INSERTED)			end	-- Inserted
	event_replaced				: SB_EVENT is do Result := new_event; Result.set_type (SEL_REPLACED)			end	-- Replaced
	event_deleted 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_DELETED)				end	-- Deleted
	event_opened 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_OPENED)				end	-- Opened
	event_closed 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLOSED)				end	-- Closed
	event_expanded 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_EXPANDED)			end	-- Expanded
	event_collapsed 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_COLLAPSED)			end	-- Collapsed
	event_begin_drag 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_BEGINDRAG)			end	-- Start a drag
	event_end_drag 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_ENDDRAG)				end	-- End a drag
	event_dragged 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_DRAGGED)				end	-- Dragged
	event_lassoed 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_LASSOED)				end	-- Lassoed
	event_timeout 				: SB_EVENT is do Result := new_event; Result.set_type (Sel_timeout)				end	-- Timeout occurred
	event_signal 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_SIGNAL)				end	-- Signal received
	event_clipboard_lost		: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLIPBOARD_LOST)		end	-- Widget lost clipboard
	event_clipboard_gained		: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLIPBOARD_GAINED)	end	-- Widget gained clipboard
	event_clipboard_request 	: SB_EVENT is do Result := new_event; Result.set_type (SEL_CLIPBOARD_REQUEST)	end	-- Inquire clipboard data
	event_chore					: SB_EVENT is do Result := new_event; Result.set_type (SEL_CHORE)				end	-- Background chore
	event_focus_self 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_SELF)			end	-- Focus on widget itself
	event_focus_right 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_RIGHT)			end	-- Focus movements
	event_focus_left 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_LEFT)			end
	event_focus_down 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_DOWN)			end
	event_focus_up 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_UP)			end
	event_focus_home 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_HOME)			end
	event_focus_end 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_END)			end
	event_focus_next 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_NEXT)			end
	event_focus_prev 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_FOCUS_PREV)			end
	event_dnd_enter 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_DND_ENTER)			end	-- Drag action entering potential drop target
	event_dnd_leave 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_DND_LEAVE)			end	-- Drag action leaving potential drop target
	event_dnd_drop 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_DND_DROP)			end	-- Drop on drop target
	event_dnd_motion 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_DND_MOTION)			end	-- Drag position changed over potential drop target
	event_dnd_request 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_DND_REQUEST)			end	-- Inquire drag and drop data
	event_activate 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_ACTIVATE)			end	-- Activate through mouse or keyboard
	event_deactivate 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_DEACTIVATE)			end	-- Deactivate through mouse or keyboard
	event_uncheck_other 		: SB_EVENT is do Result := new_event; Result.set_type (SEL_UNCHECK_OTHER)		end	-- Sent by child to parent to uncheck other children
	event_uncheck_radio 		: SB_EVENT is do Result := new_event; Result.set_type (SEL_UNCHECK_RADIO)		end	-- Sent by parent to uncheck radio children
	event_io_read 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_IO_READ)				end	-- Read activity on a pipe
	event_io_write 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_IO_WRITE)			end	-- Write activity on a pipe
	event_io_except 			: SB_EVENT is do Result := new_event; Result.set_type (SEL_IO_EXCEPT)			end	-- Except activity on a pipe
	event_picked 				: SB_EVENT is do Result := new_event; Result.set_type (SEL_PICKED)				end	-- Picked some location

feature {NONE} -- New event creation, and recycling

	new_event: SB_EVENT is
		do
			Result := recycle_event
			if Result /= Void then
				Result.reset
			else
				create Result
			end
			Result.set_event_originator (Current)
			Result.set_event_target (Current)
		end

	recycle_event: SB_EVENT is
		do
		--	Result := Void
		end

end
