indexing
	description: "[
		The Matrix layout manager automatically arranges its child
		windows in rows and columns. If the matrix style is MATRIX_BY_ROWS,
		then the matrix will have the given number of rows and the number of
		columns grows as more child windows are added; if the matrix style
		is MATRIX_BY_COLUMNS, then the number of columns is fixed and the number of
		rows grows as more children are added.
	]"

	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Mostly complete"

class SB_MATRIX

inherit

   SB_PACKER
      rename
         make as packer_make,
         make_opts as packer_make_opts
      redefine
         default_width,
         default_height,
         on_focus_up,
         on_focus_down,
         on_focus_left,
         on_focus_right,
         layout,
         class_name
      end

   SB_MATRIX_CONSTANTS

creation

   make, make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_MATRIX"
		end

feature -- Creation

   make (p: SB_COMPOSITE; n: INTEGER; opts: INTEGER) is
      do
         make_opts(p, n, opts, 0,0,0,0, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING,
                   DEFAULT_SPACING, DEFAULT_SPACING);
      end

   make_opts (p: SB_COMPOSITE; n: INTEGER; opts: INTEGER; x,y,w,h, pl,pr, pt,pb, hs,vs: INTEGER) is
         -- Construct a matrix layout manager with n rows or columns
      do
         packer_make_opts(p, opts, x,y,w,h, pl,pr,pt,pb, hs,vs)
         num := sbclamp (1, n, MAXNUM)
      end

feature -- Data

   MAXNUM: INTEGER is 512

feature -- Queries

   default_height: INTEGER is
         -- Return default height
      local
         r, n, h, nzrow, hmax, mh: INTEGER
         child: SB_WINDOW
         hints: INTEGER
         rowh: ARRAY [ INTEGER ]
      do
         create rowh.make (0, MAXNUM)
         if (options & Pack_uniform_height) /= Zero then
            mh := max_child_height
         end
         from
            child := first_child
            n := 0
         until
            child = Void
            loop

            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_height) /= Zero then
                  h := child.height
               elseif (options & Pack_uniform_height) /= Zero then
                  h := mh
               else
                  h := child.default_height
               end
               if (options & MATRIX_BY_COLUMNS) /= Zero then
                  r := n // num
               else
                  r := n \\ num
               end
               check valid_r: r < MAXNUM end
               if h > rowh.item (r) then
                  if rowh.item (r) = 0 then
                     nzrow := nzrow + 1 -- Count non-Zero rows
                  end
                  hmax := hmax + h - rowh.item (r)
                  rowh.put (h, r)
               end
            end
            child := child.next
            n := n + 1
         end
         if nzrow > 1 then
            hmax := hmax + (nzrow - 1) * v_spacing
         end
         Result := pad_top + pad_bottom + hmax + (border * 2);
      end

   default_width: INTEGER is
         -- Return default width
      local
         c, n, w, nzcol, wmax, mw: INTEGER
         child: SB_WINDOW
         hints: INTEGER
         colw: ARRAY [ INTEGER ]
      do
         create colw.make (0, MAXNUM)
         if (options & Pack_uniform_width) /= Zero then
            mw := max_child_width
         end
         from
            child := first_child
            n := 0
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_width) /= Zero then
                  w := child.width
               elseif (options & Pack_uniform_width) /= Zero then 
                  w := mw
               else
                  w := child.default_width
               end
               if (options & MATRIX_BY_COLUMNS) /= Zero then
                  c := n \\ num
               else
                  c := n // num
               end
               check valid_c: c < MAXNUM end
               if w > colw.item (c) then
                  if colw.item (c) = 0 then
                     nzcol := nzcol + 1  -- Count non-Zero columns
                  end
                  wmax := wmax + w - colw.item (c)
                  colw.put (w, c)
               end
            end
            child := child.next
            n := n + 1
         end
         if nzcol > 1 then
            wmax := wmax + (nzcol - 1) * h_spacing
         end
         Result := pad_left + pad_right + wmax + (border * 2)
      end
   
   child_at_row_col (r, c: INTEGER): SB_WINDOW is
         -- Obtain the child placed at a certain row and column
      do
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            if  0 <= c and then c < num then
               Result := child_at_index (num * r + c);
            end
         else
            if 0 <= r and then r < num then
               Result := child_at_index (r + num * c)
            end
         end
      end

   row_of_child (child: SB_WINDOW): INTEGER is
         -- Return the row in which the given child is placed
      local
         i: INTEGER
      do
         i := index_of_child (child)
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            Result := i // num
         else
            Result := i \\ num
         end
      end
   
   col_of_child (child: SB_WINDOW): INTEGER is
         -- Return the column in which the given child is placed
      local
         i: INTEGER;
      do
         i := index_of_child (child)
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            Result := i \\ num
         else
            Result := i // num
         end
      end

   get_matrix_style: INTEGER is
         -- Return the current matrix style
      do
         Result := options & MATRIX_BY_COLUMNS;
      end

   get_num_rows: INTEGER is
         -- Return the number of rows
      local
         child: SB_WINDOW;
         n: INTEGER;
      do
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            Result := (child_count + num - 1) // num
         else
            Result := num;
         end
      end

   get_num_columns: INTEGER is
         -- Return the number of columns
      local
         child: SB_WINDOW;
         n: INTEGER;
      do
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            Result := num;
         else
            Result := (child_count + num - 1) // num;
         end
      end

