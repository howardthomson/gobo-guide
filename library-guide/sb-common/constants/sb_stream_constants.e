note
   description: "SB_STREAM constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "Mostly complete"

class SB_STREAM_CONSTANTS

feature -- Stream data flow direction


   SB_STREAM_DEAD: INTEGER = 0;
         -- Unopened stream

   SB_STREAM_SAVE: INTEGER = 1;
         -- Saving stuff to stream

   SB_STREAM_LOAD: INTEGER = 2;
         -- Loading stuff from stream

feature -- Stream status codes

   SB_STREAM_OK: INTEGER = 0;
         -- OK
   SB_STREAM_END: INTEGER = 1;
         -- Try read past end of stream
   SB_STREAM_FULL: INTEGER = 2;
         -- Filled up stream buffer or disk full
   SB_STREAM_NO_WRITE: INTEGER = 3;
         -- Unable to open for write
   SB_STREAM_NO_READ: INTEGER = 4;
         -- Unable to open for read
   SB_STREAM_FORMAT: INTEGER = 5;
         -- Stream format error
   SB_STREAM_UNKNOWN: INTEGER = 6;
         -- Trying to read unknown class
   SB_STREAM_ALLOC: INTEGER = 7;
         -- Alloc failed
   SB_STREAM_FAILURE: INTEGER = 8;
         -- General failure

end
