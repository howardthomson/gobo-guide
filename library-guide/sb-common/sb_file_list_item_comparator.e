class SB_FILE_LIST_ITEM_COMPARATOR

inherit

   SB_COMPARATOR [ SB_FILE_LIST_ITEM ]

feature -- Comparision type

   type: INTEGER;

   set_type(tp: INTEGER)
      do
         type := tp;
      end

   reverse
      do
         type := -type;
      end

feature -- Comparison routine

   compare(a,b: SB_FILE_LIST_ITEM): INTEGER
      local
         t: INTEGER;
      do
         t := type.abs
         inspect t
         when 1 then
            Result := cmp_f_name(a,b);
         when 2 then
            Result := cmp_f_type(a,b);
         when 3 then
            Result := cmp_f_size(a,b);
         when 4 then
            Result := cmp_f_time(a,b);
         when 5 then
            Result := cmp_f_user(a,b);
         when 6 then
            Result := cmp_f_group(a,b);
         end
         if type < 0 then
            Result := -Result;
         end
      end

feature -- None implementation

   cmp_f_name(a,b: SB_FILE_LIST_ITEM): INTEGER
         -- Compare file names
      local
         s1,s2: STRING;
         i,e1,e2: INTEGER;
      do
         if b.is_directory and then not a.is_directory then
            Result := 1;
         elseif not b.is_directory and then a.is_directory then
            Result := -1;
         else
            s1 := a.label
            s2 := b.label
            from
               i := 1;
               e1 := s1.count;
               e2 := s2.count;
            until
               Result /= 0 or else i > e1 or else i > e2
            loop

        --		Result := s1.item(i).to_lower.code - s2.item(i).to_lower.code
               	Result := s1.item(i).as_lower.code - s2.item(i).as_lower.code

               i := i + 1
            end
            if i > e1 and then i <= e2 then
               Result := -1;
            elseif i <= e1 and then i > e2 then
               Result := 1;
            end
         end
      end

   cmp_f_type(a,b: SB_FILE_LIST_ITEM): INTEGER
         -- Compare file types
      local
         s1,s2: STRING;
         i,j,e1,e2: INTEGER;
         done: BOOLEAN;
      do
         if b.is_directory and then not a.is_directory then
            Result := 1;
         elseif not b.is_directory and then a.is_directory then
            Result := -1;
         else
            s1 := a.label
            s2 := b.label
            from
               i := 1;
               e1 := s1.count;
            until
               i > e1 or else s1.item(i) = '%T'
            loop
               i := i+1;
            end
            from
               j := 1;
               e2 := s2.count;
            until
               j > e2 or else s2.item(j) = '%T'
            loop
               j := j+1;
            end

            from
               e1 := s1.count;
               e2 := s2.count;
            until
               done or else Result /= 0 or else (i > e1 and then j > e2)
            loop
               if i > e1 then
                  Result := - 1;
               elseif j > e2 then
                  Result := 1;
               else

           --       Result := s1.item(i).to_lower.code - s2.item(j).to_lower.code
                  Result := s1.item(i).as_lower.code - s2.item(j).as_lower.code

                  if s1.item(i) = '%T' then
                     done := True
                  else
                     i := i + 1
                     j := j + 1
                  end
               end
            end
            if Result = 0 then
               Result := cmp_f_name(a,b);
            end
         end
      end

   cmp_f_size(a,b: SB_FILE_LIST_ITEM): INTEGER
         -- Compare file size
      local
         i,j,e1,e2: INTEGER;
      do
         if b.is_directory and then not a.is_directory then
            Result := 1;
         elseif not b.is_directory and then a.is_directory then
            Result := -1;
         else
            Result := a.size - b.size;
         end
      end

   cmp_f_time(a,b: SB_FILE_LIST_ITEM): INTEGER
         -- Compare file time
      local
         i,j,e1,e2: INTEGER;
      do
         if b.is_directory and then not a.is_directory then
            Result := 1;
         elseif not b.is_directory and then a.is_directory then
            Result := -1;
         else
            Result := a.date - b.date;
         end
      end

   cmp_f_user(a,b: SB_FILE_LIST_ITEM): INTEGER
         -- Compare file user
      local
         s1,s2: STRING;
         i,j,e1,e2,n: INTEGER;
         done: BOOLEAN;
      do
         if b.is_directory and then not a.is_directory then
            Result := 1;
         elseif not b.is_directory and then a.is_directory then
            Result := -1;
         else
            s1 := a.label
            s2 := b.label
            from
               i := 1;
               n := 4;
               e1 := s1.count;
            until
               i > e1 or else n = 0
            loop
               if s1.item(i) = '%T' then n := n-1 end
               i := i+1;
            end
            from
               j := 1;
               n := 4;
               e2 := s2.count;
            until
               j > e2 or else n = 0
            loop
               if s2.item(j) = '%T' then n := n-1 end
               j := j+1;
            end

            from
            until
               done or else Result /= 0 or else (i > e1 and then j > e2)
            loop
               if i > e1 then
                  Result := - 1;
               elseif j > e2 then
                  Result := 1;
               else

          --        Result := s1.item(i).to_lower.code - s2.item(j).to_lower.code
                  Result := s1.item(i).as_lower.code - s2.item(j).as_lower.code

                  if s1.item(i) = '%T' then
                     done := True
                  else
                     i := i + 1
                     j := j + 1
                  end
               end
            end
            if Result = 0 then
               Result := cmp_f_name(a,b);
            end
         end
      end

   cmp_f_group(a,b: SB_FILE_LIST_ITEM): INTEGER
         -- Compare file group
      local
         s1,s2: STRING;
         i,j,e1,e2,n: INTEGER;
         done: BOOLEAN;
      do
         if b.is_directory and then not a.is_directory then
            Result := 1;
         elseif not b.is_directory and then a.is_directory then
            Result := -1;
         else
            s1 := a.label
            s2 := b.label
            from
               i := 1;
               n := 5;
               e1 := s1.count;
            until
               i > e1 or else n = 0
            loop
               if s1.item(i) = '%T' then n := n-1 end
               i := i+1;
            end
            from
               j := 1;
               n := 5;
               e2 := s2.count;
            until
               j > e2 or else n = 0
            loop
               if s2.item(j) = '%T' then n := n-1 end
               j := j+1;
            end

            from
            until
               done or else Result /= 0 or else (i > e1 and then j > e2)
            loop
               if i > e1 then
                  Result := - 1;
               elseif j > e2 then
                  Result := 1;
               else

           --       Result := s1.item(i).to_lower.code - s2.item(j).to_lower.code
                  Result := s1.item(i).as_lower.code - s2.item(j).as_lower.code

                  if s1.item(i) = '%T' then
                     done := True
                  else
                     i := i + 1
                     j := j + 1
                  end
               end
            end
            if Result = 0 then
               Result := cmp_f_name(a,b);
            end
         end
      end

end