feature -- Actions

   set_matrix_style(style: INTEGER) is
         -- Change the matrix style
      local
         opts: INTEGER;
      do
         opts := new_options (style, MATRIX_BY_COLUMNS)
         if opts /= options then
            options := opts;
            recalc;
            update;
         end
      end

   set_num_rows(nr: INTEGER) is
         -- Change the number of rows
      require
         nr >= 1 and then nr < MAXNUM
      do
         if (options & MATRIX_BY_COLUMNS) = Zero then
            num := nr;
         end
      end


   set_num_columns(nc: INTEGER) is
         -- Change the number of columns
      require
         nc >= 1 and then nc < MAXNUM
      do
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            num := nc;
         end
      end

feature -- Message processing

   on_focus_up(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW;
         r,c: INTEGER;
      do

         if focus_child /= Void then
            r := row_of_child(focus_child);
            c := col_of_child(focus_child);
            from
               r := r - 1;
               child := child_at_row_col(r,c)
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_UP, 0, data))
                then
                  Result := True
               else
                  r := r - 1;
                  child := child_at_row_col(r, c)
               end
            end
         else
            from
               child := last_child;
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_UP, 0, data))
                then
                  Result := True
               else
                  child := child.prev;
               end
            end
         end
      end

   on_focus_down(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW;
         r, c: INTEGER;
      do

         if focus_child /= Void then
            r := row_of_child(focus_child);
            c := col_of_child(focus_child);
            from
               r := r + 1;
               child := child_at_row_col(r,c)
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_DOWN, 0, data))
                then
                  Result := True
               else
                  r := r+1;
                  child := child_at_row_col(r,c)
               end
            end
         else
            from
               child := first_child;
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_DOWN, 0, data))
                then
                  Result := True
               else
                  child := child.next;
               end
            end
         end
      end

   on_focus_left(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW;
         r,c: INTEGER;
      do

         if focus_child /= Void then
            r := row_of_child(focus_child);
            c := col_of_child(focus_child);
            from
               c := c - 1;
               child := child_at_row_col(r,c)
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_LEFT, 0, data))
                then
                  Result := True
               else
                  c := c-1;
                  child := child_at_row_col(r,c)
               end
            end
         else
            from
               child := last_child;
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_LEFT, 0, data))
                then
                  Result := True
               else
                  child := child.prev;
               end
            end
         end
      end

   on_focus_right(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW;
         r,c: INTEGER;
      do

         if focus_child /= Void then
            r := row_of_child(focus_child);
            c := col_of_child(focus_child);
            from
               c := c+1;
               child := child_at_row_col(r,c)
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_RIGHT, 0, data))
                then
                  Result := True
               else
                  c := c+1;
                  child := child_at_row_col(r,c)
               end
            end
         else
            from
               child := first_child;
            until
               Result or else child = Void
            loop
               if child.is_shown and then
                     (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                      or else child.handle_2 (Current, SEL_FOCUS_RIGHT, 0, data))
                then
                  Result := True
               else
                  child := child.next;
               end
            end
         end
      end

