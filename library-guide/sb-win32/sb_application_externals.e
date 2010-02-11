indexing
	description:"SB_APPLICATION external C features"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"
	platform:	"Win32"

class SB_APPLICATION_EXTERNALS

feature { SB_APPLICATION } -- External features

   ext_make(app_: SB_APPLICATION; hinstance_ : POINTER;
            SEL_IO_READ_, SEL_IO_WRITE_, SEL_IO_EXCEPT_: INTEGER;
            handle_event_, handle_input_, 
            handle_signal_, handle_refresher_, handle_window_event: POINTER): POINTER is
      external "C"
      alias "sb_application_make"
      end

   ext_add_timeout(p: POINTER; ms: INTEGER; tgt: SB_MESSAGE_HANDLER; 
                   sel: INTEGER): POINTER is
      external "C"
      alias "sb_application_add_timeout"
      end

   ext_remove_timeout(p: POINTER; t: POINTER) is
      external "C"
      alias "sb_application_remove_timeout"
      end

   ext_add_chore(p: POINTER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER): POINTER is
      external "C"
      alias "sb_application_add_chore"
      end

   ext_remove_chore(p: POINTER; t: POINTER) is
      external "C"
      alias "sb_application_remove_chore"
      end

   ext_add_signal (p: POINTER; sig: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; 
                   immediate: BOOLEAN; flags: INTEGER) is
      external "C"
      alias  "sb_application_add_signal"
      end

   ext_remove_signal (p: POINTER; sig: INTEGER) is
      external "C" 
      alias "sb_application_remove_signal"
      end

   ext_add_input (p: POINTER; fd: INTEGER; mode: INTEGER;
                  tgt: SB_MESSAGE_HANDLER; sel: INTEGER): BOOLEAN is
      external "C"
      alias "sb_application_add_input"
      end

   ext_remove_input (p: POINTER; fd: INTEGER; mode: INTEGER): BOOLEAN is
      external "C"
      alias "sb_application_remove_input"
      end

   ext_run_one_event(p: POINTER; p1: POINTER) is
      external "C"
      alias "sb_application_run_one_event"
      end

   ext_open_display(p: POINTER; p1: POINTER): BOOLEAN is
      external "C"
      alias "sb_application_open_display"
      end

   ext_close_display(p: POINTER): BOOLEAN is
      external "C"
      alias "sb_application_close_display"
      end

   ext_get_display(p: POINTER): POINTER is
      external "C"
      alias "sb_application_get_display"
      end

   ext_peek_event(p: POINTER): BOOLEAN is
      external "C"
      alias "sb_application_peek_event"
      end

   ext_get_application: SB_APPLICATION is
      external "C"
      alias "sb_application_get_application"
      end

   ext_get_sbwnd_from_createstruct(s: INTEGER): SB_WINDOW is
      external "C"
      alias "sb_application_sbwnd_from_createstruct"
      end

   ext_get_stipple(p: POINTER; index: INTEGER): POINTER is
      external "C"
      alias "sb_application_get_stipple"
      end

end
