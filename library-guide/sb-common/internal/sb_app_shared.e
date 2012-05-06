class SB_APP_SHARED

feature

	value: SB_APPLICATION

	set_value (v: SB_APPLICATION_DEF)
		do
			value ?= v
		ensure
			v /= Void implies value /= Void
		end
end
