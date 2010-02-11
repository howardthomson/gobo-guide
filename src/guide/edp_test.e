--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
indexing
	Project:	"Eiffel Design Project -- EDP"

class EDP_TEST

inherit
	SB_APPLICATION
		rename
			make as	make_app,
			arguments as sb_arguments
		end

	EDP_GLOBAL

	GEC
		rename
		--	arguments as gec_arguments
		end

creation

	make, make_thread, execute

feature

	make is
			-- Startup for Eiffel Design Project Application
		local
			failed:	BOOLEAN
		do
			if arguments.argument(0).is_equal("gec") then
				execute
			else
				test_tuple	-- temp
				expanded_kludge	-- avoid SE expanded 'optimisation'
				if not failed then
				--	parse_arguments
					make_app("Eiffel Design", "EDP");
					prepare	-- Create main window &c
					launch	-- SB_APPLICATION.launch
				end
			end
		end

	test_tuple is
		local
			t1:	TUPLE [	INTEGER, INTEGER ]
			t2:	TUPLE [	INTEGER, STRING	]
			a1:	ANY
			i1:	NATURAL_32
		do
			t1 := [1, 2]
			t2 := [2, once "Howard's test tuple #2"]
			i1 := 32
			a1 := i1
		end

	expanded_kludge	is
			-- Ensure that attributes are generated in the 'C' code which
			-- have not been explicitly referenced. The SE_EXP_xx_BYTES classes
			-- must be the size in bytes as their name implies.
		local
			t: SE_EXP_REFER
		do
			t.se_kludge
		end

	make_thread	is
			-- Startup via threading system, TEST
		local
			t: THREAD
		do
		--	create {WORKER_THREAD} t.make(agent make)
			create {WORKER_THREAD} t.make(Void)
			make
		end

	prepare	is
		do
		--	make_null_project_window
			make_project_window
			repository.load
		end

-----------------------------------

	np:	EDP_PROJECT_GOBO

	pw:	EDP_PROJECT_WINDOW

	make_project_window	is
		do
			create np.make("edp")
			create pw.from_project(np)
			pw.show
		end
		---------------------------

	make_null_project_window is
		do
			create pw.make
			pw.show
		end

end	-- class EDP
