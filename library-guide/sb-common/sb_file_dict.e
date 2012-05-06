note
	description: "[
		The File Association dictionary associates a file extension
		with a FXFileAssoc record which contains command name, mime type,
		icons, and other information about the file type.
		The Registry is used as source of the file bindings; an alternative
		Settings database may be specified however.
			]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FILE_DICT

inherit

	SB_DICT [ SB_FILE_ASSOCIATION, STRING ]
    	rename
         	make as dict_make,
         	insert_if as dict_insert,
         	replace as dict_replace
      	redefine
         	remove
      	end

create

	make

feature -- Creation

	make(a: SB_APPLICATION)
         	-- Construct a dictionary mapping file-extension to file associations,
         	-- using the application registry settings as a source for the bindings.
    	do
    	end

   	make_opts(a: SB_APPLICATION; db: SB_SETTINGS)
         	-- Construct a dictionary mapping file-extension to file associations,
         	-- using the specified settings database as a source for the bindings.
      	do
      	end


feature -- Data

   application: SB_APPLICATION;
         -- Application object
   settings: SB_SETTINGS;
         -- Settings database where to get bindings
   icons: SB_ICON_LIST;
         -- Icon table
   default_exec_binding: STRING;
         -- Registry key used to find fallback executable icons
   default_dir_binding: STRING;
         -- Registry key used to find fallback directory icons
   default_file_binding: STRING;
         -- Registry key used to find fallback document icons

feature -- Queries

   get_icon_path: STRING
         -- Return current icon search path
      do
      end

   associate(key: STRING): SB_FILE_ASSOCIATION
         -- Find file association from registry
      do
      end

   find_file_binding(pathname: STRING): SB_FILE_ASSOCIATION
         -- Determine binding for the given file.
         -- The default implementation tries the whole filename first,
         -- then tries the extensions.
         -- For example, for a file "source.tar.gz":
         --
         --  "source.tar.gz",
         --  "tar.gz",
         --  "gz"
         --
         -- are tried in succession.  If no association is found the
         -- key "defaultfilebinding" is tried as a fallback association.
         -- A Void is returned if no association of any kind is found.
      do
      end

   find_dir_binding(pathname: STRING): SB_FILE_ASSOCIATION
         -- Find directory binding from registry.
         -- The default implementation tries the whole pathname first,
         -- then tries successively smaller parts of the path.
         -- For example, a pathname "/usr/people/jeroen":
         --
         --   "/usr/people/jeroen"
         --   "/people/jeroen"
         --   "/jeroen"
         --
         -- are tried in succession.  If no bindings are found, the
         -- key "defaultdirbinding" is tried as a fallback association.
         -- A Void is returned if no association of any kind is found.
      do
      end

   find_exec_binding(pathname: STRING): SB_FILE_ASSOCIATION
         -- Determine binding for the given executable.
         -- The default implementation returns the fallback binding associated with
         -- the key "defaultexecbinding".
         -- A Void is returned if no association of any kind is found.
      do
      end

feature -- Actions

   set_icon_path(path: STRING)
         -- Set icon search path
      do
      end

   replace(ext,str: STRING)
         -- Replace file association.
         -- The new association is written into the settings database under the
         -- FILETYPES section; the format of the association is as follows:
         --
         -- <extension>  :=  "<command> ; <type> ; <bigicon> [ : <bigopenicon> ] ; <smallicon> [ : <smalliconopen> ] ; <mimetype>"
         --
         -- Where <command> is the command used to launch the application (e.g. "xv %s  and "),
         -- and <type> is the file type string (e.g. "GIF Image"),
         -- <bigicon> and <bigiconopen> are the large icons is_shown in "Icons" mode,
         -- <smallicon> and <smalliconopen> are the small icons is_shown in "Details" mode,
         -- and <mimetype> is the RFC2045 mime type of the file.
         --
         -- For example:
         --
         -- [FILETYPES]
         -- gif := "xv %s  and ;GIF Image;big.xpm:bigopen.xpm;mini.xpm:miniopen.xpm;image/gif"
         -- /home/jeroen := ";Home;home.xpm;minihome.xpm;application/x-folder"
      do
      end

   remove(ext: STRING)
         -- Remove file association
      do
      end

end
