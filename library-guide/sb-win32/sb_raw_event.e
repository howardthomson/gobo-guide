indexing
    description: "[
        SlyBoots implementation of a Win32 Raw event
                ]"

class SB_RAW_EVENT

inherit
--	X_EVENT
	SB_RAW_EVENT_DEF

creation
	make

feature -- creation

	make is
		do
			todo(once "make - of SB_RAW_EVENT")
		end

feature -- Event processing

	process(app: SB_APPLICATION) is
		do
--			if type = Expose or type = Graphics_Expose then
--				app.add_repaint(xexpose.window, xexpose.x, xexpose.y, xexpose.width, xexpose.height, False)
--			else
--				app.dispatch_event(Current)
--			end
		end
	
end