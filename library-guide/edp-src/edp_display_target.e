note
	description: "[
		Deferred class, an instance of which receives updates
		and events about the state of and progress in a Project
		Descendants may include null version(s) for use in command
		line versions of package
	]"
	author:		"Howard Thomson"
	copyright:	"Copyright (c) 2003, Howard Thomson and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Design carcass"
	
deferred class EDP_DISPLAY_TARGET

feature -- Configuration

	add_cluster (c: EDP_CLUSTER)
		deferred
		end

feature -- Classes

	classes_wipe_out
		deferred
		end

	add_class (c: ET_CLASS)
		deferred
		end

	sort_classes
		deferred
		end

feature -- Warnings & errors

	errors_wipe_out (a_project: EDP_PROJECT)
			-- Clear the reported warnings and errors for the project
		deferred
		end

end