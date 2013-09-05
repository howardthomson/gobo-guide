note
    description: "[
        SlyBoots implementation of an X11 Raw event
                ]"

class SB_RAW_EVENT

inherit

	X_EVENT
	SB_RAW_EVENT_DEF

create {SB_INVOCATION, EV_APPLICATION_IMP}

	make

feature -- Event processing

	process (app: EV_APPLICATION_IMP)
		local
			l_xexpose: X_EXPOSE_EVENT
		do
			if type = Expose or type = Graphics_expose then
				l_xexpose := xexpose
				app.add_repaint (l_xexpose.window, l_xexpose.x, l_xexpose.y, l_xexpose.width, l_xexpose.height, False)
			else
				app.dispatch_event (Current)
			end
		end

feature -- X compatible conversion to appropriate subtype

	xany				: X_ANY_EVENT do o_xany								.from_x_struct (Current); Result := o_xany 				end
	xkey				: X_KEY_EVENT do o_xkey								.from_x_struct (Current); Result := o_xkey 				end
	xmotion				: X_MOTION_EVENT do o_xmotion						.from_x_struct (Current); Result := o_xmotion 			end
	xbutton				: X_BUTTON_EVENT do o_xbutton						.from_x_struct (Current); Result := o_xbutton 			end
	xcrossing			: X_CROSSING_EVENT do o_xcrossing					.from_x_struct (Current); Result := o_xcrossing 		end
	xfocus				: X_FOCUS_CHANGE_EVENT do o_xfocus					.from_x_struct (Current); Result := o_xfocus 			end
	xexpose				: X_EXPOSE_EVENT do o_xexpose						.from_x_struct (Current); Result := o_xexpose 			end
	xgraphicsexpose		: X_GRAPHICS_EXPOSE_EVENT do o_xgraphicsexpose		.from_x_struct (Current); Result := o_xgraphicsexpose 	end
	xnoexpose			: X_NO_EXPOSE_EVENT do o_xnoexpose					.from_x_struct (Current); Result := o_xnoexpose 		end
	xvisibility			: X_VISIBILITY_EVENT do o_xvisibility				.from_x_struct (Current); Result := o_xvisibility 		end
	xcreatewindow		: X_CREATE_WINDOW_EVENT do o_xcreatewindow			.from_x_struct (Current); Result := o_xcreatewindow 	end
	xdestroywindow		: X_DESTROY_WINDOW_EVENT do o_xdestroywindow		.from_x_struct (Current); Result := o_xdestroywindow 	end
	xunmap				: X_UNMAP_EVENT do o_xunmap							.from_x_struct (Current); Result := o_xunmap 			end
	xmap				: X_MAP_EVENT do o_xmap								.from_x_struct (Current); Result := o_xmap 				end
	xmaprequest			: X_MAP_REQUEST_EVENT do o_xmaprequest				.from_x_struct (Current); Result := o_xmaprequest 		end
	xreparent			: X_REPARENT_EVENT do o_xreparent					.from_x_struct (Current); Result := o_xreparent 		end
	xconfigure			: X_CONFIGURE_EVENT do o_xconfigure					.from_x_struct (Current); Result := o_xconfigure 		end
	xgravity			: X_GRAVITY_EVENT do o_xgravity						.from_x_struct (Current); Result := o_xgravity 			end
	xresizerequest		: X_RESIZE_REQUEST_EVENT do o_xresizerequest		.from_x_struct (Current); Result := o_xresizerequest 	end
	xconfigurerequest	: X_CONFIGURE_REQUEST_EVENT do o_xconfigurerequest	.from_x_struct (Current); Result := o_xconfigurerequest end
	xcirculate			: X_CIRCULATE_EVENT do o_xcirculate					.from_x_struct (Current); Result := o_xcirculate 		end
	xcirculaterequest	: X_CIRCULATE_REQUEST_EVENT do o_xcirculaterequest	.from_x_struct (Current); Result := o_xcirculaterequest end
	xproperty			: X_PROPERTY_EVENT do o_xproperty					.from_x_struct (Current); Result := o_xproperty 		end
	xselectionclear		: X_SELECTION_CLEAR_EVENT do o_xselectionclear		.from_x_struct (Current); Result := o_xselectionclear 	end
	xselectionrequest	: X_SELECTION_REQUEST_EVENT do o_xselectionrequest	.from_x_struct (Current); Result := o_xselectionrequest	end
	xselection			: X_SELECTION_EVENT do o_xselection					.from_x_struct (Current); Result := o_xselection		end
