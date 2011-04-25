note

	todo: "[
		Find and remove duplication of `application' and `get_app'
	]"

	
class SB_SHARED_APPLICATION

inherit

	SB_ANY

feature

	application: SB_APPLICATION is
		do
			Result := shared_app.value
		end

	shared_app: SB_APP_SHARED is
		once
			create Result
		end

end
