note
	description: "Deferred class for all raw event types"

deferred class SB_RAW_EVENT_DEF

feature

	process (app: EV_APPLICATION_IMP)
			-- Process this event
		deferred
		end
end