--	xcolormap			: X_
	xclient				: X_CLIENT_EVENT do o_xclient						.from_x_struct (Current); Result := o_xclient			end
--	xmapping			:
--	xerror				:
	xkeymap				: X_KEYMAP_EVENT do o_xkeymap						.from_x_struct (Current); Result := o_xkeymap			end

feature {NONE} -- once created event objects

	o_xany				: X_ANY_EVENT once create Result.from_x_struct (Current) end
	o_xkey				: X_KEY_EVENT once create Result.from_x_struct (Current) end
	o_xmotion			: X_MOTION_EVENT once create Result.from_x_struct (Current) end
	o_xbutton			: X_BUTTON_EVENT once create Result.from_x_struct (Current) end
	o_xcrossing			: X_CROSSING_EVENT once create Result.from_x_struct (Current) end
	o_xfocus			: X_FOCUS_CHANGE_EVENT once create Result.from_x_struct (Current) end
	o_xexpose			: X_EXPOSE_EVENT once create Result.from_x_struct (Current) end
	o_xgraphicsexpose	: X_GRAPHICS_EXPOSE_EVENT once create Result.from_x_struct (Current) end
	o_xnoexpose			: X_NO_EXPOSE_EVENT once create Result.from_x_struct (Current) end
	o_xvisibility		: X_VISIBILITY_EVENT once create Result.from_x_struct (Current) end
	o_xcreatewindow		: X_CREATE_WINDOW_EVENT once create Result.from_x_struct (Current) end
	o_xdestroywindow	: X_DESTROY_WINDOW_EVENT once create Result.from_x_struct (Current) end
	o_xunmap			: X_UNMAP_EVENT once create Result.from_x_struct (Current) end
	o_xmap				: X_MAP_EVENT once create Result.from_x_struct (Current) end
	o_xmaprequest		: X_MAP_REQUEST_EVENT once create Result.from_x_struct (Current) end
	o_xreparent			: X_REPARENT_EVENT once create Result.from_x_struct (Current) end
	o_xconfigure		: X_CONFIGURE_EVENT once create Result.from_x_struct (Current) end
	o_xgravity			: X_GRAVITY_EVENT once create Result.from_x_struct (Current) end
	o_xresizerequest	: X_RESIZE_REQUEST_EVENT once create Result.from_x_struct (Current) end
	o_xconfigurerequest	: X_CONFIGURE_REQUEST_EVENT once create Result.from_x_struct (Current) end
	o_xcirculate		: X_CIRCULATE_EVENT once create Result.from_x_struct (Current) end
	o_xcirculaterequest	: X_CIRCULATE_REQUEST_EVENT once create Result.from_x_struct (Current) end
	o_xproperty			: X_PROPERTY_EVENT once create Result.from_x_struct (Current) end
	o_xselectionclear	: X_SELECTION_CLEAR_EVENT once create Result.from_x_struct (Current) end
	o_xselectionrequest	: X_SELECTION_REQUEST_EVENT once create Result.from_x_struct (Current) end
	o_xselection		: X_SELECTION_EVENT once create Result.from_x_struct (Current) end
--	o_xcolormap			: X_						is once create Result.from_x_struct (Current) end
	o_xclient			: X_CLIENT_EVENT once create Result.from_x_struct (Current) end
--	o_xmapping			:							is once create Result.from_x_struct (Current) end
--	o_xerror			:							is once create Result.from_x_struct (Current) end
	o_xkeymap			: X_KEYMAP_EVENT once create Result.from_x_struct (Void) end

end
