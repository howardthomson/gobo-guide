note
	description:"An Idle object used in the signal/timer/message handling"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"Initial stub implementation"

	todo: "[
		Adapt to X environment
	]"

class SB_CHORE

inherit

	SB_RAW_EVENT_DEF
	
create

   make

feature -- Attributes

	next: SB_CHORE

	the_agent: PROCEDURE [ ANY, TUPLE ]

feature -- Creation

--	make(app: SB_APPLICATION) is
--		do
--	--		app.add_chore(Current)
--		end

	make(an_agent: PROCEDURE [ ANY, TUPLE ])
		do
			the_agent := an_agent
		end

feature -- Update

	set_next(n: SB_CHORE)
		do
			next := n
		end

feature -- Processing

	process(app: SB_APPLICATION)
		do
			app.flush
			the_agent.call([])
		end			

	execute
		do
		end

end
