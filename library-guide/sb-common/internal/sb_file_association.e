indexing
	description:"Registers stuff to know about the extension"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FILE_ASSOCIATION

feature -- Data

	command		: STRING	-- Command to execute
	extension	: STRING	-- Full extension name
	mimetype	: STRING	-- Mime type name

	bigicon		: SB_ICON	-- Big normal icon
	bigiconopen	: SB_ICON	-- Big open icon
	miniicon	: SB_ICON	-- Mini normal icon
	miniiconopen: SB_ICON	-- Mini open icon

	dragtype	: INTEGER	-- Registered drag type

	flags		: INTEGER	-- Flags
end
