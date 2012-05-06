deferred class SB_OPTIONS

feature { NONE }

	options: INTEGER

	reset_options
		do
			options := 0
		end

	set_options (bits: INTEGER)
		do
			options := options | bits
		end

	unset_options (bits: INTEGER)
		do
			options := options.bit_and (bits.bit_not)
		end

	set_options_mask (bits, mask: INTEGER)
		do
			options := (options.bit_and (mask.bit_not)) | bits
		end

	mask_options (mask: INTEGER): INTEGER
		do
			Result := options & mask
		end

	test_options (bits: INTEGER): BOOLEAN
		do
			Result := (options & bits) /= 0
		end

	is_default_options: BOOLEAN
		do
			Result := options = default_options
		end

	default_options: INTEGER
			-- Redefine in descendants ...
		do
			Result := 0
		end

	new_options (arg, mask: INTEGER): INTEGER
		do
			Result := (options & (mask).bit_not) | (arg & mask)
		end

	set_default_options
		do
			options := default_options
		end

end