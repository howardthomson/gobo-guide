indexing
	description: "Compute the difference between two arrays."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-06-05 11:14:58 -0700 (Mon, 05 Jun 2006) $"
	revision: "$Revision: 59408 $"

class
	DIFF [G -> HASHABLE ]

feature -- Status report

	values_set: BOOLEAN is
			-- Are the values to compare set?
		do
			Result := src /= Void and dst /= Void
		end

feature -- Change elements

	set (a_src: ARRAY [G]; a_dst: ARRAY [G]) is
			-- Set the source array `a_src' and the destination `a_dst'.
		require
			a_src_not_void: a_src /= Void
			a_dst_not_void: a_dst /= Void
		do
			src := a_src
			dst := a_dst
		ensure
			values_set: values_set
		end

feature {NONE} -- Implementation

	src: ARRAY[G]
			-- The source array.

	dst: ARRAY[G]
			-- The destination array.

	all_matches: HASH_TABLE [INTEGER, INTEGER]
			-- All the matches.

	equal_tokens (a, b: G): BOOLEAN is
		do
			Result := equal (a, b)
		end

	compute_lcs is
			-- Compute the longest common subsequence.
		require
			values_set: values_set
		local
			start_src, end_src, start_dst, end_dst: INTEGER
			hash_dst: HASH_TABLE [LINKED_LIST [INTEGER], G]
			i, h, m, si, di: INTEGER
			matches: LINKED_LIST [INTEGER]
			links: ARRAYED_LIST [DIFF_INDEX_LINK]
			link: DIFF_INDEX_LINK
			work: ARRAYED_LIST [INTEGER]
		do
				-- This uses the algorithm described in
				-- A Fast Algorithm for Computing Longest Common Subsequences, CACM, vol.20, no.5, pp.350-353, May 1977
			start_src := 1
			start_dst := 1
			end_src := src.count
			end_dst := dst.count

			create all_matches.make (src.count)

				-- TODO
				-- prune Match_exclude tokens at beginning and end
				-- of both source and destination ...
--			from
--			until
--				start_src > end_src
--				or not
--				(src[start_src]).is_match_exclude
--			loop
--				start_src := start_src + 1
--			end

--			from
--			until
--				start_dst > end_dst
--				or not
--				(dst[start_dst]).is_match_exclude
--			loop
--				start_dst := start_dst + 1
--			end

--			from
--			until
--				start_src > end_src
--				or not
--				(src[end_src]).is_match_exclude
--			loop
--				end_src := end_src - 1
--			end

--			from
--			until
--				start_dst > end_dst
--				or not
--				(dst[end_dst]).is_match_exclude
--			loop
--				end_dst := end_dst - 1
--			end

				-- prune same lines at the beginning
			from
			until
				start_src > end_src
				or
				start_dst > end_dst
				or not
				equal_tokens (src[start_src], dst[start_dst])
			loop
				all_matches.put (start_dst, start_src)
				start_src := start_src + 1
				start_dst := start_dst + 1
			end

				-- prune same lines at the end
			from
			until
				start_src > end_src
				or
				start_dst > end_dst
				or not
				equal_tokens (src[end_src], dst[end_dst])
			loop
				all_matches.put (end_dst, end_src)
				end_src := end_src - 1
				end_dst := end_dst - 1
			end

				-- build hashtable which maps the contents in dst to their lines
			create hash_dst.make (end_dst - start_dst + 1)
			from
				i := start_dst
			until
				i > end_dst
			loop
				if hash_dst.has (dst[i]) then
					hash_dst.item (dst[i]).extend (i)
				else
					create matches.make
					matches.extend (i)
					hash_dst.put (matches, dst[i])
				end
				i := i + 1
			end

			create work.make (100)
			create links.make (100)

				-- loop through the source
			from
				si := start_src
			until
				si > end_src
			loop
					-- do we have matches in dst?
				if hash_dst.has (src[si]) then
					matches := hash_dst.item (src[si])
					i := 0

						-- for each match
					from
						matches.finish
					until
						matches.before
					loop
						di := matches.item

							-- OPTIMIZATION: in most cases the further matches replace the last match, so we make a shortcut for this here
						if i > 1 and work[i] > di and work[i-1] < di then
							work[i] := di
						else
								-- add the element into the work list
								-- if the element is already in the list, do nothing and set i to -1
								-- if the place where the element belongs is filled with something else, replace it and set i to the position
								-- if there is no place, add it at the end and set i to the position

								-- OPTIMIZATION: shortcut for the cases that the entry has to be added at the end
							if work.is_empty or else work.last < di then
								work.extend (di)
								i := work.count
							else
								from
									i := 1
									h := work.count
								until
									i = -1 or i > h
								loop
									m := (i + h) // 2
									if work[m] = di then
										i := -1
									elseif work[m] > di then
										h := m - 1
									else
										i := m + 1
									end
								end
								if i > 0 then
									work[i] := di
								end
							end
						end

							-- now if we added the element to the work list, add it as a match into our links list
						if i /= -1 then
							if i > 1 then
								create link.make (links[i-1], si, di)
							else
								create link.make (void, si, di)
							end
							if links.count < i then
								links.extend (link)
							else
								links.put_i_th (link, i)
							end
						end

						matches.back
					end
				end

				si := si + 1
			end

				-- store the matches
			if links.count > 0 then
				from
					link := links[links.count]
						-- check if the values themselves are also equal (above we worked with hashes)
					if equal_tokens (src[link.index_src], dst[link.index_dst]) then
						all_matches.put (link.index_dst, link.index_src)
					end
				until
					link.next = void
				loop
					link := link.next
						-- check if the values themselves are also equal (above we worked with hashes)
					if equal_tokens (src[link.index_src], dst[link.index_dst]) then
						all_matches.put (link.index_dst, link.index_src)
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end