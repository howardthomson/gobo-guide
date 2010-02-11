# NOTE edp_eiffel_parser.e DO NOT OVERWRITE from edp_eiffel_parser.y

all: et_eiffel_parser.e edp_eiffel_scanner.e

et_eiffel_parser.e et_eiffel_symbols.e: et_eiffel_parser.y
	geyacc --verbose=parser-verbose --new_typing -t ET_EIFFEL_TOKENS -k et_eiffel_tokens.e \
		-o et_eiffel_parser.e et_eiffel_parser.y

edp_eiffel_scanner.e: edp_eiffel_scanner.l
	gelex -o edp_eiffel_scanner.e edp_eiffel_scanner.l
