indexing
	description:"Abstract base class for all server-side resources.";
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>";
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others";
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)";
	status:		"Mostly complete";

deferred class SB_SERVER_RESOURCE_DEF

inherit

    SB_OBJECT
        redefine
        	destruct
        end

	SB_SHARED_APPLICATION

feature { ANY } -- Queries

    is_attached: BOOLEAN
            deferred
        end

feature { ANY } -- Resource ID update

	reset_resource_id
		deferred
		ensure
			not is_attached
		end

feature {ANY} -- Resource management

    create_resource
        	-- Create resource
        require
        --	not is_attached
        deferred
        ensure
        --	is_attached
        end -- create_resource

	detach_resource
			-- Detach resource
		deferred
        ensure
            not is_attached
        end

    destroy_resource
        	-- Destroy resource
        deferred
        end

feature { ANY } -- Destruction

    destruct
        do
            reset_resource_id
            Precursor
        end

feature { NONE } -- Initialisation

	init_resource
        do
        	reset_resource_id
        end

end -- class SB_SERVER_RESOURCE_DEF
