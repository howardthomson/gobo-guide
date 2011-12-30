--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999-2011					|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note
	Project:	"Eiffel Design Project -- EDP"
	Version:	"Eiffel Vision version"

class GUIDE_EV

inherit

	GEC
		undefine
			default_create,
			copy
		redefine
			report_version_number
		end

	EV_APPLICATION
		rename
--			make as make_app,
--			arguments as sb_arguments
--			copy as ev_copy
		end

	EDP_GLOBAL
		undefine
			default_create,
			copy
		end

create
	make

feature

	gec: GEC

	make is
			-- Startup for Eiffel Design Project Application
		local
			failed: BOOLEAN
			gc_test: EDP_GC_TEST	-- See $GOBO/src/gctest
		do
			if arguments.argument (0).is_equal ("gec")
			or else arguments.argument (0).is_equal ("./gec") then
				create gec.execute
			elseif arguments.argument (0).is_equal ("./test_gc") then
				create gc_test.make
			else
				if not failed then
				--	parse_arguments
				--	make_app ("Eiffel Design", "EDP")	-- GC to fix
					default_create
					prepare	-- Create main window &c
					launch	-- SB_APPLICATION.launch
				end
			end
		end


	np: EDP_PROJECT_GOBO

	pw: EDP_PROJECT_WINDOW

	prepare is
		do
			create np.make ("edp")
			create pw.from_project (np)
			pw.show
		end

feature -- Version reporting

	report_version_number
			-- Indicate 'guide' version of gec
		do
			Precursor
			print ("Guide derivative of gec%N")
		end

end -- class GUIDE
