class SB_APP_SHARED

feature

	value: EV_APPLICATION_IMP

	set_value (v: EV_APPLICATION_IMP_DEF)
		do
			value ?= v
		ensure
			v /= Void implies value /= Void
		end
end
