class SB_SHARED_APPLICATION

feature

	application: SB_APPLICATION is
		do
			Result := shared_app2.value
		end

	shared_app2: SB_APP_SHARED is
		once
			create Result
		end

end
