--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999-2011					|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note
	Project:	"Eiffel Design Project -- EDP"

class GUIDE

inherit

	SB_APPLICATION
		rename
			make as make_app,
			arguments as sb_arguments
		end

	EDP_GLOBAL

	GEC

creation

	make

feature

	gec: GEC

	make is
			-- Startup for Eiffel Design Project Application
		local
			failed: BOOLEAN
			gc_test: EDP_GC_TEST
		do
			if arguments.argument (0).is_equal ("gec")
			or else arguments.argument (0).is_equal ("./gec") then
				create gec.execute
			elseif arguments.argument (0).is_equal ("./test_gc") then
				create gc_test.make
			else
				if not failed then
				--	parse_arguments
					make_app ("Eiffel Design", "EDP")	-- GC to fix
					prepare	-- Create main window &c
					launch	-- SB_APPLICATION.launch
				end
			end
		rescue
			failed := True
			retry
		end

	prepare is
		do
			make_project_window
--			repository.load
		end

-----------------------------------

	np: EDP_PROJECT_GOBO

	pw: EDP_PROJECT_WINDOW

	make_project_window is
		do
			create np.make ("edp")
			create pw.from_project (np)
			pw.show
		end

end -- class GUIDE