feature {NONE} -- Implementation

   num: INTEGER;

   layout is
      local
         ncol, nrow, nzcol, nzrow, r, c, x,y, w,h, n, e, t: INTEGER;
         rowh, colw: ARRAY [ INTEGER ];
         srow,scol: ARRAY [ BOOLEAN ];
         left, right, top, bottom, cw, rh: INTEGER;
         mw,mh,hremain,vremain, hsumexpand,hnumexpand,
         vsumexpand, vnumexpand: INTEGER
         child: SB_WINDOW
         hints: INTEGER;
      do

         -- Placement rectangle; right/bottom non-inclusive
         left := border+pad_left;
         right := width-border-pad_right;
         top := border+pad_top;
         bottom := height-border-pad_bottom;
         hremain := right-left;
         vremain := bottom-top;

         -- Non-Zero rows/columns
         nzrow := 0;
         nzcol := 0;

         -- Clear column/row sizes
         !!colw.make(0,MAXNUM);
         !!rowh.make(0,MAXNUM);
         !!srow.make(0,MAXNUM);
         !!scol.make(0,MAXNUM);
         from
            n := 0;
         until
            n >= MAXNUM
         loop
            srow.put(True,n);
            scol.put(True,n);
            n := n + 1;
         end

         -- Get maximum child size
         if (options & Pack_uniform_width) /= Zero then
            mw := max_child_width;
         end
         if (options & Pack_uniform_height) /= Zero then
            mh := max_child_height;
         end
         -- Find expandable columns and rows
         from
            child := first_child;
            n := 0;
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints;
               if (options & MATRIX_BY_COLUMNS) /= Zero then
                  r := n // num;
                  c := n \\ num;
               else
                  r := n \\ num;
                  c := n // num;
               end
               -- FXASSERT(r<MAXNUM && c<MAXNUM);
               if (hints & Layout_fix_width) /= Zero then
                  w := child.width
               elseif (options & Pack_uniform_width) /= Zero then
                  w := mw;
               else
                  w := child.default_width;
               end
               if (hints & Layout_fix_height) /= Zero then
                  h := child.height;
               elseif (options & Pack_uniform_height) /= Zero then
                  h := mh;
               else
                  h := child.default_height;
               end
               --FXASSERT(w>=0);
               --FXASSERT(h>=0);
               if w > colw.item(c) then
                  if colw.item(c) = 0 then
                     nzcol := nzcol + 1;
                  end
                  colw.put(w,c)
               end
               if h > rowh.item(r) then
                  if rowh.item(r) = 0 then
                     nzrow := nzrow + 1;
                  end
                  rowh.put(h,r)
               end
               if (hints & Layout_fill_column) = Zero then
                  scol.put(False,c);
               end
               if (hints & Layout_fill_row) = Zero then
                  srow.put(False,r);
               end
            end
            child := child.next;
            n := n + 1
         end

         -- Get number of rows and columns
         if (options & MATRIX_BY_COLUMNS) /= Zero then
            ncol := num;
            nrow := (n+num-1)//num;
         else
            ncol := (n+num-1)//num;
            nrow := num;
         end

         -- Find stretch in columns
         from
            c := 0;
            hsumexpand := 0;
            hnumexpand :=0;
         until
            c >= ncol
         loop
            if colw.item(c) /= 0 then
               if scol.item(c) then
                  hsumexpand := hsumexpand + colw.item(c);
                  hnumexpand := hnumexpand + 1;
               else
                  hremain := hremain - colw.item(c);
               end
            end
            c := c + 1;
         end

         -- Find stretch in rows
         from
            r := 0;
            vsumexpand := 0;
            vnumexpand := 0;
         until
            r >= nrow
         loop
            if rowh.item(r) /= 0 then
               if srow.item(r) then
                  vsumexpand := vsumexpand + rowh.item(r);
                  vnumexpand := vnumexpand + 1;
               else
                  vremain := vremain - rowh.item(r);
               end
            end
            r := r + 1
         end

         -- Substract spacing for non-Zero rows/columns
         if nzcol > 1 then
            hremain := hremain - (nzcol-1)*h_spacing;
         end
         if nzrow > 1 then
            vremain := vremain - (nzrow-1)*v_spacing;
         end

         -- Disburse space horizontally
         from
            c := 0;
            e := 0;
            x := border+pad_left;
         until
            c >= ncol
         loop
            w := colw.item(c);
            colw.put(x,c)
            if w /= 0 then
               if scol.item(c) then
                  if hsumexpand > 0 then
                     -- Divide proportionally
                     t := w*hremain;
                     w := t//hsumexpand;
                     e := e + t\\hsumexpand;
                     if e >= hsumexpand then
                        w := w+1;
                        e := e- hsumexpand;
                     end
                  else 
                     -- Divide equally
                     -- FXASSERT(hnumexpand>0);
                     w := hremain//hnumexpand;
                     e := e + hremain\\hnumexpand;
                     if e >= hnumexpand then
                        w := w+1;
                        e := e- hnumexpand;
                     end
                  end
               end
               x := x + w + h_spacing;
            end
            c := c + 1
         end
         colw.put(x,ncol);

         -- Disburse space vertically
         from
            r := 0;
            e := 0;
            y := border+pad_top;
         until
            r >= nrow
         loop
            h := rowh.item(r);
            rowh.put(y,r);
            if h /= 0 then
               if srow.item(r) then
                  if vsumexpand > 0 then
                     -- Divide proportionally
                     t := h*vremain;
                     h := t//vsumexpand;
                     e := e+t\\vsumexpand;
                     if e >= vsumexpand then
                        h := h + 1;
                        e := e - vsumexpand;
                     end
                  else
                     -- Divide equally
                     -- FXASSERT(vnumexpand>0);
                     h := vremain//vnumexpand;
                     e := e + vremain\\vnumexpand;
                     if e >= vnumexpand then
                        h := h + 1;
                        e := e-vnumexpand;
                     end
                  end
               end
               y := y + h + v_spacing;
            end
            r := r + 1
         end
         rowh.put(y,nrow);

         -- Do the layout
         from
            child := first_child;
            n := 0;
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints;
               if (options & MATRIX_BY_COLUMNS) /= Zero then
                  r := n//num;
                  c := n\\num;
               else
                  r := n\\num;
                  c := n//num;
               end
               cw := colw.item(c+1)-colw.item(c)-h_spacing;
               rh := rowh.item(r+1)-rowh.item(r)-v_spacing;

               if (hints & Layout_fix_width) /= Zero then
                  w := child.width
               elseif (hints & Layout_fill_x) /= Zero then
                  w := cw;
               elseif (options & Pack_uniform_width) /= Zero then
                  w := mw;
               else
                  w := child.default_width;
               end

               if (hints & Layout_center_x) /= Zero then
                  x := colw.item(c)+(cw-w)//2;
               elseif (hints & Layout_right) /= Zero then
                  x := colw.item(c)+cw-w;
               else
                  x := colw.item(c);
               end

               if (hints & Layout_fix_height) /= Zero then
                  h := child.height;
               elseif (hints & Layout_fill_y) /= Zero then
                  h := rh;
               elseif (options & Pack_uniform_height) /= Zero then
                  h := mh;
               else
                  h := child.default_height;
               end

               if (hints & Layout_center_y) /= Zero then
                  y := rowh.item(r)+(rh-h)//2;
               elseif (hints & Layout_bottom) /= Zero then
                  y := rowh.item(r)+rh-h;
               else
                  y := rowh.item(r);
               end
               child.position(x,y,w,h);
            end
            child := child.next
            n := n+1
         end
         unset_flags (Flag_dirty);
      end
end
