note

	description:

		"Eiffel parsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2006, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2006/03/09 11:40:28 $"
	revision: "$Revision: 1.62 $"

	mods: "[
		Tilde_call_agent removed; commented out
	]"

	todo: "[
		Add non-conforming inheritance
		Add U"..." for Unicode type string
		Add inspect string_type
			Added to syntax, ast needs amending to match
		Add { Type << ... >> }
		Add { Type Real }
		Add { Type Integer }
	]"

	done: "[
		Permit multiple 'inherit' sections
		'~' operator added to prefix Non_binary section
	]"

class ET_EIFFEL_PARSER

inherit

	ET_EIFFEL_PARSER_SKELETON
		undefine
			read_token
		redefine
			yyparse, universe,
			set_builtin_function,
			set_builtin_procedure
		end

	ET_EIFFEL_SCANNER
		rename
			make as make_eiffel_scanner,
			make_with_factory as make_eiffel_scanner_with_factory
		undefine
			reset, set_syntax_error
		redefine
			universe
		end

create

	make, make_with_factory

feature

	edp_ast_factory: EDP_AST_FACTORY
		do
			Result ?= ast_factory
				check Result /= Void
			end
		end

	set_builtin_function (a_feature: ET_EXTERNAL_FUNCTION)
			-- Set built-in code of `a_feature'.
		do
			if True then
				Precursor(a_feature)
			end
		end

	set_builtin_procedure (a_feature: ET_EXTERNAL_PROCEDURE)
			-- Set built-in code of `a_feature'.
		do
			if True then
				Precursor(a_feature)
			end
		end

feature {NONE} -- Implementation

	yy_build_parser_tables
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks
			-- Create value stacks.
		do
		end

	yy_init_value_stacks
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
			yyvsp10 := -1
			yyvsp11 := -1
			yyvsp12 := -1
			yyvsp13 := -1
			yyvsp14 := -1
			yyvsp15 := -1
			yyvsp16 := -1
			yyvsp17 := -1
			yyvsp18 := -1
			yyvsp19 := -1
			yyvsp20 := -1
			yyvsp21 := -1
			yyvsp22 := -1
			yyvsp23 := -1
			yyvsp24 := -1
			yyvsp25 := -1
			yyvsp26 := -1
			yyvsp27 := -1
			yyvsp28 := -1
			yyvsp29 := -1
			yyvsp30 := -1
			yyvsp31 := -1
			yyvsp32 := -1
			yyvsp33 := -1
			yyvsp34 := -1
			yyvsp35 := -1
			yyvsp36 := -1
			yyvsp37 := -1
			yyvsp38 := -1
			yyvsp39 := -1
			yyvsp40 := -1
			yyvsp41 := -1
			yyvsp42 := -1
			yyvsp43 := -1
			yyvsp44 := -1
			yyvsp45 := -1
			yyvsp46 := -1
			yyvsp47 := -1
			yyvsp48 := -1
			yyvsp49 := -1
			yyvsp50 := -1
			yyvsp51 := -1
			yyvsp52 := -1
			yyvsp53 := -1
			yyvsp54 := -1
			yyvsp55 := -1
			yyvsp56 := -1
			yyvsp57 := -1
			yyvsp58 := -1
			yyvsp59 := -1
			yyvsp60 := -1
			yyvsp61 := -1
			yyvsp62 := -1
			yyvsp63 := -1
			yyvsp64 := -1
			yyvsp65 := -1
			yyvsp66 := -1
			yyvsp67 := -1
			yyvsp68 := -1
			yyvsp69 := -1
			yyvsp70 := -1
			yyvsp71 := -1
			yyvsp72 := -1
			yyvsp73 := -1
			yyvsp74 := -1
			yyvsp75 := -1
			yyvsp76 := -1
			yyvsp77 := -1
			yyvsp78 := -1
			yyvsp79 := -1
			yyvsp80 := -1
			yyvsp81 := -1
			yyvsp82 := -1
			yyvsp83 := -1
			yyvsp84 := -1
			yyvsp85 := -1
			yyvsp86 := -1
			yyvsp87 := -1
			yyvsp88 := -1
			yyvsp89 := -1
			yyvsp90 := -1
			yyvsp91 := -1
			yyvsp92 := -1
			yyvsp93 := -1
			yyvsp94 := -1
			yyvsp95 := -1
			yyvsp96 := -1
			yyvsp97 := -1
			yyvsp98 := -1
			yyvsp99 := -1
			yyvsp100 := -1
			yyvsp101 := -1
			yyvsp102 := -1
			yyvsp103 := -1
			yyvsp104 := -1
			yyvsp105 := -1
			yyvsp106 := -1
			yyvsp107 := -1
			yyvsp108 := -1
			yyvsp109 := -1
			yyvsp110 := -1
			yyvsp111 := -1
			yyvsp112 := -1
			yyvsp113 := -1
			yyvsp114 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			if yyvs1 /= Void then
				yyvs1.clear_all
			end
			if yyvs2 /= Void then
				yyvs2.clear_all
			end
			if yyvs3 /= Void then
				yyvs3.clear_all
			end
			if yyvs4 /= Void then
				yyvs4.clear_all
			end
			if yyvs5 /= Void then
				yyvs5.clear_all
			end
			if yyvs6 /= Void then
				yyvs6.clear_all
			end
			if yyvs7 /= Void then
				yyvs7.clear_all
			end
			if yyvs8 /= Void then
				yyvs8.clear_all
			end
			if yyvs9 /= Void then
				yyvs9.clear_all
			end
			if yyvs10 /= Void then
				yyvs10.clear_all
			end
			if yyvs11 /= Void then
				yyvs11.clear_all
			end
			if yyvs12 /= Void then
				yyvs12.clear_all
			end
			if yyvs13 /= Void then
				yyvs13.clear_all
			end
			if yyvs14 /= Void then
				yyvs14.clear_all
			end
			if yyvs15 /= Void then
				yyvs15.clear_all
			end
			if yyvs16 /= Void then
				yyvs16.clear_all
			end
			if yyvs17 /= Void then
				yyvs17.clear_all
			end
			if yyvs18 /= Void then
				yyvs18.clear_all
			end
			if yyvs19 /= Void then
				yyvs19.clear_all
			end
			if yyvs20 /= Void then
				yyvs20.clear_all
			end
			if yyvs21 /= Void then
				yyvs21.clear_all
			end
			if yyvs22 /= Void then
				yyvs22.clear_all
			end
			if yyvs23 /= Void then
				yyvs23.clear_all
			end
			if yyvs24 /= Void then
				yyvs24.clear_all
			end
			if yyvs25 /= Void then
				yyvs25.clear_all
			end
			if yyvs26 /= Void then
				yyvs26.clear_all
			end
			if yyvs27 /= Void then
				yyvs27.clear_all
			end
			if yyvs28 /= Void then
				yyvs28.clear_all
			end
			if yyvs29 /= Void then
				yyvs29.clear_all
			end
			if yyvs30 /= Void then
				yyvs30.clear_all
			end
			if yyvs31 /= Void then
				yyvs31.clear_all
			end
			if yyvs32 /= Void then
				yyvs32.clear_all
			end
			if yyvs33 /= Void then
				yyvs33.clear_all
			end
			if yyvs34 /= Void then
				yyvs34.clear_all
			end
			if yyvs35 /= Void then
				yyvs35.clear_all
			end
			if yyvs36 /= Void then
				yyvs36.clear_all
			end
			if yyvs37 /= Void then
				yyvs37.clear_all
			end
			if yyvs38 /= Void then
				yyvs38.clear_all
			end
			if yyvs39 /= Void then
				yyvs39.clear_all
			end
			if yyvs40 /= Void then
				yyvs40.clear_all
			end
			if yyvs41 /= Void then
				yyvs41.clear_all
			end
			if yyvs42 /= Void then
				yyvs42.clear_all
			end
			if yyvs43 /= Void then
				yyvs43.clear_all
			end
			if yyvs44 /= Void then
				yyvs44.clear_all
			end
			if yyvs45 /= Void then
				yyvs45.clear_all
			end
			if yyvs46 /= Void then
				yyvs46.clear_all
			end
			if yyvs47 /= Void then
				yyvs47.clear_all
			end
			if yyvs48 /= Void then
				yyvs48.clear_all
			end
			if yyvs49 /= Void then
				yyvs49.clear_all
			end
			if yyvs50 /= Void then
				yyvs50.clear_all
			end
			if yyvs51 /= Void then
				yyvs51.clear_all
			end
			if yyvs52 /= Void then
				yyvs52.clear_all
			end
			if yyvs53 /= Void then
				yyvs53.clear_all
			end
			if yyvs54 /= Void then
				yyvs54.clear_all
			end
			if yyvs55 /= Void then
				yyvs55.clear_all
			end
			if yyvs56 /= Void then
				yyvs56.clear_all
			end
			if yyvs57 /= Void then
				yyvs57.clear_all
			end
			if yyvs58 /= Void then
				yyvs58.clear_all
			end
			if yyvs59 /= Void then
				yyvs59.clear_all
			end
			if yyvs60 /= Void then
				yyvs60.clear_all
			end
			if yyvs61 /= Void then
				yyvs61.clear_all
			end
			if yyvs62 /= Void then
				yyvs62.clear_all
			end
			if yyvs63 /= Void then
				yyvs63.clear_all
			end
			if yyvs64 /= Void then
				yyvs64.clear_all
			end
			if yyvs65 /= Void then
				yyvs65.clear_all
			end
			if yyvs66 /= Void then
				yyvs66.clear_all
			end
			if yyvs67 /= Void then
				yyvs67.clear_all
			end
			if yyvs68 /= Void then
				yyvs68.clear_all
			end
			if yyvs69 /= Void then
				yyvs69.clear_all
			end
			if yyvs70 /= Void then
				yyvs70.clear_all
			end
			if yyvs71 /= Void then
				yyvs71.clear_all
			end
			if yyvs72 /= Void then
				yyvs72.clear_all
			end
			if yyvs73 /= Void then
				yyvs73.clear_all
			end
			if yyvs74 /= Void then
				yyvs74.clear_all
			end
			if yyvs75 /= Void then
				yyvs75.clear_all
			end
			if yyvs76 /= Void then
				yyvs76.clear_all
			end
			if yyvs77 /= Void then
				yyvs77.clear_all
			end
			if yyvs78 /= Void then
				yyvs78.clear_all
			end
			if yyvs79 /= Void then
				yyvs79.clear_all
			end
			if yyvs80 /= Void then
				yyvs80.clear_all
			end
			if yyvs81 /= Void then
				yyvs81.clear_all
			end
			if yyvs82 /= Void then
				yyvs82.clear_all
			end
			if yyvs83 /= Void then
				yyvs83.clear_all
			end
			if yyvs84 /= Void then
				yyvs84.clear_all
			end
			if yyvs85 /= Void then
				yyvs85.clear_all
			end
			if yyvs86 /= Void then
				yyvs86.clear_all
			end
			if yyvs87 /= Void then
				yyvs87.clear_all
			end
			if yyvs88 /= Void then
				yyvs88.clear_all
			end
			if yyvs89 /= Void then
				yyvs89.clear_all
			end
			if yyvs90 /= Void then
				yyvs90.clear_all
			end
			if yyvs91 /= Void then
				yyvs91.clear_all
			end
			if yyvs92 /= Void then
				yyvs92.clear_all
			end
			if yyvs93 /= Void then
				yyvs93.clear_all
			end
			if yyvs94 /= Void then
				yyvs94.clear_all
			end
			if yyvs95 /= Void then
				yyvs95.clear_all
			end
			if yyvs96 /= Void then
				yyvs96.clear_all
			end
			if yyvs97 /= Void then
				yyvs97.clear_all
			end
			if yyvs98 /= Void then
				yyvs98.clear_all
			end
			if yyvs99 /= Void then
				yyvs99.clear_all
			end
			if yyvs100 /= Void then
				yyvs100.clear_all
			end
			if yyvs101 /= Void then
				yyvs101.clear_all
			end
			if yyvs102 /= Void then
				yyvs102.clear_all
			end
			if yyvs103 /= Void then
				yyvs103.clear_all
			end
			if yyvs104 /= Void then
				yyvs104.clear_all
			end
			if yyvs105 /= Void then
				yyvs105.clear_all
			end
			if yyvs106 /= Void then
				yyvs106.clear_all
			end
			if yyvs107 /= Void then
				yyvs107.clear_all
			end
			if yyvs108 /= Void then
				yyvs108.clear_all
			end
			if yyvs109 /= Void then
				yyvs109.clear_all
			end
			if yyvs110 /= Void then
				yyvs110.clear_all
			end
			if yyvs111 /= Void then
				yyvs111.clear_all
			end
			if yyvs112 /= Void then
				yyvs112.clear_all
			end
			if yyvs113 /= Void then
				yyvs113.clear_all
			end
			if yyvs114 /= Void then
				yyvs114.clear_all
			end
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					if yyvs1 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs1")
						end
						create yyspecial_routines1
						yyvsc1 := yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.make (yyvsc1)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs1")
						end
						yyvsc1 := yyvsc1 + yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
					end
				end
				yyvs1.put (last_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					if yyvs2 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs2")
						end
						create yyspecial_routines2
						yyvsc2 := yyInitial_yyvs_size
						yyvs2 := yyspecial_routines2.make (yyvsc2)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs2")
						end
						yyvsc2 := yyvsc2 + yyInitial_yyvs_size
						yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
					end
				end
				yyvs2.put (last_et_keyword_value, yyvsp2)
			when 3 then
				yyvsp3 := yyvsp3 + 1
				if yyvsp3 >= yyvsc3 then
					if yyvs3 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs3")
						end
						create yyspecial_routines3
						yyvsc3 := yyInitial_yyvs_size
						yyvs3 := yyspecial_routines3.make (yyvsc3)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs3")
						end
						yyvsc3 := yyvsc3 + yyInitial_yyvs_size
						yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
					end
				end
				yyvs3.put (last_et_precursor_keyword_value, yyvsp3)
			when 4 then
				yyvsp4 := yyvsp4 + 1
				if yyvsp4 >= yyvsc4 then
					if yyvs4 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs4")
						end
						create yyspecial_routines4
						yyvsc4 := yyInitial_yyvs_size
						yyvs4 := yyspecial_routines4.make (yyvsc4)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs4")
						end
						yyvsc4 := yyvsc4 + yyInitial_yyvs_size
						yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
					end
				end
				yyvs4.put (last_et_symbol_value, yyvsp4)
			when 5 then
				yyvsp5 := yyvsp5 + 1
				if yyvsp5 >= yyvsc5 then
					if yyvs5 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs5")
						end
						create yyspecial_routines5
						yyvsc5 := yyInitial_yyvs_size
						yyvs5 := yyspecial_routines5.make (yyvsc5)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs5")
						end
						yyvsc5 := yyvsc5 + yyInitial_yyvs_size
						yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
					end
				end
				yyvs5.put (last_et_position_value, yyvsp5)
			when 6 then
				yyvsp6 := yyvsp6 + 1
				if yyvsp6 >= yyvsc6 then
					if yyvs6 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs6")
						end
						create yyspecial_routines6
						yyvsc6 := yyInitial_yyvs_size
						yyvs6 := yyspecial_routines6.make (yyvsc6)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs6")
						end
						yyvsc6 := yyvsc6 + yyInitial_yyvs_size
						yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
					end
				end
				yyvs6.put (last_et_bit_constant_value, yyvsp6)
			when 7 then
				yyvsp7 := yyvsp7 + 1
				if yyvsp7 >= yyvsc7 then
					if yyvs7 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs7")
						end
						create yyspecial_routines7
						yyvsc7 := yyInitial_yyvs_size
						yyvs7 := yyspecial_routines7.make (yyvsc7)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs7")
						end
						yyvsc7 := yyvsc7 + yyInitial_yyvs_size
						yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
					end
				end
				yyvs7.put (last_et_boolean_constant_value, yyvsp7)
			when 8 then
				yyvsp8 := yyvsp8 + 1
				if yyvsp8 >= yyvsc8 then
					if yyvs8 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs8")
						end
						create yyspecial_routines8
						yyvsc8 := yyInitial_yyvs_size
						yyvs8 := yyspecial_routines8.make (yyvsc8)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs8")
						end
						yyvsc8 := yyvsc8 + yyInitial_yyvs_size
						yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
					end
				end
				yyvs8.put (last_et_break_value, yyvsp8)
			when 9 then
				yyvsp9 := yyvsp9 + 1
				if yyvsp9 >= yyvsc9 then
					if yyvs9 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs9")
						end
						create yyspecial_routines9
						yyvsc9 := yyInitial_yyvs_size
						yyvs9 := yyspecial_routines9.make (yyvsc9)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs9")
						end
						yyvsc9 := yyvsc9 + yyInitial_yyvs_size
						yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
					end
				end
				yyvs9.put (last_et_character_constant_value, yyvsp9)
			when 10 then
				yyvsp10 := yyvsp10 + 1
				if yyvsp10 >= yyvsc10 then
					if yyvs10 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs10")
						end
						create yyspecial_routines10
						yyvsc10 := yyInitial_yyvs_size
						yyvs10 := yyspecial_routines10.make (yyvsc10)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs10")
						end
						yyvsc10 := yyvsc10 + yyInitial_yyvs_size
						yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
					end
				end
				yyvs10.put (last_et_current_value, yyvsp10)
			when 11 then
				yyvsp11 := yyvsp11 + 1
				if yyvsp11 >= yyvsc11 then
					if yyvs11 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs11")
						end
						create yyspecial_routines11
						yyvsc11 := yyInitial_yyvs_size
						yyvs11 := yyspecial_routines11.make (yyvsc11)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs11")
						end
						yyvsc11 := yyvsc11 + yyInitial_yyvs_size
						yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
					end
				end
				yyvs11.put (last_et_free_operator_value, yyvsp11)
			when 12 then
				yyvsp12 := yyvsp12 + 1
				if yyvsp12 >= yyvsc12 then
					if yyvs12 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs12")
						end
						create yyspecial_routines12
						yyvsc12 := yyInitial_yyvs_size
						yyvs12 := yyspecial_routines12.make (yyvsc12)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs12")
						end
						yyvsc12 := yyvsc12 + yyInitial_yyvs_size
						yyvs12 := yyspecial_routines12.resize (yyvs12, yyvsc12)
					end
				end
				yyvs12.put (last_et_identifier_value, yyvsp12)
			when 13 then
				yyvsp13 := yyvsp13 + 1
				if yyvsp13 >= yyvsc13 then
					if yyvs13 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs13")
						end
						create yyspecial_routines13
						yyvsc13 := yyInitial_yyvs_size
						yyvs13 := yyspecial_routines13.make (yyvsc13)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs13")
						end
						yyvsc13 := yyvsc13 + yyInitial_yyvs_size
						yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
					end
				end
				yyvs13.put (last_et_integer_constant_value, yyvsp13)
			when 14 then
				yyvsp14 := yyvsp14 + 1
				if yyvsp14 >= yyvsc14 then
					if yyvs14 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs14")
						end
						create yyspecial_routines14
						yyvsc14 := yyInitial_yyvs_size
						yyvs14 := yyspecial_routines14.make (yyvsc14)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs14")
						end
						yyvsc14 := yyvsc14 + yyInitial_yyvs_size
						yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
					end
				end
				yyvs14.put (last_et_keyword_operator_value, yyvsp14)
			when 15 then
				yyvsp15 := yyvsp15 + 1
				if yyvsp15 >= yyvsc15 then
					if yyvs15 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs15")
						end
						create yyspecial_routines15
						yyvsc15 := yyInitial_yyvs_size
						yyvs15 := yyspecial_routines15.make (yyvsc15)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs15")
						end
						yyvsc15 := yyvsc15 + yyInitial_yyvs_size
						yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
					end
				end
				yyvs15.put (last_et_manifest_string_value, yyvsp15)
			when 16 then
				yyvsp16 := yyvsp16 + 1
				if yyvsp16 >= yyvsc16 then
					if yyvs16 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs16")
						end
						create yyspecial_routines16
						yyvsc16 := yyInitial_yyvs_size
						yyvs16 := yyspecial_routines16.make (yyvsc16)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs16")
						end
						yyvsc16 := yyvsc16 + yyInitial_yyvs_size
						yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
					end
				end
				yyvs16.put (last_et_real_constant_value, yyvsp16)
			when 17 then
				yyvsp17 := yyvsp17 + 1
				if yyvsp17 >= yyvsc17 then
					if yyvs17 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs17")
						end
						create yyspecial_routines17
						yyvsc17 := yyInitial_yyvs_size
						yyvs17 := yyspecial_routines17.make (yyvsc17)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs17")
						end
						yyvsc17 := yyvsc17 + yyInitial_yyvs_size
						yyvs17 := yyspecial_routines17.resize (yyvs17, yyvsc17)
					end
				end
				yyvs17.put (last_et_result_value, yyvsp17)
			when 18 then
				yyvsp18 := yyvsp18 + 1
				if yyvsp18 >= yyvsc18 then
					if yyvs18 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs18")
						end
						create yyspecial_routines18
						yyvsc18 := yyInitial_yyvs_size
						yyvs18 := yyspecial_routines18.make (yyvsc18)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs18")
						end
						yyvsc18 := yyvsc18 + yyInitial_yyvs_size
						yyvs18 := yyspecial_routines18.resize (yyvs18, yyvsc18)
					end
				end
				yyvs18.put (last_et_retry_instruction_value, yyvsp18)
			when 19 then
				yyvsp19 := yyvsp19 + 1
				if yyvsp19 >= yyvsc19 then
					if yyvs19 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs19")
						end
						create yyspecial_routines19
						yyvsc19 := yyInitial_yyvs_size
						yyvs19 := yyspecial_routines19.make (yyvsc19)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs19")
						end
						yyvsc19 := yyvsc19 + yyInitial_yyvs_size
						yyvs19 := yyspecial_routines19.resize (yyvs19, yyvsc19)
					end
				end
				yyvs19.put (last_et_symbol_operator_value, yyvsp19)
			when 20 then
				yyvsp20 := yyvsp20 + 1
				if yyvsp20 >= yyvsc20 then
					if yyvs20 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs20")
						end
						create yyspecial_routines20
						yyvsc20 := yyInitial_yyvs_size
						yyvs20 := yyspecial_routines20.make (yyvsc20)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs20")
						end
						yyvsc20 := yyvsc20 + yyInitial_yyvs_size
						yyvs20 := yyspecial_routines20.resize (yyvs20, yyvsc20)
					end
				end
				yyvs20.put (last_et_void_value, yyvsp20)
			when 21 then
				yyvsp21 := yyvsp21 + 1
				if yyvsp21 >= yyvsc21 then
					if yyvs21 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs21")
						end
						create yyspecial_routines21
						yyvsc21 := yyInitial_yyvs_size
						yyvs21 := yyspecial_routines21.make (yyvsc21)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs21")
						end
						yyvsc21 := yyvsc21 + yyInitial_yyvs_size
						yyvs21 := yyspecial_routines21.resize (yyvs21, yyvsc21)
					end
				end
				yyvs21.put (last_et_semicolon_symbol_value, yyvsp21)
			when 22 then
				yyvsp22 := yyvsp22 + 1
				if yyvsp22 >= yyvsc22 then
					if yyvs22 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs22")
						end
						create yyspecial_routines22
						yyvsc22 := yyInitial_yyvs_size
						yyvs22 := yyspecial_routines22.make (yyvsc22)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs22")
						end
						yyvsc22 := yyvsc22 + yyInitial_yyvs_size
						yyvs22 := yyspecial_routines22.resize (yyvs22, yyvsc22)
					end
				end
				yyvs22.put (last_et_bracket_symbol_value, yyvsp22)
			when 23 then
				yyvsp23 := yyvsp23 + 1
				if yyvsp23 >= yyvsc23 then
					if yyvs23 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs23")
						end
						create yyspecial_routines23
						yyvsc23 := yyInitial_yyvs_size
						yyvs23 := yyspecial_routines23.make (yyvsc23)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs23")
						end
						yyvsc23 := yyvsc23 + yyInitial_yyvs_size
						yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
					end
				end
				yyvs23.put (last_et_question_mark_symbol_value, yyvsp23)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				if yyvs1 = Void then
					debug ("GEYACC")
						std.error.put_line ("Create yyvs1")
					end
					create yyspecial_routines1
					yyvsc1 := yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.make (yyvsc1)
				else
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
				end
			end
			yyvs1.put (yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER)
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
			when 10 then
				yyvsp10 := yyvsp10 - 1
			when 11 then
				yyvsp11 := yyvsp11 - 1
			when 12 then
				yyvsp12 := yyvsp12 - 1
			when 13 then
				yyvsp13 := yyvsp13 - 1
			when 14 then
				yyvsp14 := yyvsp14 - 1
			when 15 then
				yyvsp15 := yyvsp15 - 1
			when 16 then
				yyvsp16 := yyvsp16 - 1
			when 17 then
				yyvsp17 := yyvsp17 - 1
			when 18 then
				yyvsp18 := yyvsp18 - 1
			when 19 then
				yyvsp19 := yyvsp19 - 1
			when 20 then
				yyvsp20 := yyvsp20 - 1
			when 21 then
				yyvsp21 := yyvsp21 - 1
			when 22 then
				yyvsp22 := yyvsp22 - 1
			when 23 then
				yyvsp23 := yyvsp23 - 1
			when 24 then
				yyvsp24 := yyvsp24 - 1
			when 25 then
				yyvsp25 := yyvsp25 - 1
			when 26 then
				yyvsp26 := yyvsp26 - 1
			when 27 then
				yyvsp27 := yyvsp27 - 1
			when 28 then
				yyvsp28 := yyvsp28 - 1
			when 29 then
				yyvsp29 := yyvsp29 - 1
			when 30 then
				yyvsp30 := yyvsp30 - 1
			when 31 then
				yyvsp31 := yyvsp31 - 1
			when 32 then
				yyvsp32 := yyvsp32 - 1
			when 33 then
				yyvsp33 := yyvsp33 - 1
			when 34 then
				yyvsp34 := yyvsp34 - 1
			when 35 then
				yyvsp35 := yyvsp35 - 1
			when 36 then
				yyvsp36 := yyvsp36 - 1
			when 37 then
				yyvsp37 := yyvsp37 - 1
			when 38 then
				yyvsp38 := yyvsp38 - 1
			when 39 then
				yyvsp39 := yyvsp39 - 1
			when 40 then
				yyvsp40 := yyvsp40 - 1
			when 41 then
				yyvsp41 := yyvsp41 - 1
			when 42 then
				yyvsp42 := yyvsp42 - 1
			when 43 then
				yyvsp43 := yyvsp43 - 1
			when 44 then
				yyvsp44 := yyvsp44 - 1
			when 45 then
				yyvsp45 := yyvsp45 - 1
			when 46 then
				yyvsp46 := yyvsp46 - 1
			when 47 then
				yyvsp47 := yyvsp47 - 1
			when 48 then
				yyvsp48 := yyvsp48 - 1
			when 49 then
				yyvsp49 := yyvsp49 - 1
			when 50 then
				yyvsp50 := yyvsp50 - 1
			when 51 then
				yyvsp51 := yyvsp51 - 1
			when 52 then
				yyvsp52 := yyvsp52 - 1
			when 53 then
				yyvsp53 := yyvsp53 - 1
			when 54 then
				yyvsp54 := yyvsp54 - 1
			when 55 then
				yyvsp55 := yyvsp55 - 1
			when 56 then
				yyvsp56 := yyvsp56 - 1
			when 57 then
				yyvsp57 := yyvsp57 - 1
			when 58 then
				yyvsp58 := yyvsp58 - 1
			when 59 then
				yyvsp59 := yyvsp59 - 1
			when 60 then
				yyvsp60 := yyvsp60 - 1
			when 61 then
				yyvsp61 := yyvsp61 - 1
			when 62 then
				yyvsp62 := yyvsp62 - 1
			when 63 then
				yyvsp63 := yyvsp63 - 1
			when 64 then
				yyvsp64 := yyvsp64 - 1
			when 65 then
				yyvsp65 := yyvsp65 - 1
			when 66 then
				yyvsp66 := yyvsp66 - 1
			when 67 then
				yyvsp67 := yyvsp67 - 1
			when 68 then
				yyvsp68 := yyvsp68 - 1
			when 69 then
				yyvsp69 := yyvsp69 - 1
			when 70 then
				yyvsp70 := yyvsp70 - 1
			when 71 then
				yyvsp71 := yyvsp71 - 1
			when 72 then
				yyvsp72 := yyvsp72 - 1
			when 73 then
				yyvsp73 := yyvsp73 - 1
			when 74 then
				yyvsp74 := yyvsp74 - 1
			when 75 then
				yyvsp75 := yyvsp75 - 1
			when 76 then
				yyvsp76 := yyvsp76 - 1
			when 77 then
				yyvsp77 := yyvsp77 - 1
			when 78 then
				yyvsp78 := yyvsp78 - 1
			when 79 then
				yyvsp79 := yyvsp79 - 1
			when 80 then
				yyvsp80 := yyvsp80 - 1
			when 81 then
				yyvsp81 := yyvsp81 - 1
			when 82 then
				yyvsp82 := yyvsp82 - 1
			when 83 then
				yyvsp83 := yyvsp83 - 1
			when 84 then
				yyvsp84 := yyvsp84 - 1
			when 85 then
				yyvsp85 := yyvsp85 - 1
			when 86 then
				yyvsp86 := yyvsp86 - 1
			when 87 then
				yyvsp87 := yyvsp87 - 1
			when 88 then
				yyvsp88 := yyvsp88 - 1
			when 89 then
				yyvsp89 := yyvsp89 - 1
			when 90 then
				yyvsp90 := yyvsp90 - 1
			when 91 then
				yyvsp91 := yyvsp91 - 1
			when 92 then
				yyvsp92 := yyvsp92 - 1
			when 93 then
				yyvsp93 := yyvsp93 - 1
			when 94 then
				yyvsp94 := yyvsp94 - 1
			when 95 then
				yyvsp95 := yyvsp95 - 1
			when 96 then
				yyvsp96 := yyvsp96 - 1
			when 97 then
				yyvsp97 := yyvsp97 - 1
			when 98 then
				yyvsp98 := yyvsp98 - 1
			when 99 then
				yyvsp99 := yyvsp99 - 1
			when 100 then
				yyvsp100 := yyvsp100 - 1
			when 101 then
				yyvsp101 := yyvsp101 - 1
			when 102 then
				yyvsp102 := yyvsp102 - 1
			when 103 then
				yyvsp103 := yyvsp103 - 1
			when 104 then
				yyvsp104 := yyvsp104 - 1
			when 105 then
				yyvsp105 := yyvsp105 - 1
			when 106 then
				yyvsp106 := yyvsp106 - 1
			when 107 then
				yyvsp107 := yyvsp107 - 1
			when 108 then
				yyvsp108 := yyvsp108 - 1
			when 109 then
				yyvsp109 := yyvsp109 - 1
			when 110 then
				yyvsp110 := yyvsp110 - 1
			when 111 then
				yyvsp111 := yyvsp111 - 1
			when 112 then
				yyvsp112 := yyvsp112 - 1
			when 113 then
				yyvsp113 := yyvsp113 - 1
			when 114 then
				yyvsp114 := yyvsp114 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval1: ANY
			yyval41: ET_CLASS
			yyval77: ET_INDEXING_LIST
			yyval78: ET_INDEXING_ITEM
			yyval81: ET_INDEXING_TERM_LIST
			yyval79: ET_INDEXING_TERM
			yyval80: ET_INDEXING_TERM_ITEM
			yyval2: ET_KEYWORD
			yyval75: ET_FORMAL_PARAMETER_LIST
			yyval74: ET_FORMAL_PARAMETER_ITEM
			yyval73: ET_FORMAL_PARAMETER
			yyval48: ET_CONSTRAINT_CREATOR
			yyval49: ET_CONSTRAINT_TYPE
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
			yyval46: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
			yyval95: ET_OBSOLETE
			yyval99: ET_PARENT_LIST
			yyval97: ET_PARENT
			yyval98: ET_PARENT_ITEM
			yyval105: ET_RENAME_LIST
			yyval104: ET_RENAME_ITEM
			yyval60: ET_EXPORT_LIST
			yyval59: ET_EXPORT
			yyval67: ET_FEATURE_EXPORT
			yyval43: ET_CLIENTS
			yyval42: ET_CLASS_NAME_ITEM
			yyval85: ET_KEYWORD_FEATURE_NAME_LIST
			yyval69: ET_FEATURE_NAME_ITEM
			yyval55: ET_CREATOR_LIST
			yyval54: ET_CREATOR
			yyval52: ET_CONVERT_FEATURE_LIST
			yyval51: ET_CONVERT_FEATURE_ITEM
			yyval50: ET_CONVERT_FEATURE
			yyval110: ET_TYPE_LIST
			yyval109: ET_TYPE_ITEM
			yyval66: ET_FEATURE_CLAUSE_LIST
			yyval65: ET_FEATURE_CLAUSE
			yyval103: ET_QUERY
			yyval102: ET_PROCEDURE
			yyval21: ET_SEMICOLON_SYMBOL
			yyval64: ET_EXTERNAL_ALIAS
			yyval32: ET_ASSIGNER
			yyval68: ET_FEATURE_NAME
			yyval63: ET_EXTENDED_FEATURE_NAME
			yyval31: ET_ALIAS_NAME
			yyval72: ET_FORMAL_ARGUMENT_LIST
			yyval70: ET_FORMAL_ARGUMENT
			yyval71: ET_FORMAL_ARGUMENT_ITEM
			yyval89: ET_LOCAL_VARIABLE_LIST
			yyval87: ET_LOCAL_VARIABLE
			yyval88: ET_LOCAL_VARIABLE_ITEM
			yyval101: ET_PRECONDITIONS
			yyval100: ET_POSTCONDITIONS
			yyval84: ET_INVARIANTS
			yyval90: ET_LOOP_INVARIANTS
			yyval111: ET_VARIANT
			yyval44: ET_COMPOUND
			yyval108: ET_TYPE
			yyval12: ET_IDENTIFIER
			yyval26: ET_ACTUAL_PARAMETER_LIST
			yyval25: ET_ACTUAL_PARAMETER_ITEM
			yyval86: ET_LIKE_TYPE
			yyval83: ET_INSTRUCTION
			yyval53: ET_CREATE_EXPRESSION
			yyval76: ET_IF_INSTRUCTION
			yyval58: ET_ELSEIF_PART_LIST
			yyval57: ET_ELSEIF_PART
			yyval82: ET_INSPECT_INSTRUCTION
			yyval113: ET_WHEN_PART_LIST
			yyval112: ET_WHEN_PART
			yyval40: ET_CHOICE_LIST
			yyval39: ET_CHOICE_ITEM
			yyval37: ET_CHOICE
			yyval38: ET_CHOICE_CONSTANT
			yyval56: ET_DEBUG_INSTRUCTION
			yyval93: ET_MANIFEST_STRING_LIST
			yyval92: ET_MANIFEST_STRING_ITEM
			yyval61: ET_EXPRESSION
			yyval36: ET_CALL_EXPRESSION
			yyval106: ET_STATIC_CALL_EXPRESSION
			yyval24: ET_ACTUAL_ARGUMENT_LIST
			yyval62: ET_EXPRESSION_ITEM
			yyval114: ET_WRITABLE
			yyval34: ET_BRACKET_EXPRESSION
			yyval33: ET_BRACKET_ARGUMENT_LIST
			yyval96: ET_PARENTHESIZED_EXPRESSION
			yyval91: ET_MANIFEST_ARRAY
			yyval94: ET_MANIFEST_TUPLE
			yyval107: ET_STRIP_EXPRESSION
			yyval45: ET_CONSTANT
			yyval35: ET_CALL_AGENT
			yyval30: ET_AGENT_TARGET
			yyval29: ET_AGENT_ARGUMENT_OPERAND_LIST
			yyval28: ET_AGENT_ARGUMENT_OPERAND_ITEM
			yyval27: ET_AGENT_ARGUMENT_OPERAND
			yyval15: ET_MANIFEST_STRING
			yyval9: ET_CHARACTER_CONSTANT
			yyval7: ET_BOOLEAN_CONSTANT
			yyval13: ET_INTEGER_CONSTANT
			yyval16: ET_REAL_CONSTANT
		do
			inspect yy_act
when 1 then
--|#line 277 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 277")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp41 := yyvsp41 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 2 then
--|#line 278 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 278")
end

			if yyvs41.item (yyvsp41) /= Void then
				yyvs41.item (yyvsp41).set_leading_break (yyvs8.item (yyvsp8))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp8 := yyvsp8 -1
	yyvsp41 := yyvsp41 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 3 then
--|#line 286 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 286")
end

			yyval41 := yyvs41.item (yyvsp41)
			if yyval41 /= Void then
				yyval41.set_first_indexing (yyvs77.item (yyvsp77))
		--	else
		--		print("Class_to_end = VOID !!! ########################################################%N")
		--		crash
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp77 := yyvsp77 -1
	yyvs41.put (yyval41, yyvsp41)
end
when 4 then
--|#line 298 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 298")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 5 then
--|#line 299 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 299")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp41 := yyvsp41 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 6 then
--|#line 302 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 302")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99), yyvs55.item (yyvsp55), yyvs52.item (yyvsp52), yyvs66.item (yyvsp66), yyvs84.item (yyvsp84), yyvs77.item (yyvsp77), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp55 := yyvsp55 -1
	yyvsp52 := yyvsp52 -1
	yyvsp66 := yyvsp66 -1
	yyvsp84 := yyvsp84 -1
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs41.put (yyval41, yyvsp41)
end
when 7 then
--|#line 308 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 308")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99), yyvs55.item (yyvsp55), yyvs52.item (yyvsp52), yyvs66.item (yyvsp66), yyvs84.item (yyvsp84), yyvs77.item (yyvsp77), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp55 := yyvsp55 -1
	yyvsp52 := yyvsp52 -1
	yyvsp66 := yyvsp66 -1
	yyvsp84 := yyvsp84 -1
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs41.put (yyval41, yyvsp41)
end
when 8 then
--|#line 314 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 314")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99), Void, yyvs52.item (yyvsp52), yyvs66.item (yyvsp66), yyvs84.item (yyvsp84), yyvs77.item (yyvsp77), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 11
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp52 := yyvsp52 -1
	yyvsp66 := yyvsp66 -1
	yyvsp84 := yyvsp84 -1
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs41.put (yyval41, yyvsp41)
end
when 9 then
--|#line 320 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 320")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99), Void, Void, yyvs66.item (yyvsp66), yyvs84.item (yyvsp84), yyvs77.item (yyvsp77), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp66 := yyvsp66 -1
	yyvsp84 := yyvsp84 -1
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs41.put (yyval41, yyvsp41)
end
when 10 then
--|#line 326 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 326")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99), Void, Void, Void, yyvs84.item (yyvsp84), yyvs77.item (yyvsp77), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 9
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp84 := yyvsp84 -1
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs41.put (yyval41, yyvsp41)
end
when 11 then
--|#line 332 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 332")
end

			yyval41 := yyvs41.item (yyvsp41 - 1)
			set_class_to_inheritance_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99))
			if yyvs41.item (yyvsp41) /= Void then
				yyvs41.item (yyvsp41).set_first_indexing (yyvs77.item (yyvsp77))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp41 := yyvsp41 -1
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp77 := yyvsp77 -1
	yyvsp1 := yyvsp1 -1
	yyvs41.put (yyval41, yyvsp41)
end
when 12 then
--|#line 340 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 340")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99), Void, Void, Void, Void, yyvs77.item (yyvsp77), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs41.put (yyval41, yyvsp41)
end
when 13 then
--|#line 345 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 345")
end

			yyval41 := yyvs41.item (yyvsp41)
			set_class_to_inheritance_end (yyval41, yyvs95.item (yyvsp95), yyvs99.item (yyvsp99))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp75 := yyvsp75 -1
	yyvsp95 := yyvsp95 -1
	yyvsp99 := yyvsp99 -1
	yyvsp1 := yyvsp1 -1
	yyvs41.put (yyval41, yyvsp41)
end
when 14 then
--|#line 360 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 360")
end

set_class_providers 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 15 then
--|#line 365 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 365")
end

yyval77 := ast_factory.new_indexings (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp77 := yyvsp77 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 16 then
--|#line 367 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 367")
end

			yyval77 := yyvs77.item (yyvsp77)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp77 := yyvsp77 -1
	yyvsp2 := yyvsp2 -1
	yyvs77.put (yyval77, yyvsp77)
end
when 17 then
--|#line 367 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 367")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 18 then
--|#line 380 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 380")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 19 then
--|#line 382 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 382")
end

yyval77 := yyvs77.item (yyvsp77) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs77.put (yyval77, yyvsp77)
end
when 20 then
--|#line 386 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 386")
end

			if yyvs78.item (yyvsp78) /= Void then
				yyval77 := ast_factory.new_indexings (last_keyword, counter_value + 1)
				if yyval77 /= Void then
					yyval77.put_first (yyvs78.item (yyvsp78))
				end
			else
				yyval77 := ast_factory.new_indexings (last_keyword, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp77 := yyvsp77 + 1
	yyvsp78 := yyvsp78 -1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 21 then
--|#line 397 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 397")
end

			if yyvs78.item (yyvsp78) /= Void then
				yyval77 := ast_factory.new_indexings (last_keyword, counter_value + 1)
				if yyval77 /= Void then
					yyval77.put_first (yyvs78.item (yyvsp78))
				end
			else
				yyval77 := ast_factory.new_indexings (last_keyword, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp77 := yyvsp77 + 1
	yyvsp78 := yyvsp78 -1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 22 then
--|#line 409 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 409")
end

			yyval77 := yyvs77.item (yyvsp77)
			if yyval77 /= Void and yyvs78.item (yyvsp78) /= Void then
				yyval77.put_first (yyvs78.item (yyvsp78))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp77 := yyvsp77 -1
	yyvsp78 := yyvsp78 -1
	yyvs77.put (yyval77, yyvsp77)
end
when 23 then
--|#line 409 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 409")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 24 then
--|#line 418 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 418")
end

			yyval77 := yyvs77.item (yyvsp77)
			if yyval77 /= Void and yyvs78.item (yyvsp78) /= Void then
				yyval77.put_first (yyvs78.item (yyvsp78))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp77 := yyvsp77 -1
	yyvsp78 := yyvsp78 -1
	yyvs77.put (yyval77, yyvsp77)
end
when 25 then
--|#line 418 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 418")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
when 26 then
--|#line 429 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 429")
end

			yyval78 := yyvs78.item (yyvsp78)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs78.put (yyval78, yyvsp78)
end
when 27 then
--|#line 436 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 436")
end

			yyval78 := ast_factory.new_indexing (yyvs81.item (yyvsp81))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp81 := yyvsp81 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
when 28 then
--|#line 440 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 440")
end

			yyval78 := ast_factory.new_tagged_indexing (ast_factory.new_tag (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyvs81.item (yyvsp81))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
when 29 then
--|#line 450 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 450")
end

yyval78 := ast_factory.new_indexing_semicolon (yyvs78.item (yyvsp78), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp21 := yyvsp21 -1
	yyvs78.put (yyval78, yyvsp78)
end
when 30 then
--|#line 452 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 452")
end

yyval78 := ast_factory.new_indexing_semicolon (yyvs78.item (yyvsp78), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp21 := yyvsp21 -1
	yyvs78.put (yyval78, yyvsp78)
end
when 31 then
--|#line 457 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 457")
end

			if yyvs79.item (yyvsp79) /= Void then
				yyval81 := ast_factory.new_indexing_terms (counter_value + 1)
				if yyval81 /= Void then
					yyval81.put_first (yyvs79.item (yyvsp79))
				end
			else
				yyval81 := ast_factory.new_indexing_terms (counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp79 := yyvsp79 -1
	if yyvsp81 >= yyvsc81 then
		if yyvs81 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs81")
			end
			create yyspecial_routines81
			yyvsc81 := yyInitial_yyvs_size
			yyvs81 := yyspecial_routines81.make (yyvsc81)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs81")
			end
			yyvsc81 := yyvsc81 + yyInitial_yyvs_size
			yyvs81 := yyspecial_routines81.resize (yyvs81, yyvsc81)
		end
	end
	yyvs81.put (yyval81, yyvsp81)
end
when 32 then
--|#line 468 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 468")
end

			yyval81 := yyvs81.item (yyvsp81)
			if yyval81 /= Void and yyvs80.item (yyvsp80) /= Void then
				yyval81.put_first (yyvs80.item (yyvsp80))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp80 := yyvsp80 -1
	yyvs81.put (yyval81, yyvsp81)
end
when 33 then
--|#line 477 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 477")
end

yyval79 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 34 then
--|#line 479 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 479")
end

yyval79 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 35 then
--|#line 481 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 481")
end

yyval79 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 36 then
--|#line 483 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 483")
end

yyval79 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 37 then
--|#line 485 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 485")
end

yyval79 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 38 then
--|#line 487 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 487")
end

yyval79 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 39 then
--|#line 489 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 489")
end

yyval79 := yyvs6.item (yyvsp6) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 40 then
--|#line 491 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 491")
end

yyval79 := ast_factory.new_custom_attribute (yyvs53.item (yyvsp53), Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp79 := yyvsp79 + 1
	yyvsp53 := yyvsp53 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 41 then
--|#line 493 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 493")
end

yyval79 := ast_factory.new_custom_attribute (yyvs53.item (yyvsp53), yyvs94.item (yyvsp94), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp79 := yyvsp79 + 1
	yyvsp53 := yyvsp53 -1
	yyvsp94 := yyvsp94 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
when 42 then
--|#line 497 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 497")
end

			yyval80 := ast_factory.new_indexing_term_comma (yyvs79.item (yyvsp79), yyvs4.item (yyvsp4))
			if yyval80 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp80 := yyvsp80 + 1
	yyvsp79 := yyvsp79 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
when 43 then
--|#line 508 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 508")
end

			yyval41 := new_class (yyvs12.item (yyvsp12))
			if yyval41 /= Void then
				yyval41.set_class_keyword (yyvs2.item (yyvsp2))
				yyval41.set_frozen_keyword (yyvs2.item (yyvsp2 - 2))
				yyval41.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval41
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp41 := yyvsp41 + 1
	yyvsp2 := yyvsp2 -3
	yyvsp12 := yyvsp12 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
when 44 then
--|#line 518 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 518")
end

			yyval41 := new_class (yyvs12.item (yyvsp12))
			if yyval41 /= Void then
				yyval41.set_class_keyword (yyvs2.item (yyvsp2))
				yyval41.set_class_mark (yyvs2.item (yyvsp2 - 2))
				yyval41.set_frozen_keyword (yyvs2.item (yyvsp2 - 3))
				yyval41.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval41
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp41 := yyvsp41 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp12 := yyvsp12 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
when 45 then
--|#line 529 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 529")
end

			yyval41 := new_class (yyvs12.item (yyvsp12))
			if yyval41 /= Void then
				yyval41.set_class_keyword (yyvs2.item (yyvsp2))
				yyval41.set_class_mark (yyvs2.item (yyvsp2 - 2))
				yyval41.set_frozen_keyword (yyvs2.item (yyvsp2 - 3))
				yyval41.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval41
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp41 := yyvsp41 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp12 := yyvsp12 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
when 46 then
--|#line 540 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 540")
end

			yyval41 := new_class (yyvs12.item (yyvsp12))
			if yyval41 /= Void then
				yyval41.set_class_keyword (yyvs2.item (yyvsp2))
				yyval41.set_class_mark (yyvs2.item (yyvsp2 - 2))
				yyval41.set_frozen_keyword (yyvs2.item (yyvsp2 - 3))
				yyval41.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval41
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp41 := yyvsp41 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp12 := yyvsp12 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
when 47 then
--|#line 553 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 553")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp2 := yyvsp2 + 1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyvs2.put (yyval2, yyvsp2)
end
when 48 then
--|#line 555 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 555")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 49 then
--|#line 559 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 559")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp2 := yyvsp2 + 1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyvs2.put (yyval2, yyvsp2)
end
when 50 then
--|#line 561 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 561")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 51 then
--|#line 567 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 567")
end

			set_formal_parameters (Void)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp75 := yyvsp75 + 1
	if yyvsp75 >= yyvsc75 then
		if yyvs75 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs75")
			end
			create yyspecial_routines75
			yyvsc75 := yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.make (yyvsc75)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs75")
			end
			yyvsc75 := yyvsc75 + yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.resize (yyvs75, yyvsc75)
		end
	end
	yyvs75.put (yyval75, yyvsp75)
end
when 52 then
--|#line 571 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 571")
end

			yyval75 := ast_factory.new_formal_parameters (yyvs22.item (yyvsp22), yyvs4.item (yyvsp4), 0)
			set_formal_parameters (yyval75)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp75 >= yyvsc75 then
		if yyvs75 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs75")
			end
			create yyspecial_routines75
			yyvsc75 := yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.make (yyvsc75)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs75")
			end
			yyvsc75 := yyvsc75 + yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.resize (yyvs75, yyvsc75)
		end
	end
	yyvs75.put (yyval75, yyvsp75)
end
when 53 then
--|#line 577 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 577")
end

			yyval75 := yyvs75.item (yyvsp75)
			set_formal_parameters (yyval75)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 -1
	yyvsp22 := yyvsp22 -1
	yyvs75.put (yyval75, yyvsp75)
end
when 54 then
--|#line 577 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 577")
end

			add_symbol (yyvs22.item (yyvsp22))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp75 := yyvsp75 + 1
	if yyvsp75 >= yyvsc75 then
		if yyvs75 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs75")
			end
			create yyspecial_routines75
			yyvsc75 := yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.make (yyvsc75)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs75")
			end
			yyvsc75 := yyvsc75 + yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.resize (yyvs75, yyvsc75)
		end
	end
	yyvs75.put (yyval75, yyvsp75)
end
when 55 then
--|#line 591 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 591")
end

			if yyvs73.item (yyvsp73) /= Void then
				yyval75 := ast_factory.new_formal_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval75 /= Void then
					yyval75.put_first (yyvs73.item (yyvsp73))
				end
			else
				yyval75 := ast_factory.new_formal_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp73 := yyvsp73 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp75 >= yyvsc75 then
		if yyvs75 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs75")
			end
			create yyspecial_routines75
			yyvsc75 := yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.make (yyvsc75)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs75")
			end
			yyvsc75 := yyvsc75 + yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.resize (yyvs75, yyvsc75)
		end
	end
	yyvs75.put (yyval75, yyvsp75)
end
when 56 then
--|#line 602 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 602")
end

			yyval75 := yyvs75.item (yyvsp75)
			if yyval75 /= Void and yyvs74.item (yyvsp74) /= Void then
				yyval75.put_first (yyvs74.item (yyvsp74))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp74 := yyvsp74 -1
	yyvs75.put (yyval75, yyvsp75)
end
when 57 then
--|#line 611 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 611")
end

			yyval74 := ast_factory.new_formal_parameter_comma (yyvs73.item (yyvsp73), yyvs4.item (yyvsp4))
			if yyval74 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp74 := yyvsp74 + 1
	yyvsp73 := yyvsp73 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
when 58 then
--|#line 620 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 620")
end

			yyval73 := ast_factory.new_formal_parameter (Void, yyvs12.item (yyvsp12))
			if yyval73 /= Void then
				register_constraint (Void)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp73 := yyvsp73 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 59 then
--|#line 627 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 627")
end

			yyval73 := ast_factory.new_formal_parameter (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12))
			if yyval73 /= Void then
				register_constraint (Void)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 60 then
--|#line 634 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 634")
end

			yyval73 := ast_factory.new_formal_parameter (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12))
			if yyval73 /= Void then
				register_constraint (Void)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 61 then
--|#line 641 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 641")
end

			yyval73 := ast_factory.new_constrained_formal_parameter (Void, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), dummy_constraint (yyvs49.item (yyvsp49)), Void)
			if yyval73 /= Void then
				register_constraint (yyvs49.item (yyvsp49))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp73 := yyvsp73 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 62 then
--|#line 648 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 648")
end

			yyval73 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), dummy_constraint (yyvs49.item (yyvsp49)), Void)
			if yyval73 /= Void then
				register_constraint (yyvs49.item (yyvsp49))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp73 := yyvsp73 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 63 then
--|#line 655 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 655")
end

			yyval73 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), dummy_constraint (yyvs49.item (yyvsp49)), Void)
			if yyval73 /= Void then
				register_constraint (yyvs49.item (yyvsp49))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp73 := yyvsp73 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 64 then
--|#line 662 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 662")
end

			yyval73 := ast_factory.new_constrained_formal_parameter (Void, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), dummy_constraint (yyvs49.item (yyvsp49)), yyvs48.item (yyvsp48))
			if yyval73 /= Void then
				register_constraint (yyvs49.item (yyvsp49))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp73 := yyvsp73 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 65 then
--|#line 669 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 669")
end

			yyval73 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), dummy_constraint (yyvs49.item (yyvsp49)), yyvs48.item (yyvsp48))
			if yyval73 /= Void then
				register_constraint (yyvs49.item (yyvsp49))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp73 := yyvsp73 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 66 then
--|#line 676 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 676")
end

			yyval73 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), dummy_constraint (yyvs49.item (yyvsp49)), yyvs48.item (yyvsp48))
			if yyval73 /= Void then
				register_constraint (yyvs49.item (yyvsp49))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp73 := yyvsp73 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
when 67 then
--|#line 685 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 685")
end

yyval48 := ast_factory.new_constraint_creator (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
when 68 then
--|#line 687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 687")
end

			yyval48 := yyvs48.item (yyvsp48)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp2 := yyvsp2 -1
	yyvs48.put (yyval48, yyvsp48)
end
when 69 then
--|#line 687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 687")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp48 := yyvsp48 + 1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
when 70 then
--|#line 700 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 700")
end

			if yyvs12.item (yyvsp12) /= Void then
				yyval48 := ast_factory.new_constraint_creator (last_keyword, yyvs2.item (yyvsp2), counter_value + 1)
				if yyval48 /= Void then
					yyval48.put_first (yyvs12.item (yyvsp12))
				end
			else
				yyval48 := ast_factory.new_constraint_creator (last_keyword, yyvs2.item (yyvsp2), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
when 71 then
--|#line 711 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 711")
end

			yyval48 := ast_factory.new_constraint_creator (last_keyword, yyvs2.item (yyvsp2), counter_value)
			if yyval48 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval48.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
when 72 then
--|#line 719 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 719")
end

			yyval48 := yyvs48.item (yyvsp48)
			if yyval48 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval48.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 -1
	yyvs48.put (yyval48, yyvsp48)
end
when 73 then
--|#line 728 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 728")
end

yyval49 := new_constraint_named_type (Void, yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 74 then
--|#line 730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 730")
end

yyval49 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 75 then
--|#line 732 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 732")
end

yyval49 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 76 then
--|#line 734 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 734")
end

yyval49 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 77 then
--|#line 736 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 736")
end

yyval49 := yyvs86.item (yyvsp86) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp49 := yyvsp49 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 78 then
--|#line 738 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 738")
end

yyval49 := new_bit_n (yyvs12.item (yyvsp12), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 79 then
--|#line 740 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 740")
end

yyval49 := ast_factory.new_bit_feature (yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))  
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -2
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 80 then
--|#line 742 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 742")
end

yyval49 := new_constraint_named_type (Void, yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 81 then
--|#line 746 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 746")
end

yyval49 := new_constraint_named_type (Void, yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 82 then
--|#line 748 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 748")
end

yyval49 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 83 then
--|#line 750 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 750")
end

yyval49 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 84 then
--|#line 752 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 752")
end

yyval49 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 85 then
--|#line 754 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 754")
end

yyval49 := yyvs86.item (yyvsp86) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp49 := yyvsp49 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 86 then
--|#line 756 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 756")
end

yyval49 := new_bit_n (yyvs12.item (yyvsp12), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 87 then
--|#line 758 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 758")
end

yyval49 := ast_factory.new_bit_feature (yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))  
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -2
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 88 then
--|#line 760 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 760")
end

yyval49 := new_constraint_named_type (Void, yyvs12.item (yyvsp12), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp47 := yyvsp47 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
when 89 then
--|#line 764 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 764")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp47 := yyvsp47 + 1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
when 90 then
--|#line 766 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 766")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
when 91 then
--|#line 770 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 770")
end

yyval47 := ast_factory.new_constraint_actual_parameters (yyvs22.item (yyvsp22), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
when 92 then
--|#line 773 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 773")
end

			yyval47 := yyvs47.item (yyvsp47)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 93 then
--|#line 781 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 781")
end

			if yyvs49.item (yyvsp49) /= Void then
				yyval47 := ast_factory.new_constraint_actual_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval47 /= Void then
					yyval47.put_first (yyvs49.item (yyvsp49))
				end
			else
				yyval47 := ast_factory.new_constraint_actual_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp49 := yyvsp49 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
when 94 then
--|#line 792 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 792")
end

			yyval47 := yyvs47.item (yyvsp47)
			add_to_constraint_actual_parameter_list (yyvs46.item (yyvsp46), yyval47)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 95 then
--|#line 797 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 797")
end

			yyval47 := yyvs47.item (yyvsp47)
			add_to_constraint_actual_parameter_list (ast_factory.new_constraint_actual_parameter_comma (new_constraint_named_type (Void, yyvs12.item (yyvsp12), Void), yyvs4.item (yyvsp4)), yyval47)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 96 then
--|#line 802 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 802")
end

			yyval47 := yyvs47.item (yyvsp47)
			add_to_constraint_actual_parameter_list (ast_factory.new_constraint_actual_parameter_comma (new_constraint_named_type (Void, yyvs12.item (yyvsp12), Void), yyvs4.item (yyvsp4)), yyval47)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 97 then
--|#line 809 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 809")
end

			yyval46 := ast_factory.new_constraint_actual_parameter_comma (yyvs49.item (yyvsp49), yyvs4.item (yyvsp4))
			if yyval46 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 + 1
	yyvsp49 := yyvsp49 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
when 98 then
--|#line 818 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 818")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp47 := yyvsp47 + 1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
when 99 then
--|#line 820 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 820")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
when 100 then
--|#line 824 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 824")
end

yyval47 := ast_factory.new_constraint_actual_parameters (yyvs22.item (yyvsp22), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
when 101 then
--|#line 827 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 827")
end

			yyval47 := yyvs47.item (yyvsp47)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 102 then
--|#line 833 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 833")
end

			yyval47 := yyvs47.item (yyvsp47)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 103 then
--|#line 841 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 841")
end

			yyval47 := ast_factory.new_constraint_actual_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
			add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs49.item (yyvsp49)), yyval47)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp47 := yyvsp47 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp49 := yyvsp49 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
when 104 then
--|#line 846 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 846")
end

			yyval47 := yyvs47.item (yyvsp47)
			add_to_constraint_actual_parameter_list (yyvs46.item (yyvsp46), yyvs47.item (yyvsp47))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 105 then
--|#line 851 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 851")
end

			yyval47 := yyvs47.item (yyvsp47)
			add_to_constraint_actual_parameter_list (yyvs46.item (yyvsp46), yyvs47.item (yyvsp47))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 106 then
--|#line 856 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 856")
end

			yyval47 := yyvs47.item (yyvsp47)
			if yyval47 /= Void then
				if not yyval47.is_empty then
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyval47.first.type), yyval47)
				else
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), Void), yyval47)
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 107 then
--|#line 867 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 867")
end

			yyval47 := yyvs47.item (yyvsp47)
			if yyval47 /= Void then
				if not yyval47.is_empty then
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyval47.first.type), yyval47)
				else
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), Void), yyval47)
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 108 then
--|#line 878 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 878")
end

			yyval47 := yyvs47.item (yyvsp47)
			if yyval47 /= Void then
				if not yyval47.is_empty then
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyval47.first.type), yyval47)
				else
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), Void), yyval47)
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs47.put (yyval47, yyvsp47)
end
when 109 then
--|#line 891 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 891")
end

			yyval46 := ast_factory.new_constraint_labeled_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyvs49.item (yyvsp49))
			if yyval46 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
when 110 then
--|#line 900 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 900")
end

			yyval46 := ast_factory.new_constraint_labeled_actual_parameter_semicolon (ast_factory.new_constraint_labeled_actual_parameter (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyvs49.item (yyvsp49)), yyvs21.item (yyvsp21))
			if yyval46 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp49 := yyvsp49 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
when 111 then
--|#line 910 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 910")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp95 := yyvsp95 + 1
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
when 112 then
--|#line 912 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 912")
end

yyval95 := ast_factory.new_obsolete_message (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp95 := yyvsp95 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
when 113 then
--|#line 914 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 914")
end

yyval95 := ast_factory.new_obsolete_message (yyvs2.item (yyvsp2 - 1), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp95 := yyvsp95 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp15 := yyvsp15 -1
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
when 114 then
--|#line 924 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 924")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp99 := yyvsp99 + 1
	if yyvsp99 >= yyvsc99 then
		if yyvs99 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs99")
			end
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs99")
			end
			yyvsc99 := yyvsc99 + yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.resize (yyvs99, yyvsc99)
		end
	end
	yyvs99.put (yyval99, yyvsp99)
end
when 115 then
--|#line 926 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 926")
end

-- OK
			yyval99 := ast_factory.new_parents (yyvs2.item (yyvsp2), 0)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp99 := yyvsp99 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp99 >= yyvsc99 then
		if yyvs99 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs99")
			end
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs99")
			end
			yyvsc99 := yyvsc99 + yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.resize (yyvs99, yyvsc99)
		end
	end
	yyvs99.put (yyval99, yyvsp99)
end
when 116 then
--|#line 930 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 930")
end

-- OK
			yyval99 := yyvs99.item (yyvsp99)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 117 then
--|#line 935 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 935")
end

			yyval99 := yyvs99.item (yyvsp99)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 118 then
--|#line 942 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 942")
end

			yyval99 := yyvs99.item (yyvsp99)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 119 then
--|#line 948 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 948")
end

			yyval99 := yyvs99.item (yyvsp99)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 120 then
--|#line 956 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 956")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
			set_inherit_non_conforming(False)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 121 then
--|#line 962 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 962")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
			set_inherit_non_conforming(True)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 122 then
--|#line 968 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 968")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
			set_inherit_non_conforming(True)
			-- Check for Identifier == 'NONE' ???
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp12 := yyvsp12 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 123 then
--|#line 975 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 975")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
			set_inherit_non_conforming(True)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 124 then
--|#line 983 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 983")
end

yyval2 := yyvs2.item (yyvsp2); set_inherit_non_conforming(False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 125 then
--|#line 985 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 985")
end

yyval2 := yyvs2.item (yyvsp2); set_inherit_non_conforming(True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyvs2.put (yyval2, yyvsp2)
end
when 126 then
--|#line 987 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 987")
end

yyval2 := yyvs2.item (yyvsp2); set_inherit_non_conforming(True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -2
	yyvsp12 := yyvsp12 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 127 then
--|#line 989 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 989")
end

yyval2 := yyvs2.item (yyvsp2); set_inherit_non_conforming(True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 128 then
--|#line 993 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 993")
end

yyval99 := yyvs99.item (yyvsp99) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 129 then
--|#line 995 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 995")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 130 then
--|#line 1002 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1002")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 131 then
--|#line 1009 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1009")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs98.item (yyvsp98) /= Void then
				yyval99.put_first (yyvs98.item (yyvsp98))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 132 then
--|#line 1018 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1018")
end

yyval99 := yyvs99.item (yyvsp99) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 133 then
--|#line 1020 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1020")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 134 then
--|#line 1027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1027")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 135 then
--|#line 1034 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1034")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs98.item (yyvsp98) /= Void then
				yyval99.put_first (yyvs98.item (yyvsp98))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 136 then
--|#line 1043 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1043")
end

			yyval99 := ast_factory.new_parents (last_keyword, counter_value)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp99 := yyvsp99 + 1
	yyvsp97 := yyvsp97 -1
	if yyvsp99 >= yyvsc99 then
		if yyvs99 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs99")
			end
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs99")
			end
			yyvsc99 := yyvsc99 + yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.resize (yyvs99, yyvsc99)
		end
	end
	yyvs99.put (yyval99, yyvsp99)
end
when 137 then
--|#line 1050 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1050")
end

			yyval99 := ast_factory.new_parents (last_keyword, counter_value)
			if yyval99 /= Void and yyvs98.item (yyvsp98) /= Void then
				yyval99.put_first (yyvs98.item (yyvsp98))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp99 := yyvsp99 + 1
	yyvsp98 := yyvsp98 -1
	if yyvsp99 >= yyvsc99 then
		if yyvs99 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs99")
			end
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs99")
			end
			yyvsc99 := yyvsc99 + yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.resize (yyvs99, yyvsc99)
		end
	end
	yyvs99.put (yyval99, yyvsp99)
end
when 138 then
--|#line 1057 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1057")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 139 then
--|#line 1064 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1064")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 140 then
--|#line 1071 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1071")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs98.item (yyvsp98) /= Void then
				yyval99.put_first (yyvs98.item (yyvsp98))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 141 then
--|#line 1080 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1080")
end

			yyval99 := ast_factory.new_parents (last_keyword, counter_value)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp99 := yyvsp99 + 1
	yyvsp97 := yyvsp97 -1
	if yyvsp99 >= yyvsc99 then
		if yyvs99 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs99")
			end
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs99")
			end
			yyvsc99 := yyvsc99 + yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.resize (yyvs99, yyvsc99)
		end
	end
	yyvs99.put (yyval99, yyvsp99)
end
when 142 then
--|#line 1087 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1087")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 143 then
--|#line 1094 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1094")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs97.item (yyvsp97) /= Void then
				yyval99.put_first (yyvs97.item (yyvsp97))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 144 then
--|#line 1101 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1101")
end

			yyval99 := yyvs99.item (yyvsp99)
			if yyval99 /= Void and yyvs98.item (yyvsp98) /= Void then
				yyval99.put_first (yyvs98.item (yyvsp98))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 -1
	yyvs99.put (yyval99, yyvsp99)
end
when 145 then
--|#line 1112 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1112")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), Void, Void, Void, Void, Void, Void)
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 146 then
--|#line 1119 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1119")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), yyvs105.item (yyvsp105), yyvs60.item (yyvsp60), yyvs85.item (yyvsp85 - 2), yyvs85.item (yyvsp85 - 1), yyvs85.item (yyvsp85), yyvs2.item (yyvsp2))
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	yyvsp105 := yyvsp105 -1
	yyvsp60 := yyvsp60 -1
	yyvsp85 := yyvsp85 -3
	yyvsp2 := yyvsp2 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 147 then
--|#line 1127 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1127")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), Void, yyvs60.item (yyvsp60), yyvs85.item (yyvsp85 - 2), yyvs85.item (yyvsp85 - 1), yyvs85.item (yyvsp85), yyvs2.item (yyvsp2))
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	yyvsp60 := yyvsp60 -1
	yyvsp85 := yyvsp85 -3
	yyvsp2 := yyvsp2 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 148 then
--|#line 1134 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1134")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), Void, Void, yyvs85.item (yyvsp85 - 2), yyvs85.item (yyvsp85 - 1), yyvs85.item (yyvsp85), yyvs2.item (yyvsp2))
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	yyvsp85 := yyvsp85 -3
	yyvsp2 := yyvsp2 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 149 then
--|#line 1141 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1141")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), Void, Void, Void, yyvs85.item (yyvsp85 - 1), yyvs85.item (yyvsp85), yyvs2.item (yyvsp2))
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	yyvsp85 := yyvsp85 -2
	yyvsp2 := yyvsp2 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 150 then
--|#line 1148 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1148")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), Void, Void, Void, Void, yyvs85.item (yyvsp85), yyvs2.item (yyvsp2))
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	yyvsp85 := yyvsp85 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 151 then
--|#line 1157 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1157")
end

			yyval97 := new_parent (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26), Void, Void, Void, Void, Void, yyvs2.item (yyvsp2))
			if yyval97 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp97 := yyvsp97 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
when 152 then
--|#line 1166 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1166")
end

			yyval98 := ast_factory.new_parent_semicolon (yyvs97.item (yyvsp97), yyvs21.item (yyvsp21))
			if yyval98 /= Void and yyvs97.item (yyvsp97) = Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 + 1
	yyvsp97 := yyvsp97 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp98 >= yyvsc98 then
		if yyvs98 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs98")
			end
			create yyspecial_routines98
			yyvsc98 := yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.make (yyvsc98)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs98")
			end
			yyvsc98 := yyvsc98 + yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.resize (yyvs98, yyvsc98)
		end
	end
	yyvs98.put (yyval98, yyvsp98)
end
when 153 then
--|#line 1173 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1173")
end

			yyval98 := ast_factory.new_parent_semicolon (yyvs97.item (yyvsp97), yyvs21.item (yyvsp21))
			if yyval98 /= Void and yyvs97.item (yyvsp97) = Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 + 1
	yyvsp97 := yyvsp97 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp98 >= yyvsc98 then
		if yyvs98 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs98")
			end
			create yyspecial_routines98
			yyvsc98 := yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.make (yyvsc98)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs98")
			end
			yyvsc98 := yyvsc98 + yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.resize (yyvs98, yyvsc98)
		end
	end
	yyvs98.put (yyval98, yyvsp98)
end
when 154 then
--|#line 1184 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1184")
end

yyval105 := ast_factory.new_renames (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
when 155 then
--|#line 1186 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1186")
end

			yyval105 := yyvs105.item (yyvsp105)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp105 := yyvsp105 -1
	yyvsp2 := yyvsp2 -1
	yyvs105.put (yyval105, yyvsp105)
end
when 156 then
--|#line 1186 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1186")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp105 := yyvsp105 + 1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
when 157 then
--|#line 1199 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1199")
end

			yyval105 := ast_factory.new_renames (last_keyword, counter_value)
			if yyval105 /= Void and yyvs104.item (yyvsp104) /= Void then
				yyval105.put_first (yyvs104.item (yyvsp104))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp104 := yyvsp104 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
when 158 then
--|#line 1206 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1206")
end

			yyval105 := ast_factory.new_renames (last_keyword, counter_value)
			if yyval105 /= Void and yyvs104.item (yyvsp104) /= Void then
				yyval105.put_first (yyvs104.item (yyvsp104))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp104 := yyvsp104 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
when 159 then
--|#line 1214 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1214")
end

			yyval105 := yyvs105.item (yyvsp105)
			if yyval105 /= Void and yyvs104.item (yyvsp104) /= Void then
				yyval105.put_first (yyvs104.item (yyvsp104))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp104 := yyvsp104 -1
	yyvs105.put (yyval105, yyvsp105)
end
when 160 then
--|#line 1223 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1223")
end

			yyval104 := ast_factory.new_rename (yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs63.item (yyvsp63))
			if yyval104 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp104 := yyvsp104 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp63 := yyvsp63 -1
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
when 161 then
--|#line 1232 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1232")
end

			yyval104 := ast_factory.new_rename_comma (yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs63.item (yyvsp63), yyvs4.item (yyvsp4))
			if yyval104 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp104 := yyvsp104 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
when 162 then
--|#line 1243 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1243")
end

yyval60 := ast_factory.new_exports (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
when 163 then
--|#line 1245 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1245")
end

			yyval60 := yyvs60.item (yyvsp60)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 -1
	yyvsp2 := yyvsp2 -1
	yyvs60.put (yyval60, yyvsp60)
end
when 164 then
--|#line 1245 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1245")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp60 := yyvsp60 + 1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
when 165 then
--|#line 1258 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1258")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp60 := yyvsp60 + 1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
when 166 then
--|#line 1260 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1260")
end

yyval60 := yyvs60.item (yyvsp60) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs60.put (yyval60, yyvsp60)
end
when 167 then
--|#line 1264 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1264")
end

			if yyvs59.item (yyvsp59) /= Void then
				yyval60 := ast_factory.new_exports (last_keyword, counter_value + 1)
				if yyval60 /= Void then
					yyval60.put_first (yyvs59.item (yyvsp59))
				end
			else
				yyval60 := ast_factory.new_exports (last_keyword, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp59 := yyvsp59 -1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
when 168 then
--|#line 1275 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1275")
end

			yyval60 := yyvs60.item (yyvsp60)
			if yyval60 /= Void and yyvs59.item (yyvsp59) /= Void then
				yyval60.put_first (yyvs59.item (yyvsp59))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 -1
	yyvsp59 := yyvsp59 -1
	yyvs60.put (yyval60, yyvsp60)
end
when 169 then
--|#line 1275 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1275")
end

			if yyvs59.item (yyvsp59) /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp60 := yyvsp60 + 1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
when 170 then
--|#line 1290 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1290")
end

			yyval59 := ast_factory.new_all_export (yyvs43.item (yyvsp43), yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp59 := yyvsp59 + 1
	yyvsp43 := yyvsp43 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp59 >= yyvsc59 then
		if yyvs59 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs59")
			end
			create yyspecial_routines59
			yyvsc59 := yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.make (yyvsc59)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs59")
			end
			yyvsc59 := yyvsc59 + yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.resize (yyvs59, yyvsc59)
		end
	end
	yyvs59.put (yyval59, yyvsp59)
end
when 171 then
--|#line 1294 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1294")
end

			last_export_clients := yyvs43.item (yyvsp43)
			yyval59 := ast_factory.new_feature_export (last_export_clients, 0)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp43 := yyvsp43 -1
	if yyvsp59 >= yyvsc59 then
		if yyvs59 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs59")
			end
			create yyspecial_routines59
			yyvsc59 := yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.make (yyvsc59)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs59")
			end
			yyvsc59 := yyvsc59 + yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.resize (yyvs59, yyvsc59)
		end
	end
	yyvs59.put (yyval59, yyvsp59)
end
when 172 then
--|#line 1299 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1299")
end

			yyval59 := yyvs67.item (yyvsp67)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp43 := yyvsp43 -1
	yyvsp67 := yyvsp67 -1
	yyvs59.put (yyval59, yyvsp59)
end
when 173 then
--|#line 1299 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1299")
end

			last_export_clients := yyvs43.item (yyvsp43)
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp59 := yyvsp59 + 1
	if yyvsp59 >= yyvsc59 then
		if yyvs59 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs59")
			end
			create yyspecial_routines59
			yyvsc59 := yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.make (yyvsc59)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs59")
			end
			yyvsc59 := yyvsc59 + yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.resize (yyvs59, yyvsc59)
		end
	end
	yyvs59.put (yyval59, yyvsp59)
end
when 174 then
--|#line 1309 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1309")
end

yyval59 := ast_factory.new_null_export (yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp21 := yyvsp21 -1
	if yyvsp59 >= yyvsc59 then
		if yyvs59 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs59")
			end
			create yyspecial_routines59
			yyvsc59 := yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.make (yyvsc59)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs59")
			end
			yyvsc59 := yyvsc59 + yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.resize (yyvs59, yyvsc59)
		end
	end
	yyvs59.put (yyval59, yyvsp59)
end
when 175 then
--|#line 1313 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1313")
end

			if yyvs68.item (yyvsp68) /= Void then
				yyval67 := ast_factory.new_feature_export (last_export_clients, counter_value + 1)
				if yyval67 /= Void then
					yyval67.put_first (yyvs68.item (yyvsp68))
				end
			else
				yyval67 := ast_factory.new_feature_export (last_export_clients, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp67 := yyvsp67 + 1
	yyvsp68 := yyvsp68 -1
	if yyvsp67 >= yyvsc67 then
		if yyvs67 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs67")
			end
			create yyspecial_routines67
			yyvsc67 := yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.make (yyvsc67)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs67")
			end
			yyvsc67 := yyvsc67 + yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.resize (yyvs67, yyvsc67)
		end
	end
	yyvs67.put (yyval67, yyvsp67)
end
when 176 then
--|#line 1324 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1324")
end

			yyval67 := ast_factory.new_feature_export (last_export_clients, counter_value)
			if yyval67 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval67.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp67 := yyvsp67 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp67 >= yyvsc67 then
		if yyvs67 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs67")
			end
			create yyspecial_routines67
			yyvsc67 := yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.make (yyvsc67)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs67")
			end
			yyvsc67 := yyvsc67 + yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.resize (yyvs67, yyvsc67)
		end
	end
	yyvs67.put (yyval67, yyvsp67)
end
when 177 then
--|#line 1332 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1332")
end

			yyval67 := yyvs67.item (yyvsp67)
			if yyval67 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval67.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 -1
	yyvs67.put (yyval67, yyvsp67)
end
when 178 then
--|#line 1343 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1343")
end

			yyval43 := yyvs43.item (yyvsp43)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp43 := yyvsp43 -1
	yyvsp4 := yyvsp4 -1
	yyvs43.put (yyval43, yyvsp43)
end
when 179 then
--|#line 1343 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1343")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp43 := yyvsp43 + 1
	if yyvsp43 >= yyvsc43 then
		if yyvs43 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs43")
			end
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs43")
			end
			yyvsc43 := yyvsc43 + yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.resize (yyvs43, yyvsc43)
		end
	end
	yyvs43.put (yyval43, yyvsp43)
end
when 180 then
--|#line 1354 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1354")
end

yyval43 := ast_factory.new_none_clients (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp43 := yyvsp43 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp43 >= yyvsc43 then
		if yyvs43 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs43")
			end
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs43")
			end
			yyvsc43 := yyvsc43 + yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.resize (yyvs43, yyvsc43)
		end
	end
	yyvs43.put (yyval43, yyvsp43)
end
when 181 then
--|#line 1358 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1358")
end

			yyval43 := ast_factory.new_clients (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval43 /= Void and yyvs42.item (yyvsp42) /= Void then
				yyval43.put_first (yyvs42.item (yyvsp42))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp43 := yyvsp43 + 1
	yyvsp42 := yyvsp42 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp43 >= yyvsc43 then
		if yyvs43 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs43")
			end
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs43")
			end
			yyvsc43 := yyvsc43 + yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.resize (yyvs43, yyvsc43)
		end
	end
	yyvs43.put (yyval43, yyvsp43)
end
when 182 then
--|#line 1365 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1365")
end

			yyval43 := ast_factory.new_clients (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval43 /= Void and yyvs42.item (yyvsp42) /= Void then
				yyval43.put_first (yyvs42.item (yyvsp42))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp43 := yyvsp43 + 1
	yyvsp42 := yyvsp42 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp43 >= yyvsc43 then
		if yyvs43 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs43")
			end
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs43")
			end
			yyvsc43 := yyvsc43 + yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.resize (yyvs43, yyvsc43)
		end
	end
	yyvs43.put (yyval43, yyvsp43)
end
when 183 then
--|#line 1373 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1373")
end

			yyval43 := yyvs43.item (yyvsp43)
			if yyval43 /= Void and yyvs42.item (yyvsp42) /= Void then
				yyval43.put_first (yyvs42.item (yyvsp42))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp42 := yyvsp42 -1
	yyvs43.put (yyval43, yyvsp43)
end
when 184 then
--|#line 1380 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1380")
end

			yyval43 := yyvs43.item (yyvsp43)
			if yyval43 /= Void and yyvs42.item (yyvsp42) /= Void then
				yyval43.put_first (yyvs42.item (yyvsp42))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp42 := yyvsp42 -1
	yyvs43.put (yyval43, yyvsp43)
end
when 185 then
--|#line 1390 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1390")
end

			yyval42 := yyvs12.item (yyvsp12)
			if yyval42 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp42 := yyvsp42 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
when 186 then
--|#line 1399 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1399")
end

			yyval42 := ast_factory.new_class_name_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
			if yyval42 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp42 := yyvsp42 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
when 187 then
--|#line 1410 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1410")
end

yyval85 := ast_factory.new_keyword_feature_name_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 188 then
--|#line 1412 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1412")
end

			yyval85 := yyvs85.item (yyvsp85)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 -1
	yyvsp2 := yyvsp2 -1
	yyvs85.put (yyval85, yyvsp85)
end
when 189 then
--|#line 1412 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1412")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 190 then
--|#line 1425 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1425")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 191 then
--|#line 1427 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1427")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
when 192 then
--|#line 1431 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1431")
end

yyval85 := ast_factory.new_keyword_feature_name_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 193 then
--|#line 1433 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1433")
end

			yyval85 := yyvs85.item (yyvsp85)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 -1
	yyvsp2 := yyvsp2 -1
	yyvs85.put (yyval85, yyvsp85)
end
when 194 then
--|#line 1433 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1433")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 195 then
--|#line 1446 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1446")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 196 then
--|#line 1448 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1448")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
when 197 then
--|#line 1452 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1452")
end

yyval85 := ast_factory.new_keyword_feature_name_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 198 then
--|#line 1454 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1454")
end

			yyval85 := yyvs85.item (yyvsp85)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 -1
	yyvsp2 := yyvsp2 -1
	yyvs85.put (yyval85, yyvsp85)
end
when 199 then
--|#line 1454 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1454")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 200 then
--|#line 1467 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1467")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 201 then
--|#line 1469 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1469")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
when 202 then
--|#line 1473 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1473")
end

			if yyvs68.item (yyvsp68) /= Void then
				yyval85 := ast_factory.new_keyword_feature_name_list (last_keyword, counter_value + 1)
				if yyval85 /= Void then
					yyval85.put_first (yyvs68.item (yyvsp68))
				end
			else
				yyval85 := ast_factory.new_keyword_feature_name_list (last_keyword, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp68 := yyvsp68 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 203 then
--|#line 1484 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1484")
end

			yyval85 := ast_factory.new_keyword_feature_name_list (last_keyword, counter_value)
			if yyval85 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval85.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
when 204 then
--|#line 1492 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1492")
end

			yyval85 := yyvs85.item (yyvsp85)
			if yyval85 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval85.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 -1
	yyvs85.put (yyval85, yyvsp85)
end
when 205 then
--|#line 1501 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1501")
end

			yyval69 := ast_factory.new_feature_name_comma (yyvs68.item (yyvsp68), yyvs4.item (yyvsp4))
			if yyval69 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
when 206 then
--|#line 1512 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1512")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
when 207 then
--|#line 1514 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1514")
end

			yyval55 := yyvs55.item (yyvsp55)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs55.put (yyval55, yyvsp55)
end
when 208 then
--|#line 1521 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1521")
end

			yyval55 := yyvs55.item (yyvsp55)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs55.put (yyval55, yyvsp55)
end
when 209 then
--|#line 1528 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1528")
end

			if yyvs54.item (yyvsp54) /= Void then
				yyval55 := ast_factory.new_creators (counter_value + 1)
				if yyval55 /= Void then
					yyval55.put_first (yyvs54.item (yyvsp54))
				end
			else
				yyval55 := ast_factory.new_creators (counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp55 := yyvsp55 + 1
	yyvsp54 := yyvsp54 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
when 210 then
--|#line 1539 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1539")
end

			yyval55 := yyvs55.item (yyvsp55)
			if yyval55 /= Void and yyvs54.item (yyvsp54) /= Void then
				yyval55.put_first (yyvs54.item (yyvsp54))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp55 := yyvsp55 -1
	yyvsp54 := yyvsp54 -1
	yyvs55.put (yyval55, yyvsp55)
end
when 211 then
--|#line 1539 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1539")
end

			if yyvs54.item (yyvsp54) /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
when 212 then
--|#line 1554 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1554")
end

yyval54 := ast_factory.new_creator (yyvs2.item (yyvsp2), yyvs43.item (yyvsp43), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp43 := yyvsp43 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 213 then
--|#line 1556 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1556")
end

yyval54 := ast_factory.new_creator (yyvs2.item (yyvsp2), ast_factory.new_any_clients (yyvs2.item (yyvsp2)), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 214 then
--|#line 1558 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1558")
end

			yyval54 := yyvs54.item (yyvsp54)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp54 := yyvsp54 -1
	yyvsp2 := yyvsp2 -1
	yyvsp43 := yyvsp43 -1
	yyvs54.put (yyval54, yyvsp54)
end
when 215 then
--|#line 1558 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1558")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := yyvs43.item (yyvsp43)
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp54 := yyvsp54 + 1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 216 then
--|#line 1570 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1570")
end

			yyval54 := yyvs54.item (yyvsp54)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp54 := yyvsp54 -1
	yyvsp2 := yyvsp2 -1
	yyvs54.put (yyval54, yyvsp54)
end
when 217 then
--|#line 1570 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1570")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := ast_factory.new_any_clients (last_keyword)
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp54 := yyvsp54 + 1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 218 then
--|#line 1582 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1582")
end

yyval54 := ast_factory.new_creator (yyvs2.item (yyvsp2), yyvs43.item (yyvsp43), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp43 := yyvsp43 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 219 then
--|#line 1584 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1584")
end

yyval54 := ast_factory.new_creator (yyvs2.item (yyvsp2), ast_factory.new_any_clients (yyvs2.item (yyvsp2)), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 220 then
--|#line 1586 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1586")
end

			yyval54 := yyvs54.item (yyvsp54)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp54 := yyvsp54 -1
	yyvsp2 := yyvsp2 -1
	yyvsp43 := yyvsp43 -1
	yyvs54.put (yyval54, yyvsp54)
end
when 221 then
--|#line 1586 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1586")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := yyvs43.item (yyvsp43)
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp54 := yyvsp54 + 1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 222 then
--|#line 1598 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1598")
end

			yyval54 := yyvs54.item (yyvsp54)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp54 := yyvsp54 -1
	yyvsp2 := yyvsp2 -1
	yyvs54.put (yyval54, yyvsp54)
end
when 223 then
--|#line 1598 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1598")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := ast_factory.new_any_clients (last_keyword)
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp54 := yyvsp54 + 1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 224 then
--|#line 1612 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1612")
end

			if yyvs12.item (yyvsp12) /= Void then
				yyval54 := ast_factory.new_creator (last_keyword, last_clients, counter_value + 1)
				if yyval54 /= Void then
					yyval54.put_first (yyvs12.item (yyvsp12))
				end
			else
				yyval54 := ast_factory.new_creator (last_keyword, last_clients, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 225 then
--|#line 1623 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1623")
end

			yyval54 := ast_factory.new_creator (last_keyword, last_clients, counter_value)
			if yyval54 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval54.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
when 226 then
--|#line 1631 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1631")
end

			yyval54 := yyvs54.item (yyvsp54)
			if yyval54 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval54.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 -1
	yyvs54.put (yyval54, yyvsp54)
end
when 227 then
--|#line 1640 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1640")
end

			yyval69 := ast_factory.new_feature_name_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
			if yyval69 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
when 228 then
--|#line 1651 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1651")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp52 := yyvsp52 + 1
	if yyvsp52 >= yyvsc52 then
		if yyvs52 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs52")
			end
			create yyspecial_routines52
			yyvsc52 := yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.make (yyvsc52)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs52")
			end
			yyvsc52 := yyvsc52 + yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.resize (yyvs52, yyvsc52)
		end
	end
	yyvs52.put (yyval52, yyvsp52)
end
when 229 then
--|#line 1653 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1653")
end

yyval52 := yyvs52.item (yyvsp52) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs52.put (yyval52, yyvsp52)
end
when 230 then
--|#line 1657 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1657")
end

			yyval52 := yyvs52.item (yyvsp52)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 -1
	yyvsp2 := yyvsp2 -1
	yyvs52.put (yyval52, yyvsp52)
end
when 231 then
--|#line 1657 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1657")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp52 := yyvsp52 + 1
	if yyvsp52 >= yyvsc52 then
		if yyvs52 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs52")
			end
			create yyspecial_routines52
			yyvsc52 := yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.make (yyvsc52)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs52")
			end
			yyvsc52 := yyvsc52 + yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.resize (yyvs52, yyvsc52)
		end
	end
	yyvs52.put (yyval52, yyvsp52)
end
when 232 then
--|#line 1670 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1670")
end

			yyval52 := ast_factory.new_convert_features (last_keyword, counter_value + 1)
			if yyval52 /= Void and yyvs50.item (yyvsp50) /= Void then
				yyval52.put_first (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp52 := yyvsp52 + 1
	yyvsp50 := yyvsp50 -1
	if yyvsp52 >= yyvsc52 then
		if yyvs52 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs52")
			end
			create yyspecial_routines52
			yyvsc52 := yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.make (yyvsc52)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs52")
			end
			yyvsc52 := yyvsc52 + yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.resize (yyvs52, yyvsc52)
		end
	end
	yyvs52.put (yyval52, yyvsp52)
end
when 233 then
--|#line 1677 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1677")
end

			yyval52 := ast_factory.new_convert_features (last_keyword, counter_value)
			if yyval52 /= Void and yyvs51.item (yyvsp51) /= Void then
				yyval52.put_first (yyvs51.item (yyvsp51))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp52 := yyvsp52 + 1
	yyvsp51 := yyvsp51 -1
	if yyvsp52 >= yyvsc52 then
		if yyvs52 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs52")
			end
			create yyspecial_routines52
			yyvsc52 := yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.make (yyvsc52)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs52")
			end
			yyvsc52 := yyvsc52 + yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.resize (yyvs52, yyvsc52)
		end
	end
	yyvs52.put (yyval52, yyvsp52)
end
when 234 then
--|#line 1684 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1684")
end

			yyval52 := yyvs52.item (yyvsp52)
			if yyval52 /= Void and yyvs51.item (yyvsp51) /= Void then
				yyval52.put_first (yyvs51.item (yyvsp51))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp51 := yyvsp51 -1
	yyvs52.put (yyval52, yyvsp52)
end
when 235 then
--|#line 1693 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1693")
end

			yyval51 := ast_factory.new_convert_feature_comma (yyvs50.item (yyvsp50), yyvs4.item (yyvsp4))
			if yyval51 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp51 := yyvsp51 + 1
	yyvsp50 := yyvsp50 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp51 >= yyvsc51 then
		if yyvs51 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs51")
			end
			create yyspecial_routines51
			yyvsc51 := yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.make (yyvsc51)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs51")
			end
			yyvsc51 := yyvsc51 + yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.resize (yyvs51, yyvsc51)
		end
	end
	yyvs51.put (yyval51, yyvsp51)
end
when 236 then
--|#line 1702 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1702")
end

			yyval50 := ast_factory.new_convert_function (yyvs68.item (yyvsp68), yyvs4.item (yyvsp4), yyvs110.item (yyvsp110))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp4 := yyvsp4 -1
	yyvsp110 := yyvsp110 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
when 237 then
--|#line 1706 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1706")
end

			yyval50 := ast_factory.new_convert_procedure (yyvs68.item (yyvsp68), yyvs4.item (yyvsp4 - 1), yyvs110.item (yyvsp110), yyvs4.item (yyvsp4))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp50 := yyvsp50 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp4 := yyvsp4 -2
	yyvsp110 := yyvsp110 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
when 238 then
--|#line 1712 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1712")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp110 := yyvsp110 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp110 >= yyvsc110 then
		if yyvs110 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs110")
			end
			create yyspecial_routines110
			yyvsc110 := yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.make (yyvsc110)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs110")
			end
			yyvsc110 := yyvsc110 + yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.resize (yyvs110, yyvsc110)
		end
	end
	yyvs110.put (yyval110, yyvsp110)
end
when 239 then
--|#line 1714 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1714")
end

			yyval110 := yyvs110.item (yyvsp110)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp110 := yyvsp110 -1
	yyvsp4 := yyvsp4 -1
	yyvs110.put (yyval110, yyvsp110)
end
when 240 then
--|#line 1714 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1714")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp110 := yyvsp110 + 1
	if yyvsp110 >= yyvsc110 then
		if yyvs110 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs110")
			end
			create yyspecial_routines110
			yyvsc110 := yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.make (yyvsc110)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs110")
			end
			yyvsc110 := yyvsc110 + yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.resize (yyvs110, yyvsc110)
		end
	end
	yyvs110.put (yyval110, yyvsp110)
end
when 241 then
--|#line 1727 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1727")
end

			if yyvs108.item (yyvsp108) /= Void then
				yyval110 := ast_factory.new_convert_types (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval110 /= Void then
					yyval110.put_first (yyvs108.item (yyvsp108))
				end
			else
				yyval110 := ast_factory.new_convert_types (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp110 := yyvsp110 + 1
	yyvsp108 := yyvsp108 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp110 >= yyvsc110 then
		if yyvs110 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs110")
			end
			create yyspecial_routines110
			yyvsc110 := yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.make (yyvsc110)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs110")
			end
			yyvsc110 := yyvsc110 + yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.resize (yyvs110, yyvsc110)
		end
	end
	yyvs110.put (yyval110, yyvsp110)
end
when 242 then
--|#line 1738 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1738")
end

			yyval110 := yyvs110.item (yyvsp110)
			if yyval110 /= Void and yyvs109.item (yyvsp109) /= Void then
				yyval110.put_first (yyvs109.item (yyvsp109))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp109 := yyvsp109 -1
	yyvs110.put (yyval110, yyvsp110)
end
when 243 then
--|#line 1747 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1747")
end

			yyval109 := ast_factory.new_type_comma (yyvs108.item (yyvsp108), yyvs4.item (yyvsp4))
			if yyval109 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp109 := yyvsp109 + 1
	yyvsp108 := yyvsp108 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp109 >= yyvsc109 then
		if yyvs109 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs109")
			end
			create yyspecial_routines109
			yyvsc109 := yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.make (yyvsc109)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs109")
			end
			yyvsc109 := yyvsc109 + yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.resize (yyvs109, yyvsc109)
		end
	end
	yyvs109.put (yyval109, yyvsp109)
end
when 244 then
--|#line 1758 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1758")
end

			-- $$ := Void
			set_class_features
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp66 := yyvsp66 + 1
	if yyvsp66 >= yyvsc66 then
		if yyvs66 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs66")
			end
			create yyspecial_routines66
			yyvsc66 := yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.make (yyvsc66)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs66")
			end
			yyvsc66 := yyvsc66 + yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.resize (yyvs66, yyvsc66)
		end
	end
	yyvs66.put (yyval66, yyvsp66)
end
when 245 then
--|#line 1763 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1763")
end

yyval66 := yyvs66.item (yyvsp66) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs66.put (yyval66, yyvsp66)
end
when 246 then
--|#line 1767 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1767")
end

			yyval66 := yyvs66.item (yyvsp66)
			set_class_features
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs66.put (yyval66, yyvsp66)
end
when 247 then
--|#line 1775 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1775")
end

			yyval66 := ast_factory.new_feature_clauses (counter_value)
			if yyval66 /= Void and yyvs65.item (yyvsp65) /= Void then
				yyval66.put_first (yyvs65.item (yyvsp65))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp66 := yyvsp66 + 1
	yyvsp65 := yyvsp65 -1
	if yyvsp66 >= yyvsc66 then
		if yyvs66 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs66")
			end
			create yyspecial_routines66
			yyvsc66 := yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.make (yyvsc66)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs66")
			end
			yyvsc66 := yyvsc66 + yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.resize (yyvs66, yyvsc66)
		end
	end
	yyvs66.put (yyval66, yyvsp66)
end
when 248 then
--|#line 1782 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1782")
end

			yyval66 := yyvs66.item (yyvsp66)
			if yyval66 /= Void and yyvs65.item (yyvsp65) /= Void then
				yyval66.put_first (yyvs65.item (yyvsp65))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp65 := yyvsp65 -1
	yyvs66.put (yyval66, yyvsp66)
end
when 249 then
--|#line 1791 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1791")
end

			yyval65 := last_feature_clause
			if yyval65 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs65.put (yyval65, yyvsp65)
end
when 250 then
--|#line 1798 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1798")
end

			yyval65 := last_feature_clause
			if yyval65 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs65.put (yyval65, yyvsp65)
end
when 251 then
--|#line 1807 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1807")
end

			last_clients := yyvs43.item (yyvsp43)
			last_feature_clause := ast_factory.new_feature_clause (yyvs2.item (yyvsp2), last_clients)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp43 := yyvsp43 -1
	if yyvsp65 >= yyvsc65 then
		if yyvs65 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs65")
			end
			create yyspecial_routines65
			yyvsc65 := yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.make (yyvsc65)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs65")
			end
			yyvsc65 := yyvsc65 + yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.resize (yyvs65, yyvsc65)
		end
	end
	yyvs65.put (yyval65, yyvsp65)
end
when 252 then
--|#line 1812 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1812")
end

			last_clients := ast_factory.new_any_clients (yyvs2.item (yyvsp2))
			last_feature_clause := ast_factory.new_feature_clause (yyvs2.item (yyvsp2), last_clients)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp65 >= yyvsc65 then
		if yyvs65 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs65")
			end
			create yyspecial_routines65
			yyvsc65 := yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.make (yyvsc65)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs65")
			end
			yyvsc65 := yyvsc65 + yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.resize (yyvs65, yyvsc65)
		end
	end
	yyvs65.put (yyval65, yyvsp65)
end
when 253 then
--|#line 1819 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1819")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp103 := yyvsp103 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 254 then
--|#line 1820 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1820")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp102 := yyvsp102 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 255 then
--|#line 1821 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1821")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp103 := yyvsp103 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 256 then
--|#line 1822 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1822")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp102 := yyvsp102 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 257 then
--|#line 1827 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1827")
end

			yyval103 := yyvs103.item (yyvsp103)
			register_query (yyval103)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs103.put (yyval103, yyvsp103)
end
when 258 then
--|#line 1832 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1832")
end

			yyval103 := yyvs103.item (yyvsp103)
			yyval103.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_query (yyval103)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs103.put (yyval103, yyvsp103)
end
when 259 then
--|#line 1838 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1838")
end

			yyval103 := new_query_synonym (ast_factory.new_extended_feature_name_comma (yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)), yyvs103.item (yyvsp103))
			register_query_synonym (yyval103)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvs103.put (yyval103, yyvsp103)
end
when 260 then
--|#line 1843 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1843")
end

			yyval103 := new_query_synonym (yyvs63.item (yyvsp63), yyvs103.item (yyvsp103))
			register_query_synonym (yyval103)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 -1
	yyvs103.put (yyval103, yyvsp103)
end
when 261 then
--|#line 1849 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1849")
end

			yyval103 := new_query_synonym (ast_factory.new_extended_feature_name_comma (yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)), yyvs103.item (yyvsp103))
			yyval103.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_query_synonym (yyval103)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvs103.put (yyval103, yyvsp103)
end
when 262 then
--|#line 1855 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1855")
end

			yyval103 := new_query_synonym (yyvs63.item (yyvsp63), yyvs103.item (yyvsp103))
			yyval103.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_query_synonym (yyval103)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp63 := yyvsp63 -1
	yyvs103.put (yyval103, yyvsp103)
end
when 263 then
--|#line 1864 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1864")
end

			yyval102 := yyvs102.item (yyvsp102)
			register_procedure (yyval102)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs102.put (yyval102, yyvsp102)
end
when 264 then
--|#line 1869 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1869")
end

			yyval102 := yyvs102.item (yyvsp102)
			yyval102.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_procedure (yyval102)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs102.put (yyval102, yyvsp102)
end
when 265 then
--|#line 1875 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1875")
end

			yyval102 := new_procedure_synonym (ast_factory.new_extended_feature_name_comma (yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)), yyvs102.item (yyvsp102))
			register_procedure_synonym (yyval102)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvs102.put (yyval102, yyvsp102)
end
when 266 then
--|#line 1880 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1880")
end

			yyval102 := new_procedure_synonym (yyvs63.item (yyvsp63), yyvs102.item (yyvsp102))
			register_procedure_synonym (yyval102)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 -1
	yyvs102.put (yyval102, yyvsp102)
end
when 267 then
--|#line 1886 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1886")
end

			yyval102 := new_procedure_synonym (ast_factory.new_extended_feature_name_comma (yyvs63.item (yyvsp63), yyvs4.item (yyvsp4)), yyvs102.item (yyvsp102))
			yyval102.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_procedure_synonym (yyval102)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvs102.put (yyval102, yyvsp102)
end
when 268 then
--|#line 1892 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1892")
end

			yyval102 := new_procedure_synonym (yyvs63.item (yyvsp63), yyvs102.item (yyvsp102))
			yyval102.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_procedure_synonym (yyval102)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp63 := yyvsp63 -1
	yyvs102.put (yyval102, yyvsp102)
end
when 269 then
--|#line 1901 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1901")
end

yyval103 := ast_factory.new_attribute (yyvs63.item (yyvsp63), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 270 then
--|#line 1903 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1903")
end

yyval103 := ast_factory.new_constant_attribute (yyvs63.item (yyvsp63), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2), yyvs45.item (yyvsp45), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -1
	yyvsp45 := yyvsp45 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 271 then
--|#line 1905 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1905")
end

yyval103 := ast_factory.new_unique_attribute (yyvs63.item (yyvsp63), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -2
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 272 then
--|#line 1907 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1907")
end

yyval103 := ast_factory.new_do_function (yyvs63.item (yyvsp63), Void, ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 14
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 273 then
--|#line 1910 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1910")
end

yyval103 := ast_factory.new_do_function (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 15
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 274 then
--|#line 1914 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1914")
end

yyval103 := ast_factory.new_once_function (yyvs63.item (yyvsp63), Void, ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 14
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 275 then
--|#line 1917 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1917")
end

yyval103 := ast_factory.new_once_function (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 15
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 276 then
--|#line 1921 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1921")
end

yyval103 := ast_factory.new_deferred_function (yyvs63.item (yyvsp63), Void, ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs2.item (yyvsp2 - 1), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 277 then
--|#line 1923 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1923")
end

yyval103 := ast_factory.new_deferred_function (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs2.item (yyvsp2 - 1), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 13
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 278 then
--|#line 1926 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1926")
end

yyval103 := new_external_function (yyvs63.item (yyvsp63), Void, ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs15.item (yyvsp15)), yyvs64.item (yyvsp64), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 14
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp15 := yyvsp15 -1
	yyvsp64 := yyvsp64 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 279 then
--|#line 1929 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1929")
end

yyval103 := new_external_function (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)), yyvs32.item (yyvsp32), yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs15.item (yyvsp15)), yyvs64.item (yyvsp64), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 15
	yyvsp103 := yyvsp103 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp32 := yyvsp32 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp15 := yyvsp15 -1
	yyvsp64 := yyvsp64 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
when 280 then
--|#line 1935 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1935")
end

yyval102 := ast_factory.new_do_procedure (yyvs63.item (yyvsp63), Void, yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 11
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 281 then
--|#line 1938 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1938")
end

yyval102 := ast_factory.new_do_procedure (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 282 then
--|#line 1942 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1942")
end

yyval102 := ast_factory.new_once_procedure (yyvs63.item (yyvsp63), Void, yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 11
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 283 then
--|#line 1945 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1945")
end

yyval102 := ast_factory.new_once_procedure (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), yyvs2.item (yyvsp2 - 1), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs89.item (yyvsp89), yyvs44.item (yyvsp44 - 1), yyvs100.item (yyvsp100), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp2 := yyvsp2 -2
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp89 := yyvsp89 -1
	yyvsp44 := yyvsp44 -2
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 284 then
--|#line 1949 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1949")
end

yyval102 := ast_factory.new_deferred_procedure (yyvs63.item (yyvsp63), Void, yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs2.item (yyvsp2 - 1), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 9
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 285 then
--|#line 1951 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1951")
end

yyval102 := ast_factory.new_deferred_procedure (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), yyvs2.item (yyvsp2 - 1), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 286 then
--|#line 1954 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1954")
end

yyval102 := new_external_procedure (yyvs63.item (yyvsp63), Void, yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs15.item (yyvsp15)), yyvs64.item (yyvsp64), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 11
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp15 := yyvsp15 -1
	yyvsp64 := yyvsp64 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 287 then
--|#line 1957 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1957")
end

yyval102 := new_external_procedure (yyvs63.item (yyvsp63), yyvs72.item (yyvsp72), yyvs2.item (yyvsp2 - 2), yyvs77.item (yyvsp77), yyvs95.item (yyvsp95), yyvs101.item (yyvsp101), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs15.item (yyvsp15)), yyvs64.item (yyvsp64), yyvs100.item (yyvsp100), yyvs2.item (yyvsp2), yyvs21.item (yyvsp21), last_clients, last_feature_clause, last_class) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp102 := yyvsp102 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp72 := yyvsp72 -1
	yyvsp2 := yyvsp2 -3
	yyvsp77 := yyvsp77 -1
	yyvsp95 := yyvsp95 -1
	yyvsp101 := yyvsp101 -1
	yyvsp15 := yyvsp15 -1
	yyvsp64 := yyvsp64 -1
	yyvsp100 := yyvsp100 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
when 288 then
--|#line 1963 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1963")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp21 := yyvsp21 + 1
	if yyvsp21 >= yyvsc21 then
		if yyvs21 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs21")
			end
			create yyspecial_routines21
			yyvsc21 := yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.make (yyvsc21)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs21")
			end
			yyvsc21 := yyvsc21 + yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.resize (yyvs21, yyvsc21)
		end
	end
	yyvs21.put (yyval21, yyvsp21)
end
when 289 then
--|#line 1965 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1965")
end

yyval21 := yyvs21.item (yyvsp21) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs21.put (yyval21, yyvsp21)
end
when 290 then
--|#line 1969 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1969")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp64 := yyvsp64 + 1
	if yyvsp64 >= yyvsc64 then
		if yyvs64 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs64")
			end
			create yyspecial_routines64
			yyvsc64 := yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.make (yyvsc64)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs64")
			end
			yyvsc64 := yyvsc64 + yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.resize (yyvs64, yyvsc64)
		end
	end
	yyvs64.put (yyval64, yyvsp64)
end
when 291 then
--|#line 1971 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1971")
end

yyval64 := ast_factory.new_external_alias (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp64 >= yyvsc64 then
		if yyvs64 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs64")
			end
			create yyspecial_routines64
			yyvsc64 := yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.make (yyvsc64)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs64")
			end
			yyvsc64 := yyvsc64 + yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.resize (yyvs64, yyvsc64)
		end
	end
	yyvs64.put (yyval64, yyvsp64)
end
when 292 then
--|#line 1975 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1975")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp32 := yyvsp32 + 1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
when 293 then
--|#line 1977 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1977")
end

yyval32 := ast_factory.new_assigner (yyvs2.item (yyvsp2), yyvs68.item (yyvsp68)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp68 := yyvsp68 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
when 294 then
--|#line 1983 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1983")
end

yyval68 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 295 then
--|#line 1985 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1985")
end

yyval68 := ast_factory.new_prefix_not_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 296 then
--|#line 1987 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1987")
end

yyval68 := ast_factory.new_prefix_plus_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 297 then
--|#line 1989 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1989")
end

yyval68 := ast_factory.new_prefix_minus_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 298 then
--|#line 1991 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1991")
end

yyval68 := ast_factory.new_prefix_free_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 299 then
--|#line 1993 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1993")
end

yyval68 := ast_factory.new_infix_plus_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 300 then
--|#line 1995 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1995")
end

yyval68 := ast_factory.new_infix_minus_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 301 then
--|#line 1997 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1997")
end

yyval68 := ast_factory.new_infix_times_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 302 then
--|#line 1999 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1999")
end

yyval68 := ast_factory.new_infix_divide_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 303 then
--|#line 2001 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2001")
end

yyval68 := ast_factory.new_infix_div_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 304 then
--|#line 2003 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2003")
end

yyval68 := ast_factory.new_infix_mod_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 305 then
--|#line 2005 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2005")
end

yyval68 := ast_factory.new_infix_power_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 306 then
--|#line 2007 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2007")
end

yyval68 := ast_factory.new_infix_lt_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 307 then
--|#line 2009 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2009")
end

yyval68 := ast_factory.new_infix_le_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 308 then
--|#line 2011 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2011")
end

yyval68 := ast_factory.new_infix_gt_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 309 then
--|#line 2013 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2013")
end

yyval68 := ast_factory.new_infix_ge_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 310 then
--|#line 2015 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2015")
end

yyval68 := ast_factory.new_infix_and_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 311 then
--|#line 2017 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2017")
end

yyval68 := ast_factory.new_infix_and_then_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 312 then
--|#line 2019 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2019")
end

yyval68 := ast_factory.new_infix_or_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 313 then
--|#line 2021 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2021")
end

yyval68 := ast_factory.new_infix_or_else_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 314 then
--|#line 2023 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2023")
end

yyval68 := ast_factory.new_infix_implies_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 315 then
--|#line 2025 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2025")
end

yyval68 := ast_factory.new_infix_xor_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 316 then
--|#line 2027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2027")
end

yyval68 := ast_factory.new_infix_free_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 317 then
--|#line 2030 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2030")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 318 then
--|#line 2032 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2032")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 319 then
--|#line 2034 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2034")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 320 then
--|#line 2036 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2036")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 321 then
--|#line 2038 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2038")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 322 then
--|#line 2040 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2040")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 323 then
--|#line 2042 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2042")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 324 then
--|#line 2044 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2044")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 325 then
--|#line 2046 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2046")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 326 then
--|#line 2048 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2048")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 327 then
--|#line 2050 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2050")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 328 then
--|#line 2052 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2052")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 329 then
--|#line 2054 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2054")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 330 then
--|#line 2056 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2056")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 331 then
--|#line 2058 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2058")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 332 then
--|#line 2060 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2060")
end

yyval68 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 333 then
--|#line 2062 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2062")
end

yyval68 := new_invalid_infix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 334 then
--|#line 2064 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2064")
end

yyval68 := new_invalid_infix_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
when 335 then
--|#line 2068 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2068")
end

yyval63 := yyvs68.item (yyvsp68) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp68 := yyvsp68 -1
	if yyvsp63 >= yyvsc63 then
		if yyvs63 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs63")
			end
			create yyspecial_routines63
			yyvsc63 := yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.make (yyvsc63)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs63")
			end
			yyvsc63 := yyvsc63 + yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.resize (yyvs63, yyvsc63)
		end
	end
	yyvs63.put (yyval63, yyvsp63)
end
when 336 then
--|#line 2070 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2070")
end

yyval63 := ast_factory.new_aliased_feature_name (yyvs12.item (yyvsp12), yyvs31.item (yyvsp31)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp31 := yyvsp31 -1
	if yyvsp63 >= yyvsc63 then
		if yyvs63 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs63")
			end
			create yyspecial_routines63
			yyvsc63 := yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.make (yyvsc63)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs63")
			end
			yyvsc63 := yyvsc63 + yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.resize (yyvs63, yyvsc63)
		end
	end
	yyvs63.put (yyval63, yyvsp63)
end
when 337 then
--|#line 2074 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2074")
end

yyval31 := ast_factory.new_alias_not_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 338 then
--|#line 2076 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2076")
end

yyval31 := ast_factory.new_alias_plus_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 339 then
--|#line 2078 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2078")
end

yyval31 := ast_factory.new_alias_minus_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 340 then
--|#line 2080 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2080")
end

yyval31 := ast_factory.new_alias_times_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 341 then
--|#line 2082 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2082")
end

yyval31 := ast_factory.new_alias_divide_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 342 then
--|#line 2084 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2084")
end

yyval31 := ast_factory.new_alias_div_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 343 then
--|#line 2086 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2086")
end

yyval31 := ast_factory.new_alias_mod_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 344 then
--|#line 2088 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2088")
end

yyval31 := ast_factory.new_alias_power_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 345 then
--|#line 2090 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2090")
end

yyval31 := ast_factory.new_alias_lt_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 346 then
--|#line 2092 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2092")
end

yyval31 := ast_factory.new_alias_le_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 347 then
--|#line 2094 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2094")
end

yyval31 := ast_factory.new_alias_gt_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 348 then
--|#line 2096 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2096")
end

yyval31 := ast_factory.new_alias_ge_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 349 then
--|#line 2098 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2098")
end

yyval31 := ast_factory.new_alias_and_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 350 then
--|#line 2100 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2100")
end

yyval31 := ast_factory.new_alias_and_then_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 351 then
--|#line 2102 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2102")
end

yyval31 := ast_factory.new_alias_or_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 352 then
--|#line 2104 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2104")
end

yyval31 := ast_factory.new_alias_or_else_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 353 then
--|#line 2106 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2106")
end

yyval31 := ast_factory.new_alias_implies_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 354 then
--|#line 2108 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2108")
end

yyval31 := ast_factory.new_alias_xor_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 355 then
--|#line 2110 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2110")
end

yyval31 := ast_factory.new_alias_dotdot_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 356 then
--|#line 2112 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2112")
end

yyval31 := ast_factory.new_alias_free_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 357 then
--|#line 2114 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2114")
end

yyval31 := ast_factory.new_alias_bracket_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 358 then
--|#line 2117 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2117")
end

yyval31 := new_invalid_alias_name (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
when 359 then
--|#line 2123 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2123")
end

yyval72 := new_formal_arguments (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp72 >= yyvsc72 then
		if yyvs72 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs72")
			end
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs72")
			end
			yyvsc72 := yyvsc72 + yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.resize (yyvs72, yyvsc72)
		end
	end
	yyvs72.put (yyval72, yyvsp72)
end
when 360 then
--|#line 2125 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2125")
end

			yyval72 := yyvs72.item (yyvsp72)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 -1
	yyvsp4 := yyvsp4 -1
	yyvs72.put (yyval72, yyvsp72)
end
when 361 then
--|#line 2125 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2125")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp72 := yyvsp72 + 1
	if yyvsp72 >= yyvsc72 then
		if yyvs72 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs72")
			end
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs72")
			end
			yyvsc72 := yyvsc72 + yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.resize (yyvs72, yyvsc72)
		end
	end
	yyvs72.put (yyval72, yyvsp72)
end
when 362 then
--|#line 2138 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2138")
end

			yyval72 := new_formal_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval72 /= Void and yyvs71.item (yyvsp71) /= Void then
				yyval72.put_first (yyvs71.item (yyvsp71))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp72 >= yyvsc72 then
		if yyvs72 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs72")
			end
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs72")
			end
			yyvsc72 := yyvsc72 + yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.resize (yyvs72, yyvsc72)
		end
	end
	yyvs72.put (yyval72, yyvsp72)
end
when 363 then
--|#line 2145 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2145")
end

			yyval72 := new_formal_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval72 /= Void and yyvs71.item (yyvsp71) /= Void then
				yyval72.put_first (yyvs71.item (yyvsp71))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp72 >= yyvsc72 then
		if yyvs72 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs72")
			end
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs72")
			end
			yyvsc72 := yyvsc72 + yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.resize (yyvs72, yyvsc72)
		end
	end
	yyvs72.put (yyval72, yyvsp72)
end
when 364 then
--|#line 2152 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2152")
end

			yyval72 := yyvs72.item (yyvsp72)
			if yyval72 /= Void and yyvs70.item (yyvsp70) /= Void then
				if not yyval72.is_empty then
					yyvs70.item (yyvsp70).set_declared_type (yyval72.first.type)
					yyval72.put_first (yyvs70.item (yyvsp70))
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs72.put (yyval72, yyvsp72)
end
when 365 then
--|#line 2162 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2162")
end

			-- TODO: Syntax error
			yyval72 := yyvs72.item (yyvsp72)
			if yyval72 /= Void and yyvs70.item (yyvsp70) /= Void then
				if not yyval72.is_empty then
					yyvs70.item (yyvsp70).set_declared_type (yyval72.first.type)
					yyval72.put_first (yyvs70.item (yyvsp70))
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs72.put (yyval72, yyvsp72)
end
when 366 then
--|#line 2173 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2173")
end

			yyval72 := yyvs72.item (yyvsp72)
			if yyval72 /= Void and yyvs71.item (yyvsp71) /= Void then
				yyval72.put_first (yyvs71.item (yyvsp71))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 -1
	yyvs72.put (yyval72, yyvsp72)
end
when 367 then
--|#line 2180 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2180")
end

			yyval72 := yyvs72.item (yyvsp72)
			if yyval72 /= Void and yyvs71.item (yyvsp71) /= Void then
				yyval72.put_first (yyvs71.item (yyvsp71))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 -1
	yyvs72.put (yyval72, yyvsp72)
end
when 368 then
--|#line 2189 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2189")
end

			yyval70 := ast_factory.new_formal_comma_argument (ast_factory.new_argument_name_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), dummy_type)
			if yyval70 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp70 >= yyvsc70 then
		if yyvs70 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs70")
			end
			create yyspecial_routines70
			yyvsc70 := yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.make (yyvsc70)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs70")
			end
			yyvsc70 := yyvsc70 + yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.resize (yyvs70, yyvsc70)
		end
	end
	yyvs70.put (yyval70, yyvsp70)
end
when 369 then
--|#line 2198 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2198")
end

			yyval70 := ast_factory.new_formal_comma_argument (yyvs12.item (yyvsp12), dummy_type)
			if yyval70 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp70 := yyvsp70 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp70 >= yyvsc70 then
		if yyvs70 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs70")
			end
			create yyspecial_routines70
			yyvsc70 := yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.make (yyvsc70)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs70")
			end
			yyvsc70 := yyvsc70 + yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.resize (yyvs70, yyvsc70)
		end
	end
	yyvs70.put (yyval70, yyvsp70)
end
when 370 then
--|#line 2207 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2207")
end

			yyval71 := ast_factory.new_formal_argument (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)))
			if yyval71 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp71 := yyvsp71 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	if yyvsp71 >= yyvsc71 then
		if yyvs71 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs71")
			end
			create yyspecial_routines71
			yyvsc71 := yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.make (yyvsc71)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs71")
			end
			yyvsc71 := yyvsc71 + yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.resize (yyvs71, yyvsc71)
		end
	end
	yyvs71.put (yyval71, yyvsp71)
end
when 371 then
--|#line 2216 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2216")
end

			yyval71 := ast_factory.new_formal_argument_semicolon (ast_factory.new_formal_argument (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108))), yyvs21.item (yyvsp21))
			if yyval71 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp71 := yyvsp71 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp71 >= yyvsc71 then
		if yyvs71 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs71")
			end
			create yyspecial_routines71
			yyvsc71 := yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.make (yyvsc71)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs71")
			end
			yyvsc71 := yyvsc71 + yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.resize (yyvs71, yyvsc71)
		end
	end
	yyvs71.put (yyval71, yyvsp71)
end
when 372 then
--|#line 2227 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2227")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp89 := yyvsp89 + 1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
when 373 then
--|#line 2229 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2229")
end

yyval89 := new_local_variables (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
when 374 then
--|#line 2231 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2231")
end

			yyval89 := yyvs89.item (yyvsp89)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp89 := yyvsp89 -1
	yyvsp2 := yyvsp2 -1
	yyvs89.put (yyval89, yyvsp89)
end
when 375 then
--|#line 2231 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2231")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp89 := yyvsp89 + 1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
when 376 then
--|#line 2244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2244")
end

			yyval89 := new_local_variables (last_keyword, counter_value)
			if yyvs88.item (yyvsp88) /= Void then
				yyval89.put_first (yyvs88.item (yyvsp88))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
when 377 then
--|#line 2251 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2251")
end

			yyval89 := new_local_variables (last_keyword, counter_value)
			if yyvs88.item (yyvsp88) /= Void then
				yyval89.put_first (yyvs88.item (yyvsp88))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
when 378 then
--|#line 2258 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2258")
end

			yyval89 := yyvs89.item (yyvsp89)
			if yyval89 /= Void and yyvs87.item (yyvsp87) /= Void then
				if not yyval89.is_empty then
					yyvs87.item (yyvsp87).set_declared_type (yyval89.first.type)
					yyval89.put_first (yyvs87.item (yyvsp87))
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp87 := yyvsp87 -1
	yyvs89.put (yyval89, yyvsp89)
end
when 379 then
--|#line 2268 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2268")
end

			-- TODO: Syntax error
			yyval89 := yyvs89.item (yyvsp89)
			if yyval89 /= Void and yyvs87.item (yyvsp87) /= Void then
				if not yyval89.is_empty then
					yyvs87.item (yyvsp87).set_declared_type (yyval89.first.type)
					yyval89.put_first (yyvs87.item (yyvsp87))
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp87 := yyvsp87 -1
	yyvs89.put (yyval89, yyvsp89)
end
when 380 then
--|#line 2279 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2279")
end

			yyval89 := yyvs89.item (yyvsp89)
			if yyval89 /= Void and yyvs88.item (yyvsp88) /= Void then
				yyval89.put_first (yyvs88.item (yyvsp88))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 -1
	yyvs89.put (yyval89, yyvsp89)
end
when 381 then
--|#line 2286 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2286")
end

			yyval89 := yyvs89.item (yyvsp89)
			if yyval89 /= Void and yyvs88.item (yyvsp88) /= Void then
				yyval89.put_first (yyvs88.item (yyvsp88))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 -1
	yyvs89.put (yyval89, yyvsp89)
end
when 382 then
--|#line 2295 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2295")
end

			yyval87 := ast_factory.new_local_comma_variable (ast_factory.new_local_name_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), dummy_type)
			if yyval87 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp87 := yyvsp87 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
when 383 then
--|#line 2304 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2304")
end

			yyval87 := ast_factory.new_local_comma_variable (yyvs12.item (yyvsp12), dummy_type)
			if yyval87 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
when 384 then
--|#line 2313 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2313")
end

			yyval88 := ast_factory.new_local_variable (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)))
			if yyval88 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
when 385 then
--|#line 2322 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2322")
end

			yyval88 := ast_factory.new_local_variable_semicolon (ast_factory.new_local_variable (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108))), yyvs21.item (yyvsp21))
			if yyval88 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp88 := yyvsp88 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
when 386 then
--|#line 2333 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2333")
end

add_expression_assertion (yyvs61.item (yyvsp61), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 387 then
--|#line 2335 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2335")
end

add_expression_assertion (yyvs61.item (yyvsp61), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 388 then
--|#line 2337 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2337")
end

add_tagged_assertion (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 389 then
--|#line 2339 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2339")
end

add_tagged_assertion (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 390 then
--|#line 2341 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2341")
end

add_expression_assertion (yyvs61.item (yyvsp61), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 391 then
--|#line 2343 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2343")
end

add_expression_assertion (yyvs61.item (yyvsp61), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp21 := yyvsp21 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 392 then
--|#line 2345 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2345")
end

add_tagged_assertion (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 393 then
--|#line 2347 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2347")
end

add_tagged_assertion (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp21 := yyvsp21 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 394 then
--|#line 2351 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2351")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp101 := yyvsp101 + 1
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
when 395 then
--|#line 2353 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2353")
end

yyval101 := new_preconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp101 := yyvsp101 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
when 396 then
--|#line 2355 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2355")
end

yyval101 := new_preconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
when 397 then
--|#line 2357 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2357")
end

yyval101 := new_preconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
when 398 then
--|#line 2359 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2359")
end

yyval101 := new_preconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp101 := yyvsp101 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
when 399 then
--|#line 2363 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2363")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp100 := yyvsp100 + 1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
when 400 then
--|#line 2365 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2365")
end

yyval100 := new_postconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp100 := yyvsp100 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
when 401 then
--|#line 2367 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2367")
end

yyval100 := new_postconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
when 402 then
--|#line 2369 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2369")
end

yyval100 := new_postconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
when 403 then
--|#line 2371 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2371")
end

yyval100 := new_postconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp100 := yyvsp100 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
when 404 then
--|#line 2375 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2375")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp84 := yyvsp84 + 1
	if yyvsp84 >= yyvsc84 then
		if yyvs84 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs84")
			end
			create yyspecial_routines84
			yyvsc84 := yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.make (yyvsc84)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs84")
			end
			yyvsc84 := yyvsc84 + yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.resize (yyvs84, yyvsc84)
		end
	end
	yyvs84.put (yyval84, yyvsp84)
end
when 405 then
--|#line 2377 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2377")
end

yyval84 := yyvs84.item (yyvsp84) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs84.put (yyval84, yyvsp84)
end
when 406 then
--|#line 2381 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2381")
end

yyval84 := new_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp84 := yyvsp84 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp84 >= yyvsc84 then
		if yyvs84 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs84")
			end
			create yyspecial_routines84
			yyvsc84 := yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.make (yyvsc84)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs84")
			end
			yyvsc84 := yyvsc84 + yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.resize (yyvs84, yyvsc84)
		end
	end
	yyvs84.put (yyval84, yyvsp84)
end
when 407 then
--|#line 2383 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2383")
end

yyval84 := new_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp84 := yyvsp84 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp84 >= yyvsc84 then
		if yyvs84 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs84")
			end
			create yyspecial_routines84
			yyvsc84 := yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.make (yyvsc84)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs84")
			end
			yyvsc84 := yyvsc84 + yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.resize (yyvs84, yyvsc84)
		end
	end
	yyvs84.put (yyval84, yyvsp84)
end
when 408 then
--|#line 2387 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2387")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp90 := yyvsp90 + 1
	if yyvsp90 >= yyvsc90 then
		if yyvs90 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs90")
			end
			create yyspecial_routines90
			yyvsc90 := yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.make (yyvsc90)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs90")
			end
			yyvsc90 := yyvsc90 + yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.resize (yyvs90, yyvsc90)
		end
	end
	yyvs90.put (yyval90, yyvsp90)
end
when 409 then
--|#line 2389 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2389")
end

yyval90 := yyvs90.item (yyvsp90) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs90.put (yyval90, yyvsp90)
end
when 410 then
--|#line 2393 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2393")
end

yyval90 := new_loop_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp90 >= yyvsc90 then
		if yyvs90 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs90")
			end
			create yyspecial_routines90
			yyvsc90 := yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.make (yyvsc90)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs90")
			end
			yyvsc90 := yyvsc90 + yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.resize (yyvs90, yyvsc90)
		end
	end
	yyvs90.put (yyval90, yyvsp90)
end
when 411 then
--|#line 2395 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2395")
end

yyval90 := new_loop_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp90 := yyvsp90 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp90 >= yyvsc90 then
		if yyvs90 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs90")
			end
			create yyspecial_routines90
			yyvsc90 := yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.make (yyvsc90)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs90")
			end
			yyvsc90 := yyvsc90 + yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.resize (yyvs90, yyvsc90)
		end
	end
	yyvs90.put (yyval90, yyvsp90)
end
when 412 then
--|#line 2399 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2399")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp111 := yyvsp111 + 1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
when 413 then
--|#line 2401 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2401")
end

yyval111 := ast_factory.new_variant (yyvs2.item (yyvsp2), Void, Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp111 := yyvsp111 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
when 414 then
--|#line 2403 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2403")
end

yyval111 := ast_factory.new_variant (yyvs2.item (yyvsp2), Void, yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp111 := yyvsp111 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
when 415 then
--|#line 2405 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2405")
end

yyval111 := ast_factory.new_variant (yyvs2.item (yyvsp2), ast_factory.new_tag (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp111 := yyvsp111 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
when 416 then
--|#line 2411 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2411")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp44 := yyvsp44 + 1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 417 then
--|#line 2413 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2413")
end

yyval44 := yyvs44.item (yyvsp44) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs44.put (yyval44, yyvsp44)
end
when 418 then
--|#line 2419 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2419")
end

yyval108 := new_named_type (Void, yyvs12.item (yyvsp12), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 419 then
--|#line 2421 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2421")
end

yyval108 := yyvs108.item (yyvsp108) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs108.put (yyval108, yyvsp108)
end
when 420 then
--|#line 2425 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2425")
end

yyval108 := new_named_type (Void, yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 421 then
--|#line 2427 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2427")
end

yyval108 := new_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 422 then
--|#line 2429 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2429")
end

yyval108 := new_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 423 then
--|#line 2431 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2431")
end

yyval108 := new_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 424 then
--|#line 2433 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2433")
end

yyval108 := yyvs86.item (yyvsp86) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 425 then
--|#line 2435 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2435")
end

yyval108 := new_bit_n (yyvs12.item (yyvsp12), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 426 then
--|#line 2437 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2437")
end

yyval108 := ast_factory.new_bit_feature (yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))  
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -2
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 427 then
--|#line 2439 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2439")
end

yyval108 := ast_factory.new_tuple_type (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 428 then
--|#line 2443 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2443")
end

yyval108 := new_named_type (Void, yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 429 then
--|#line 2445 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2445")
end

yyval108 := new_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 430 then
--|#line 2447 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2447")
end

yyval108 := new_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 431 then
--|#line 2449 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2449")
end

yyval108 := new_named_type (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 432 then
--|#line 2451 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2451")
end

yyval108 := yyvs86.item (yyvsp86) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 433 then
--|#line 2453 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2453")
end

yyval108 := new_bit_n (yyvs12.item (yyvsp12), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 434 then
--|#line 2455 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2455")
end

yyval108 := ast_factory.new_bit_feature (yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))  
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -2
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 435 then
--|#line 2457 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2457")
end

yyval108 := ast_factory.new_tuple_type (yyvs12.item (yyvsp12), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp26 := yyvsp26 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
when 436 then
--|#line 2461 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2461")
end

yyval12 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
when 437 then
--|#line 2465 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2465")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp26 := yyvsp26 + 1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
when 438 then
--|#line 2467 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2467")
end

yyval26 := yyvs26.item (yyvsp26) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs26.put (yyval26, yyvsp26)
end
when 439 then
--|#line 2471 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2471")
end

yyval26 := ast_factory.new_actual_parameters (yyvs22.item (yyvsp22), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
when 440 then
--|#line 2474 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2474")
end

			yyval26 := yyvs26.item (yyvsp26)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 441 then
--|#line 2482 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2482")
end

			add_symbol (yyvs22.item (yyvsp22))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp22 := yyvsp22 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 442 then
--|#line 2489 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2489")
end

			if yyvs108.item (yyvsp108) /= Void then
				yyval26 := ast_factory.new_actual_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval26 /= Void then
					yyval26.put_first (yyvs108.item (yyvsp108))
				end
			else
				yyval26 := ast_factory.new_actual_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp108 := yyvsp108 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
when 443 then
--|#line 2500 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2500")
end

			yyval26 := yyvs26.item (yyvsp26)
			add_to_actual_parameter_list (yyvs25.item (yyvsp25), yyval26)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 444 then
--|#line 2505 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2505")
end

			yyval26 := yyvs26.item (yyvsp26)
			add_to_actual_parameter_list (ast_factory.new_actual_parameter_comma (new_named_type (Void, yyvs12.item (yyvsp12), Void), yyvs4.item (yyvsp4)), yyval26)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 445 then
--|#line 2510 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2510")
end

			yyval26 := yyvs26.item (yyvsp26)
			add_to_actual_parameter_list (ast_factory.new_actual_parameter_comma (ast_factory.new_tuple_type (yyvs12.item (yyvsp12), Void), yyvs4.item (yyvsp4)), yyval26)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 446 then
--|#line 2517 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2517")
end

			increment_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 447 then
--|#line 2523 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2523")
end

			yyval25 := ast_factory.new_actual_parameter_comma (yyvs108.item (yyvsp108), yyvs4.item (yyvsp4))
			if yyval25 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp108 := yyvsp108 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
when 448 then
--|#line 2532 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2532")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp26 := yyvsp26 + 1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
when 449 then
--|#line 2534 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2534")
end

yyval26 := yyvs26.item (yyvsp26) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs26.put (yyval26, yyvsp26)
end
when 450 then
--|#line 2538 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2538")
end

yyval26 := ast_factory.new_actual_parameters (yyvs22.item (yyvsp22), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
when 451 then
--|#line 2541 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2541")
end

			yyval26 := yyvs26.item (yyvsp26)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 452 then
--|#line 2547 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2547")
end

			yyval26 := yyvs26.item (yyvsp26)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 453 then
--|#line 2555 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2555")
end

			yyval26 := ast_factory.new_actual_parameters (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
			add_to_actual_parameter_list (ast_factory.new_labeled_actual_parameter (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108))), yyval26)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp26 := yyvsp26 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
when 454 then
--|#line 2560 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2560")
end

			yyval26 := yyvs26.item (yyvsp26)
			add_to_actual_parameter_list (yyvs25.item (yyvsp25), yyvs26.item (yyvsp26))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 455 then
--|#line 2565 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2565")
end

			yyval26 := yyvs26.item (yyvsp26)
			add_to_actual_parameter_list (yyvs25.item (yyvsp25), yyvs26.item (yyvsp26))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 456 then
--|#line 2570 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2570")
end

			yyval26 := yyvs26.item (yyvsp26)
			if yyval26 /= Void then
				if not yyval26.is_empty then
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyval26.first.type), yyval26)
				else
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), Void), yyval26)
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 457 then
--|#line 2581 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2581")
end

			yyval26 := yyvs26.item (yyvsp26)
			if yyval26 /= Void then
				if not yyval26.is_empty then
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyval26.first.type), yyval26)
				else
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), Void), yyval26)
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 458 then
--|#line 2592 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2592")
end

			yyval26 := yyvs26.item (yyvsp26)
			if yyval26 /= Void then
				if not yyval26.is_empty then
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyval26.first.type), yyval26)
				else
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), Void), yyval26)
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
when 459 then
--|#line 2605 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2605")
end

			yyval25 := ast_factory.new_labeled_actual_parameter (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108)))
			if yyval25 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
when 460 then
--|#line 2614 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2614")
end

			yyval25 := ast_factory.new_labeled_actual_parameter_semicolon (ast_factory.new_labeled_actual_parameter (yyvs12.item (yyvsp12), ast_factory.new_colon_type (yyvs4.item (yyvsp4), yyvs108.item (yyvsp108))), yyvs21.item (yyvsp21))
			if yyval25 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp25 := yyvsp25 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	yyvsp108 := yyvsp108 -1
	yyvsp21 := yyvsp21 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
when 461 then
--|#line 2623 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2623")
end

yyval86 := ast_factory.new_like_feature (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp86 >= yyvsc86 then
		if yyvs86 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs86")
			end
			create yyspecial_routines86
			yyvsc86 := yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.make (yyvsc86)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs86")
			end
			yyvsc86 := yyvsc86 + yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.resize (yyvs86, yyvsc86)
		end
	end
	yyvs86.put (yyval86, yyvsp86)
end
when 462 then
--|#line 2625 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2625")
end

yyval86 := ast_factory.new_like_current (yyvs2.item (yyvsp2), yyvs10.item (yyvsp10)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp10 := yyvsp10 -1
	if yyvsp86 >= yyvsc86 then
		if yyvs86 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs86")
			end
			create yyspecial_routines86
			yyvsc86 := yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.make (yyvsc86)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs86")
			end
			yyvsc86 := yyvsc86 + yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.resize (yyvs86, yyvsc86)
		end
	end
	yyvs86.put (yyval86, yyvsp86)
end
when 463 then
--|#line 2631 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2631")
end

yyval44 := ast_factory.new_do_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 464 then
--|#line 2633 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2633")
end

			yyval44 := ast_factory.new_do_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 465 then
--|#line 2640 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2640")
end

yyval44 := ast_factory.new_once_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 466 then
--|#line 2642 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2642")
end

			yyval44 := ast_factory.new_once_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 467 then
--|#line 2649 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2649")
end

yyval44 := ast_factory.new_then_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 468 then
--|#line 2651 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2651")
end

			yyval44 := ast_factory.new_then_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 469 then
--|#line 2658 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2658")
end

yyval44 := ast_factory.new_else_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 470 then
--|#line 2660 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2660")
end

			yyval44 := ast_factory.new_else_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 471 then
--|#line 2667 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2667")
end

yyval44 := ast_factory.new_rescue_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 472 then
--|#line 2669 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2669")
end

			yyval44 := ast_factory.new_rescue_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 473 then
--|#line 2676 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2676")
end

yyval44 := ast_factory.new_from_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 474 then
--|#line 2678 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2678")
end

			yyval44 := ast_factory.new_from_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 475 then
--|#line 2685 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2685")
end

yyval44 := ast_factory.new_loop_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 476 then
--|#line 2687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2687")
end

			yyval44 := ast_factory.new_loop_compound (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 477 then
--|#line 2694 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2694")
end

			if yyvs83.item (yyvsp83) /= Void then
				yyval44 := ast_factory.new_compound (counter_value + 1)
				if yyval44 /= Void then
					yyval44.put_first (yyvs83.item (yyvsp83))
				end
			else
				yyval44 := ast_factory.new_compound (counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp83 := yyvsp83 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 478 then
--|#line 2705 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2705")
end

			yyval44 := yyvs44.item (yyvsp44)
			if yyval44 /= Void and yyvs83.item (yyvsp83) /= Void then
				yyval44.put_first (yyvs83.item (yyvsp83))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp44 := yyvsp44 -1
	yyvsp83 := yyvsp83 -1
	yyvs44.put (yyval44, yyvsp44)
end
when 479 then
--|#line 2705 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2705")
end

			if yyvs83.item (yyvsp83) /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp44 := yyvsp44 + 1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
when 480 then
--|#line 2726 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2726")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
when 481 then
--|#line 2728 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2728")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
when 482 then
--|#line 2730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2730")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
when 483 then
--|#line 2732 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2732")
end

yyval83 := ast_factory.new_assigner_instruction (yyvs36.item (yyvsp36), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp36 := yyvsp36 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 484 then
--|#line 2734 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2734")
end

yyval83 := ast_factory.new_assigner_instruction (yyvs34.item (yyvsp34), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp34 := yyvsp34 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 485 then
--|#line 2736 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2736")
end

yyval83 := ast_factory.new_assignment (yyvs114.item (yyvsp114), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 486 then
--|#line 2739 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2739")
end

yyval83 := ast_factory.new_assignment (yyvs114.item (yyvsp114), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 487 then
--|#line 2742 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2742")
end

yyval83 := ast_factory.new_assignment_attempt (yyvs114.item (yyvsp114), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp114 := yyvsp114 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 488 then
--|#line 2744 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2744")
end

yyval83 := yyvs76.item (yyvsp76) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp76 := yyvsp76 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 489 then
--|#line 2746 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2746")
end

yyval83 := yyvs82.item (yyvsp82) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp82 := yyvsp82 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 490 then
--|#line 2748 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2748")
end

yyval83 := ast_factory.new_loop_instruction (yyvs44.item (yyvsp44 - 1), yyvs90.item (yyvsp90), yyvs111.item (yyvsp111), ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp83 := yyvsp83 + 1
	yyvsp44 := yyvsp44 -2
	yyvsp90 := yyvsp90 -1
	yyvsp111 := yyvsp111 -1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 491 then
--|#line 2755 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2755")
end

yyval83 := yyvs56.item (yyvsp56) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp56 := yyvsp56 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 492 then
--|#line 2757 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2757")
end

yyval83 := new_check_instruction (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 493 then
--|#line 2759 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2759")
end

yyval83 := new_check_instruction (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 494 then
--|#line 2761 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2761")
end

yyval83 := yyvs18.item (yyvsp18) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp18 := yyvsp18 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 495 then
--|#line 2763 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2763")
end

yyval83 := ast_factory.new_null_instruction (yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp21 := yyvsp21 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 496 then
--|#line 2769 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2769")
end

yyval83 := ast_factory.new_bang_instruction (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4), yyvs114.item (yyvsp114), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvsp114 := yyvsp114 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 497 then
--|#line 2771 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2771")
end

yyval83 := ast_factory.new_bang_instruction (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1), yyvs114.item (yyvsp114), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24))) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp83 := yyvsp83 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp114 := yyvsp114 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 498 then
--|#line 2773 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2773")
end

yyval83 := ast_factory.new_bang_instruction (yyvs4.item (yyvsp4 - 1), Void, yyvs4.item (yyvsp4), yyvs114.item (yyvsp114), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp83 := yyvsp83 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp114 := yyvsp114 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 499 then
--|#line 2775 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2775")
end

yyval83 := ast_factory.new_bang_instruction (yyvs4.item (yyvsp4 - 2), Void, yyvs4.item (yyvsp4 - 1), yyvs114.item (yyvsp114), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24))) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp83 := yyvsp83 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp114 := yyvsp114 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 500 then
--|#line 2779 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2779")
end

yyval83 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)), yyvs114.item (yyvsp114), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvsp114 := yyvsp114 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 501 then
--|#line 2781 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2781")
end

yyval83 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1)), yyvs114.item (yyvsp114), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24))) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp114 := yyvsp114 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 502 then
--|#line 2783 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2783")
end

yyval83 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), Void, yyvs114.item (yyvsp114), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp114 := yyvsp114 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 503 then
--|#line 2785 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2785")
end

yyval83 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), Void, yyvs114.item (yyvsp114), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24))) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp114 := yyvsp114 -1
	yyvsp4 := yyvsp4 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 504 then
--|#line 2789 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2789")
end

yyval53 := ast_factory.new_create_expression (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp53 := yyvsp53 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	if yyvsp53 >= yyvsc53 then
		if yyvs53 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs53")
			end
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs53")
			end
			yyvsc53 := yyvsc53 + yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.resize (yyvs53, yyvsc53)
		end
	end
	yyvs53.put (yyval53, yyvsp53)
end
when 505 then
--|#line 2791 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2791")
end

yyval53 := ast_factory.new_create_expression (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1)), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24))) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp53 := yyvsp53 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp53 >= yyvsc53 then
		if yyvs53 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs53")
			end
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs53")
			end
			yyvsc53 := yyvsc53 + yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.resize (yyvs53, yyvsc53)
		end
	end
	yyvs53.put (yyval53, yyvsp53)
end
when 506 then
--|#line 2797 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2797")
end

yyval76 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs44.item (yyvsp44), Void, Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp76 := yyvsp76 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
when 507 then
--|#line 2799 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2799")
end

yyval76 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs44.item (yyvsp44 - 1), Void, yyvs44.item (yyvsp44), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp76 := yyvsp76 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	yyvsp44 := yyvsp44 -2
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
when 508 then
--|#line 2801 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2801")
end

yyval76 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs44.item (yyvsp44), yyvs58.item (yyvsp58), Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp76 := yyvsp76 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	yyvsp44 := yyvsp44 -1
	yyvsp58 := yyvsp58 -1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
when 509 then
--|#line 2803 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2803")
end

yyval76 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs44.item (yyvsp44 - 1), yyvs58.item (yyvsp58), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp76 := yyvsp76 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	yyvsp44 := yyvsp44 -2
	yyvsp58 := yyvsp58 -1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
when 510 then
--|#line 2807 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2807")
end

			yyval58 := yyvs58.item (yyvsp58)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs58.put (yyval58, yyvsp58)
end
when 511 then
--|#line 2814 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2814")
end

			yyval58 := ast_factory.new_elseif_part_list (counter_value)
			if yyval58 /= Void and yyvs57.item (yyvsp57) /= Void then
				yyval58.put_first (yyvs57.item (yyvsp57))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp58 := yyvsp58 + 1
	yyvsp57 := yyvsp57 -1
	if yyvsp58 >= yyvsc58 then
		if yyvs58 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs58")
			end
			create yyspecial_routines58
			yyvsc58 := yyInitial_yyvs_size
			yyvs58 := yyspecial_routines58.make (yyvsc58)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs58")
			end
			yyvsc58 := yyvsc58 + yyInitial_yyvs_size
			yyvs58 := yyspecial_routines58.resize (yyvs58, yyvsc58)
		end
	end
	yyvs58.put (yyval58, yyvsp58)
end
when 512 then
--|#line 2821 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2821")
end

			yyval58 := yyvs58.item (yyvsp58)
			if yyval58 /= Void and yyvs57.item (yyvsp57) /= Void then
				yyval58.put_first (yyvs57.item (yyvsp57))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp57 := yyvsp57 -1
	yyvs58.put (yyval58, yyvsp58)
end
when 513 then
--|#line 2830 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2830")
end

			yyval57 := ast_factory.new_elseif_part (ast_factory.new_conditional (yyvs2.item (yyvsp2), yyvs61.item (yyvsp61)), yyvs44.item (yyvsp44))
			if yyval57 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp57 := yyvsp57 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp61 := yyvsp61 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp57 >= yyvsc57 then
		if yyvs57 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs57")
			end
			create yyspecial_routines57
			yyvsc57 := yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.make (yyvsc57)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs57")
			end
			yyvsc57 := yyvsc57 + yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.resize (yyvs57, yyvsc57)
		end
	end
	yyvs57.put (yyval57, yyvsp57)
end
when 514 then
--|#line 2841 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2841")
end

yyval82 := ast_factory.new_inspect_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs113.item (yyvsp113), yyvs44.item (yyvsp44), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	yyvsp113 := yyvsp113 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp82 >= yyvsc82 then
		if yyvs82 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs82")
			end
			create yyspecial_routines82
			yyvsc82 := yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.make (yyvsc82)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs82")
			end
			yyvsc82 := yyvsc82 + yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.resize (yyvs82, yyvsc82)
		end
	end
	yyvs82.put (yyval82, yyvsp82)
end
when 515 then
--|#line 2843 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2843")
end

yyval82 := ast_factory.new_inspect_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs61.item (yyvsp61)), yyvs113.item (yyvsp113), Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp82 := yyvsp82 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp61 := yyvsp61 -1
	yyvsp113 := yyvsp113 -1
	if yyvsp82 >= yyvsc82 then
		if yyvs82 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs82")
			end
			create yyspecial_routines82
			yyvsc82 := yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.make (yyvsc82)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs82")
			end
			yyvsc82 := yyvsc82 + yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.resize (yyvs82, yyvsc82)
		end
	end
	yyvs82.put (yyval82, yyvsp82)
end
when 516 then
--|#line 2847 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2847")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp113 := yyvsp113 + 1
	if yyvsp113 >= yyvsc113 then
		if yyvs113 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs113")
			end
			create yyspecial_routines113
			yyvsc113 := yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.make (yyvsc113)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs113")
			end
			yyvsc113 := yyvsc113 + yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.resize (yyvs113, yyvsc113)
		end
	end
	yyvs113.put (yyval113, yyvsp113)
end
when 517 then
--|#line 2849 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2849")
end

			yyval113 := yyvs113.item (yyvsp113)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs113.put (yyval113, yyvsp113)
end
when 518 then
--|#line 2856 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2856")
end

			yyval113 := ast_factory.new_when_part_list (counter_value)
			if yyval113 /= Void and yyvs112.item (yyvsp112) /= Void then
				yyval113.put_first (yyvs112.item (yyvsp112))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp112 := yyvsp112 -1
	if yyvsp113 >= yyvsc113 then
		if yyvs113 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs113")
			end
			create yyspecial_routines113
			yyvsc113 := yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.make (yyvsc113)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs113")
			end
			yyvsc113 := yyvsc113 + yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.resize (yyvs113, yyvsc113)
		end
	end
	yyvs113.put (yyval113, yyvsp113)
end
when 519 then
--|#line 2863 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2863")
end

			yyval113 := yyvs113.item (yyvsp113)
			if yyval113 /= Void and yyvs112.item (yyvsp112) /= Void then
				yyval113.put_first (yyvs112.item (yyvsp112))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 -1
	yyvs113.put (yyval113, yyvsp113)
end
when 520 then
--|#line 2872 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2872")
end

			yyval112 := ast_factory.new_when_part (yyvs40.item (yyvsp40), yyvs44.item (yyvsp44))
			if yyval112 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp40 := yyvsp40 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
when 521 then
--|#line 2881 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2881")
end

yyval40 := ast_factory.new_choice_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp40 >= yyvsc40 then
		if yyvs40 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs40")
			end
			create yyspecial_routines40
			yyvsc40 := yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.make (yyvsc40)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs40")
			end
			yyvsc40 := yyvsc40 + yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.resize (yyvs40, yyvsc40)
		end
	end
	yyvs40.put (yyval40, yyvsp40)
end
when 522 then
--|#line 2883 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2883")
end

			yyval40 := yyvs40.item (yyvsp40)
			remove_keyword
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp40 := yyvsp40 -1
	yyvsp2 := yyvsp2 -1
	yyvs40.put (yyval40, yyvsp40)
end
when 523 then
--|#line 2883 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2883")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp40 := yyvsp40 + 1
	if yyvsp40 >= yyvsc40 then
		if yyvs40 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs40")
			end
			create yyspecial_routines40
			yyvsc40 := yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.make (yyvsc40)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs40")
			end
			yyvsc40 := yyvsc40 + yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.resize (yyvs40, yyvsc40)
		end
	end
	yyvs40.put (yyval40, yyvsp40)
end
when 524 then
--|#line 2896 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2896")
end

			if yyvs37.item (yyvsp37) /= Void then
				yyval40 := ast_factory.new_choice_list (last_keyword, counter_value + 1)
				if yyval40 /= Void then
					yyval40.put_first (yyvs37.item (yyvsp37))
				end
			else
				yyval40 := ast_factory.new_choice_list (last_keyword, counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp37 := yyvsp37 -1
	if yyvsp40 >= yyvsc40 then
		if yyvs40 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs40")
			end
			create yyspecial_routines40
			yyvsc40 := yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.make (yyvsc40)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs40")
			end
			yyvsc40 := yyvsc40 + yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.resize (yyvs40, yyvsc40)
		end
	end
	yyvs40.put (yyval40, yyvsp40)
end
when 525 then
--|#line 2907 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2907")
end

			yyval40 := ast_factory.new_choice_list (last_keyword, counter_value)
			if yyval40 /= Void and yyvs39.item (yyvsp39) /= Void then
				yyval40.put_first (yyvs39.item (yyvsp39))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp39 := yyvsp39 -1
	if yyvsp40 >= yyvsc40 then
		if yyvs40 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs40")
			end
			create yyspecial_routines40
			yyvsc40 := yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.make (yyvsc40)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs40")
			end
			yyvsc40 := yyvsc40 + yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.resize (yyvs40, yyvsc40)
		end
	end
	yyvs40.put (yyval40, yyvsp40)
end
when 526 then
--|#line 2915 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2915")
end

			yyval40 := yyvs40.item (yyvsp40)
			if yyval40 /= Void and yyvs39.item (yyvsp39) /= Void then
				yyval40.put_first (yyvs39.item (yyvsp39))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp39 := yyvsp39 -1
	yyvs40.put (yyval40, yyvsp40)
end
when 527 then
--|#line 2924 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2924")
end

			yyval39 := ast_factory.new_choice_comma (yyvs37.item (yyvsp37), yyvs4.item (yyvsp4))
			if yyval39 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp39 := yyvsp39 + 1
	yyvsp37 := yyvsp37 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp39 >= yyvsc39 then
		if yyvs39 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs39")
			end
			create yyspecial_routines39
			yyvsc39 := yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.make (yyvsc39)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs39")
			end
			yyvsc39 := yyvsc39 + yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.resize (yyvs39, yyvsc39)
		end
	end
	yyvs39.put (yyval39, yyvsp39)
end
when 528 then
--|#line 2933 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2933")
end

yyval37 := yyvs38.item (yyvsp38) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp37 := yyvsp37 + 1
	yyvsp38 := yyvsp38 -1
	if yyvsp37 >= yyvsc37 then
		if yyvs37 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs37")
			end
			create yyspecial_routines37
			yyvsc37 := yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.make (yyvsc37)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs37")
			end
			yyvsc37 := yyvsc37 + yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.resize (yyvs37, yyvsc37)
		end
	end
	yyvs37.put (yyval37, yyvsp37)
end
when 529 then
--|#line 2935 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2935")
end

yyval37 := ast_factory.new_choice_range (yyvs38.item (yyvsp38 - 1), yyvs4.item (yyvsp4), yyvs38.item (yyvsp38)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp38 := yyvsp38 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp37 >= yyvsc37 then
		if yyvs37 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs37")
			end
			create yyspecial_routines37
			yyvsc37 := yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.make (yyvsc37)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs37")
			end
			yyvsc37 := yyvsc37 + yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.resize (yyvs37, yyvsc37)
		end
	end
	yyvs37.put (yyval37, yyvsp37)
end
when 530 then
--|#line 2939 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2939")
end

yyval38 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
when 531 then
--|#line 2941 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2941")
end

yyval38 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
when 532 then
--|#line 2943 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2943")
end

yyval38 := yyvs38.item (yyvsp38) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs38.put (yyval38, yyvsp38)
end
when 533 then
--|#line 2945 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2945")
end

yyval38 := yyvs36.item (yyvsp36) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp36 := yyvsp36 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
when 534 then
--|#line 2949 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2949")
end

yyval38 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
when 535 then
--|#line 2951 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2951")
end

yyval38 := yyvs106.item (yyvsp106) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp106 := yyvsp106 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
when 536 then
--|#line 2955 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2955")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
when 537 then
--|#line 2960 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2960")
end

yyval56 := ast_factory.new_debug_instruction (yyvs93.item (yyvsp93), ast_factory.new_debug_compound (yyvs2.item (yyvsp2 - 1), ast_factory.new_compound (0)), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp56 := yyvsp56 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp93 := yyvsp93 -1
	if yyvsp56 >= yyvsc56 then
		if yyvs56 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs56")
			end
			create yyspecial_routines56
			yyvsc56 := yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.make (yyvsc56)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs56")
			end
			yyvsc56 := yyvsc56 + yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.resize (yyvs56, yyvsc56)
		end
	end
	yyvs56.put (yyval56, yyvsp56)
end
when 538 then
--|#line 2962 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2962")
end

			yyval56 := ast_factory.new_debug_instruction (yyvs93.item (yyvsp93), ast_factory.new_debug_compound (yyvs2.item (yyvsp2 - 1), yyvs44.item (yyvsp44)), yyvs2.item (yyvsp2))
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp56 := yyvsp56 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp93 := yyvsp93 -1
	yyvsp1 := yyvsp1 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp56 >= yyvsc56 then
		if yyvs56 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs56")
			end
			create yyspecial_routines56
			yyvsc56 := yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.make (yyvsc56)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs56")
			end
			yyvsc56 := yyvsc56 + yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.resize (yyvs56, yyvsc56)
		end
	end
	yyvs56.put (yyval56, yyvsp56)
end
when 539 then
--|#line 2969 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2969")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp93 := yyvsp93 + 1
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
when 540 then
--|#line 2971 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2971")
end

yyval93 := ast_factory.new_manifest_string_list (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
when 541 then
--|#line 2973 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2973")
end

			yyval93 := yyvs93.item (yyvsp93)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp93 := yyvsp93 -1
	yyvsp4 := yyvsp4 -1
	yyvs93.put (yyval93, yyvsp93)
end
when 542 then
--|#line 2973 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2973")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp93 := yyvsp93 + 1
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
when 543 then
--|#line 2986 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2986")
end

			if yyvs15.item (yyvsp15) /= Void then
				yyval93 := ast_factory.new_manifest_string_list (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval93 /= Void then
					yyval93.put_first (yyvs15.item (yyvsp15))
				end
			else
				yyval93 := ast_factory.new_manifest_string_list (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
when 544 then
--|#line 2997 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2997")
end

			yyval93 := yyvs93.item (yyvsp93)
			if yyval93 /= Void and yyvs92.item (yyvsp92) /= Void then
				yyval93.put_first (yyvs92.item (yyvsp92))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp92 := yyvsp92 -1
	yyvs93.put (yyval93, yyvsp93)
end
when 545 then
--|#line 3006 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3006")
end

			yyval92 := ast_factory.new_manifest_string_comma (yyvs15.item (yyvsp15), yyvs4.item (yyvsp4))
			if yyval92 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp92 := yyvsp92 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp92 >= yyvsc92 then
		if yyvs92 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs92")
			end
			create yyspecial_routines92
			yyvsc92 := yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.make (yyvsc92)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs92")
			end
			yyvsc92 := yyvsc92 + yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.resize (yyvs92, yyvsc92)
		end
	end
	yyvs92.put (yyval92, yyvsp92)
end
when 546 then
--|#line 3017 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3017")
end

yyval83 := new_unqualified_call_instruction (yyvs12.item (yyvsp12), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 547 then
--|#line 3019 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3019")
end

yyval83 := ast_factory.new_call_instruction (yyvs61.item (yyvsp61), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 548 then
--|#line 3021 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3021")
end

yyval83 := ast_factory.new_precursor_instruction (False, yyvs3.item (yyvsp3), Void, yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 549 then
--|#line 3023 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3023")
end

yyval83 := ast_factory.new_precursor_instruction (False, yyvs3.item (yyvsp3), ast_factory.new_precursor_class_name (yyvs4.item (yyvsp4 - 1), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -2
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 550 then
--|#line 3025 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3025")
end

yyval83 := ast_factory.new_static_call_instruction (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1)), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 551 then
--|#line 3027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3027")
end

yyval83 := ast_factory.new_static_call_instruction (Void, ast_factory.new_target_type (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1)), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp83 := yyvsp83 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
when 552 then
--|#line 3031 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3031")
end

yyval61 := new_unqualified_call_expression (yyvs12.item (yyvsp12), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 553 then
--|#line 3033 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3033")
end

yyval61 := ast_factory.new_call_expression (yyvs61.item (yyvsp61), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 554 then
--|#line 3037 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3037")
end

yyval36 := ast_factory.new_call_expression (yyvs61.item (yyvsp61), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp36 := yyvsp36 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp36 >= yyvsc36 then
		if yyvs36 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs36")
			end
			create yyspecial_routines36
			yyvsc36 := yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.make (yyvsc36)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs36")
			end
			yyvsc36 := yyvsc36 + yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.resize (yyvs36, yyvsc36)
		end
	end
	yyvs36.put (yyval36, yyvsp36)
end
when 555 then
--|#line 3041 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3041")
end

yyval106 := ast_factory.new_static_call_expression (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1)), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp106 := yyvsp106 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp106 >= yyvsc106 then
		if yyvs106 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs106")
			end
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs106")
			end
			yyvsc106 := yyvsc106 + yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.resize (yyvs106, yyvsc106)
		end
	end
	yyvs106.put (yyval106, yyvsp106)
end
when 556 then
--|#line 3043 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3043")
end

yyval106 := ast_factory.new_static_call_expression (Void, ast_factory.new_target_type (yyvs4.item (yyvsp4 - 2), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4 - 1)), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp106 := yyvsp106 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp106 >= yyvsc106 then
		if yyvs106 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs106")
			end
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs106")
			end
			yyvsc106 := yyvsc106 + yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.resize (yyvs106, yyvsc106)
		end
	end
	yyvs106.put (yyval106, yyvsp106)
end
when 557 then
--|#line 3047 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3047")
end

yyval61 := ast_factory.new_precursor_expression (False, yyvs3.item (yyvsp3), Void, yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 558 then
--|#line 3049 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3049")
end

yyval61 := ast_factory.new_precursor_expression (False, yyvs3.item (yyvsp3), ast_factory.new_precursor_class_name (yyvs4.item (yyvsp4 - 1), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp61 := yyvsp61 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -2
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 559 then
--|#line 3053 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3053")
end

yyval61 := new_unqualified_call_expression (yyvs12.item (yyvsp12), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 560 then
--|#line 3055 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3055")
end

yyval61 := yyvs17.item (yyvsp17) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 561 then
--|#line 3057 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3057")
end

yyval61 := yyvs10.item (yyvsp10) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 562 then
--|#line 3059 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3059")
end

yyval61 := yyvs96.item (yyvsp96) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp96 := yyvsp96 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 563 then
--|#line 3061 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3061")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 564 then
--|#line 3063 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3063")
end

yyval61 := yyvs106.item (yyvsp106) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp106 := yyvsp106 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 565 then
--|#line 3065 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3065")
end

yyval61 := ast_factory.new_call_expression (yyvs61.item (yyvsp61), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs12.item (yyvsp12)), yyvs24.item (yyvsp24)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 566 then
--|#line 3071 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3071")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp24 := yyvsp24 + 1
	if yyvsp24 >= yyvsc24 then
		if yyvs24 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs24")
			end
			create yyspecial_routines24
			yyvsc24 := yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.make (yyvsc24)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs24")
			end
			yyvsc24 := yyvsc24 + yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.resize (yyvs24, yyvsc24)
		end
	end
	yyvs24.put (yyval24, yyvsp24)
end
when 567 then
--|#line 3073 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3073")
end

yyval24 := ast_factory.new_actual_arguments (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp24 := yyvsp24 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp24 >= yyvsc24 then
		if yyvs24 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs24")
			end
			create yyspecial_routines24
			yyvsc24 := yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.make (yyvsc24)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs24")
			end
			yyvsc24 := yyvsc24 + yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.resize (yyvs24, yyvsc24)
		end
	end
	yyvs24.put (yyval24, yyvsp24)
end
when 568 then
--|#line 3075 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3075")
end

			yyval24 := yyvs24.item (yyvsp24)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp24 := yyvsp24 -1
	yyvsp4 := yyvsp4 -1
	yyvs24.put (yyval24, yyvsp24)
end
when 569 then
--|#line 3075 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3075")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp24 := yyvsp24 + 1
	if yyvsp24 >= yyvsc24 then
		if yyvs24 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs24")
			end
			create yyspecial_routines24
			yyvsc24 := yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.make (yyvsc24)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs24")
			end
			yyvsc24 := yyvsc24 + yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.resize (yyvs24, yyvsc24)
		end
	end
	yyvs24.put (yyval24, yyvsp24)
end
when 570 then
--|#line 3088 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3088")
end

			if yyvs61.item (yyvsp61) /= Void then
				yyval24 := ast_factory.new_actual_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval24 /= Void then
					yyval24.put_first (yyvs61.item (yyvsp61))
				end
			else
				yyval24 := ast_factory.new_actual_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp24 := yyvsp24 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp24 >= yyvsc24 then
		if yyvs24 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs24")
			end
			create yyspecial_routines24
			yyvsc24 := yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.make (yyvsc24)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs24")
			end
			yyvsc24 := yyvsc24 + yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.resize (yyvs24, yyvsc24)
		end
	end
	yyvs24.put (yyval24, yyvsp24)
end
when 571 then
--|#line 3099 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3099")
end

			yyval24 := ast_factory.new_actual_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval24 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval24.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp24 := yyvsp24 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp24 >= yyvsc24 then
		if yyvs24 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs24")
			end
			create yyspecial_routines24
			yyvsc24 := yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.make (yyvsc24)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs24")
			end
			yyvsc24 := yyvsc24 + yyInitial_yyvs_size
			yyvs24 := yyspecial_routines24.resize (yyvs24, yyvsc24)
		end
	end
	yyvs24.put (yyval24, yyvsp24)
end
when 572 then
--|#line 3107 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3107")
end

			yyval24 := yyvs24.item (yyvsp24)
			if yyval24 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval24.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 -1
	yyvs24.put (yyval24, yyvsp24)
end
when 573 then
--|#line 3116 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3116")
end

			yyval62 := ast_factory.new_expression_comma (yyvs61.item (yyvsp61), yyvs4.item (yyvsp4))
			if yyval62 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
when 574 then
--|#line 3125 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3125")
end

yyval61 := ast_factory.new_feature_address (yyvs4.item (yyvsp4), yyvs68.item (yyvsp68)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp68 := yyvsp68 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 575 then
--|#line 3127 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3127")
end

yyval61 := ast_factory.new_current_address (yyvs4.item (yyvsp4), yyvs10.item (yyvsp10)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp10 := yyvsp10 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 576 then
--|#line 3129 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3129")
end

yyval61 := ast_factory.new_result_address (yyvs4.item (yyvsp4), yyvs17.item (yyvsp17)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp17 := yyvsp17 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 577 then
--|#line 3131 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3131")
end

yyval61 := ast_factory.new_expression_address (yyvs4.item (yyvsp4), yyvs96.item (yyvsp96)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp96 := yyvsp96 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 578 then
--|#line 3138 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3138")
end

yyval114 := new_writable (yyvs12.item (yyvsp12)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp114 := yyvsp114 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp114 >= yyvsc114 then
		if yyvs114 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs114")
			end
			create yyspecial_routines114
			yyvsc114 := yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.make (yyvsc114)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs114")
			end
			yyvsc114 := yyvsc114 + yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.resize (yyvs114, yyvsc114)
		end
	end
	yyvs114.put (yyval114, yyvsp114)
end
when 579 then
--|#line 3140 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3140")
end

yyval114 := yyvs17.item (yyvsp17) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp114 := yyvsp114 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp114 >= yyvsc114 then
		if yyvs114 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs114")
			end
			create yyspecial_routines114
			yyvsc114 := yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.make (yyvsc114)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs114")
			end
			yyvsc114 := yyvsc114 + yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.resize (yyvs114, yyvsc114)
		end
	end
	yyvs114.put (yyval114, yyvsp114)
end
when 580 then
--|#line 3146 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3146")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 581 then
--|#line 3148 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3148")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 582 then
--|#line 3152 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3152")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), ast_factory.new_infix_free_operator (yyvs11.item (yyvsp11)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp11 := yyvsp11 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 583 then
--|#line 3154 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3154")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), ast_factory.new_infix_plus_operator (yyvs19.item (yyvsp19)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 584 then
--|#line 3156 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3156")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), ast_factory.new_infix_minus_operator (yyvs19.item (yyvsp19)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 585 then
--|#line 3158 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3158")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 586 then
--|#line 3160 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3160")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 587 then
--|#line 3162 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3162")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 588 then
--|#line 3164 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3164")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 589 then
--|#line 3166 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3166")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 590 then
--|#line 3168 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3168")
end

yyval61 := ast_factory.new_equality_expression (yyvs61.item (yyvsp61 - 1), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 591 then
--|#line 3170 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3170")
end

yyval61 := ast_factory.new_equality_expression (yyvs61.item (yyvsp61 - 1), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 592 then
--|#line 3172 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3172")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 593 then
--|#line 3174 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3174")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 594 then
--|#line 3176 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3176")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 595 then
--|#line 3178 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3178")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 596 then
--|#line 3180 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3180")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs14.item (yyvsp14), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp14 := yyvsp14 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 597 then
--|#line 3182 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3182")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs14.item (yyvsp14), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp14 := yyvsp14 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 598 then
--|#line 3184 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3184")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs14.item (yyvsp14), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp14 := yyvsp14 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 599 then
--|#line 3186 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3186")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), ast_factory.new_infix_and_then_operator (yyvs14.item (yyvsp14), yyvs2.item (yyvsp2)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp61 := yyvsp61 -1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 600 then
--|#line 3188 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3188")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), ast_factory.new_infix_or_else_operator (yyvs14.item (yyvsp14), yyvs2.item (yyvsp2)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp61 := yyvsp61 -1
	yyvsp14 := yyvsp14 -1
	yyvsp2 := yyvsp2 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 601 then
--|#line 3190 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3190")
end

yyval61 := ast_factory.new_infix_expression (yyvs61.item (yyvsp61 - 1), yyvs14.item (yyvsp14), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp14 := yyvsp14 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 602 then
--|#line 3192 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3192")
end

yyval61 := edp_ast_factory.new_assign_check (yyvs114.item (yyvsp114), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp114 := yyvsp114 -1
	yyvsp4 := yyvsp4 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 603 then
--|#line 3194 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3194")
end

yyval61 := edp_ast_factory.new_assign_type_check (yyvs108.item (yyvsp108), yyvs4.item (yyvsp4), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 -1
	yyvsp4 := yyvsp4 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 604 then
--|#line 3198 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3198")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 605 then
--|#line 3200 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3200")
end

yyval61 := yyvs34.item (yyvsp34) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp34 := yyvsp34 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 606 then
--|#line 3202 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3202")
end

yyval61 := yyvs53.item (yyvsp53) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp53 := yyvsp53 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 607 then
--|#line 3204 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3204")
end

yyval61 := yyvs94.item (yyvsp94) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp94 := yyvsp94 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 608 then
--|#line 3206 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3206")
end

yyval61 := new_prefix_plus_expression (yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 609 then
--|#line 3208 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3208")
end

yyval61 := new_prefix_minus_expression (yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 610 then
--|#line 3211 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3211")
end

yyval61 := ast_factory.new_prefix_expression (yyvs19.item (yyvsp19), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 611 then
--|#line 3214 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3214")
end

yyval61 := ast_factory.new_prefix_expression (yyvs14.item (yyvsp14), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 612 then
--|#line 3216 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3216")
end

yyval61 := ast_factory.new_prefix_expression (ast_factory.new_prefix_free_operator (yyvs11.item (yyvsp11)), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 613 then
--|#line 3218 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3218")
end

yyval61 := ast_factory.new_old_expression (yyvs2.item (yyvsp2), yyvs61.item (yyvsp61)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs61.put (yyval61, yyvsp61)
end
when 614 then
--|#line 3222 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3222")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 615 then
--|#line 3224 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3224")
end

yyval61 := yyvs106.item (yyvsp106) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp106 := yyvsp106 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 616 then
--|#line 3226 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3226")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 617 then
--|#line 3228 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3228")
end

yyval61 := yyvs17.item (yyvsp17) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 618 then
--|#line 3230 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3230")
end

yyval61 := yyvs10.item (yyvsp10) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 619 then
--|#line 3232 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3232")
end

yyval61 := yyvs96.item (yyvsp96) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp96 := yyvsp96 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 620 then
--|#line 3234 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3234")
end

yyval61 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 621 then
--|#line 3236 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3236")
end

yyval61 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 622 then
--|#line 3238 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3238")
end

yyval61 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 623 then
--|#line 3240 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3240")
end

yyval61 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 624 then
--|#line 3242 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3242")
end

yyval61 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 625 then
--|#line 3244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3244")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 626 then
--|#line 3248 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3248")
end

yyval61 := yyvs35.item (yyvsp35) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp35 := yyvsp35 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 627 then
--|#line 3250 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3250")
end

yyval61 := yyvs20.item (yyvsp20) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp20 := yyvsp20 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 628 then
--|#line 3252 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3252")
end

yyval61 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 629 then
--|#line 3254 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3254")
end

yyval61 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 630 then
--|#line 3256 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3256")
end

yyval61 := ast_factory.new_once_manifest_string (yyvs2.item (yyvsp2), yyvs15.item (yyvsp15)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp15 := yyvsp15 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 631 then
--|#line 3271 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3271")
end

yyval61 := yyvs6.item (yyvsp6) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 632 then
--|#line 3273 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3273")
end

yyval61 := yyvs91.item (yyvsp91) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp91 := yyvsp91 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 633 then
--|#line 3275 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3275")
end

yyval61 := yyvs91.item (yyvsp91) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp91 := yyvsp91 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 634 then
--|#line 3277 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3277")
end

yyval61 := yyvs107.item (yyvsp107) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp107 := yyvsp107 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 635 then
--|#line 3279 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3279")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
when 636 then
--|#line 3283 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3283")
end

			yyval34 := ast_factory.new_bracket_expression (yyvs61.item (yyvsp61), yyvs22.item (yyvsp22), yyvs33.item (yyvsp33))
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp61 := yyvsp61 -1
	yyvsp22 := yyvsp22 -1
	yyvsp33 := yyvsp33 -1
	yyvs34.put (yyval34, yyvsp34)
end
when 637 then
--|#line 3283 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3283")
end

			add_symbol (yyvs22.item (yyvsp22))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp34 := yyvsp34 + 1
	if yyvsp34 >= yyvsc34 then
		if yyvs34 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs34")
			end
			create yyspecial_routines34
			yyvsc34 := yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.make (yyvsc34)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs34")
			end
			yyvsc34 := yyvsc34 + yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.resize (yyvs34, yyvsc34)
		end
	end
	yyvs34.put (yyval34, yyvsp34)
end
when 638 then
--|#line 3296 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3296")
end

			if yyvs61.item (yyvsp61) /= Void then
				yyval33 := ast_factory.new_bracket_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval33 /= Void then
					yyval33.put_first (yyvs61.item (yyvsp61))
				end
			else
				yyval33 := ast_factory.new_bracket_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp33 := yyvsp33 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp33 >= yyvsc33 then
		if yyvs33 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs33")
			end
			create yyspecial_routines33
			yyvsc33 := yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.make (yyvsc33)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs33")
			end
			yyvsc33 := yyvsc33 + yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.resize (yyvs33, yyvsc33)
		end
	end
	yyvs33.put (yyval33, yyvsp33)
end
when 639 then
--|#line 3307 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3307")
end

			yyval33 := ast_factory.new_bracket_arguments (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval33 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval33.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp33 := yyvsp33 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp33 >= yyvsc33 then
		if yyvs33 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs33")
			end
			create yyspecial_routines33
			yyvsc33 := yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.make (yyvsc33)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs33")
			end
			yyvsc33 := yyvsc33 + yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.resize (yyvs33, yyvsc33)
		end
	end
	yyvs33.put (yyval33, yyvsp33)
end
when 640 then
--|#line 3315 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3315")
end

			yyval33 := yyvs33.item (yyvsp33)
			if yyval33 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval33.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 -1
	yyvs33.put (yyval33, yyvsp33)
end
when 641 then
--|#line 3324 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3324")
end

yyval96 := ast_factory.new_parenthesized_expression (yyvs4.item (yyvsp4 - 1), yyvs61.item (yyvsp61), yyvs4.item (yyvsp4)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp96 := yyvsp96 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp61 := yyvsp61 -1
	if yyvsp96 >= yyvsc96 then
		if yyvs96 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs96")
			end
			create yyspecial_routines96
			yyvsc96 := yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.make (yyvsc96)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs96")
			end
			yyvsc96 := yyvsc96 + yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.resize (yyvs96, yyvsc96)
		end
	end
	yyvs96.put (yyval96, yyvsp96)
end
when 642 then
--|#line 3328 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3328")
end

yyval61 := ast_factory.new_manifest_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
when 643 then
--|#line 3332 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3332")
end

			yyval91 := yyvs91.item (yyvsp91)
			-- TODO
			-- Set type of array
			-- Set lower index of array
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -3
	yyvsp108 := yyvsp108 -1
	yyvsp13 := yyvsp13 -1
	yyvs91.put (yyval91, yyvsp91)
end
when 644 then
--|#line 3339 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3339")
end

			yyval91 := yyvs91.item (yyvsp91)
			-- TODO
			-- Set type of array
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvs91.put (yyval91, yyvsp91)
end
when 645 then
--|#line 3347 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3347")
end

yyval91 := ast_factory.new_manifest_array (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp91 := yyvsp91 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
when 646 then
--|#line 3349 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3349")
end

			yyval91 := yyvs91.item (yyvsp91)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp91 := yyvsp91 -1
	yyvsp4 := yyvsp4 -1
	yyvs91.put (yyval91, yyvsp91)
end
when 647 then
--|#line 3349 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3349")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp91 := yyvsp91 + 1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
when 648 then
--|#line 3362 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3362")
end

			if yyvs61.item (yyvsp61) /= Void then
				yyval91 := ast_factory.new_manifest_array (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval91 /= Void then
					yyval91.put_first (yyvs61.item (yyvsp61))
				end
			else
				yyval91 := ast_factory.new_manifest_array (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp91 := yyvsp91 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
when 649 then
--|#line 3373 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3373")
end

			yyval91 := ast_factory.new_manifest_array (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval91 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval91.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp91 := yyvsp91 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
when 650 then
--|#line 3381 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3381")
end

			yyval91 := yyvs91.item (yyvsp91)
			if yyval91 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval91.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 -1
	yyvs91.put (yyval91, yyvsp91)
end
when 651 then
--|#line 3390 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3390")
end

yyval94 := ast_factory.new_manifest_tuple (yyvs22.item (yyvsp22), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp94 >= yyvsc94 then
		if yyvs94 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs94")
			end
			create yyspecial_routines94
			yyvsc94 := yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.make (yyvsc94)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs94")
			end
			yyvsc94 := yyvsc94 + yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.resize (yyvs94, yyvsc94)
		end
	end
	yyvs94.put (yyval94, yyvsp94)
end
when 652 then
--|#line 3392 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3392")
end

			yyval94 := yyvs94.item (yyvsp94)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp94 := yyvsp94 -1
	yyvsp22 := yyvsp22 -1
	yyvs94.put (yyval94, yyvsp94)
end
when 653 then
--|#line 3392 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3392")
end

			add_symbol (yyvs22.item (yyvsp22))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp94 := yyvsp94 + 1
	if yyvsp94 >= yyvsc94 then
		if yyvs94 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs94")
			end
			create yyspecial_routines94
			yyvsc94 := yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.make (yyvsc94)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs94")
			end
			yyvsc94 := yyvsc94 + yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.resize (yyvs94, yyvsc94)
		end
	end
	yyvs94.put (yyval94, yyvsp94)
end
when 654 then
--|#line 3405 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3405")
end

			if yyvs61.item (yyvsp61) /= Void then
				yyval94 := ast_factory.new_manifest_tuple (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval94 /= Void then
					yyval94.put_first (yyvs61.item (yyvsp61))
				end
			else
				yyval94 := ast_factory.new_manifest_tuple (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp94 >= yyvsc94 then
		if yyvs94 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs94")
			end
			create yyspecial_routines94
			yyvsc94 := yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.make (yyvsc94)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs94")
			end
			yyvsc94 := yyvsc94 + yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.resize (yyvs94, yyvsc94)
		end
	end
	yyvs94.put (yyval94, yyvsp94)
end
when 655 then
--|#line 3416 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3416")
end

			yyval94 := ast_factory.new_manifest_tuple (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval94 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval94.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp94 >= yyvsc94 then
		if yyvs94 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs94")
			end
			create yyspecial_routines94
			yyvsc94 := yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.make (yyvsc94)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs94")
			end
			yyvsc94 := yyvsc94 + yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.resize (yyvs94, yyvsc94)
		end
	end
	yyvs94.put (yyval94, yyvsp94)
end
when 656 then
--|#line 3424 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3424")
end

			yyval94 := yyvs94.item (yyvsp94)
			if yyval94 /= Void and yyvs62.item (yyvsp62) /= Void then
				yyval94.put_first (yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 -1
	yyvs94.put (yyval94, yyvsp94)
end
when 657 then
--|#line 3433 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3433")
end

yyval107 := ast_factory.new_strip_expression (yyvs2.item (yyvsp2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp107 := yyvsp107 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
when 658 then
--|#line 3435 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3435")
end

			yyval107 := yyvs107.item (yyvsp107)
			remove_keyword
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp107 := yyvsp107 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvs107.put (yyval107, yyvsp107)
end
when 659 then
--|#line 3435 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3435")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp107 := yyvsp107 + 1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
when 660 then
--|#line 3450 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3450")
end

			if yyvs68.item (yyvsp68) /= Void then
				yyval107 := ast_factory.new_strip_expression (last_keyword, last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval107 /= Void then
					yyval107.put_first (yyvs68.item (yyvsp68))
				end
			else
				yyval107 := ast_factory.new_strip_expression (last_keyword, last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp107 := yyvsp107 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
when 661 then
--|#line 3461 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3461")
end

			yyval107 := ast_factory.new_strip_expression (last_keyword, last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval107 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval107.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp107 := yyvsp107 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
when 662 then
--|#line 3469 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3469")
end

			yyval107 := yyvs107.item (yyvsp107)
			if yyval107 /= Void and yyvs69.item (yyvsp69) /= Void then
				yyval107.put_first (yyvs69.item (yyvsp69))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 -1
	yyvs107.put (yyval107, yyvsp107)
end
when 663 then
--|#line 3478 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3478")
end

yyval45 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
when 664 then
--|#line 3480 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3480")
end

yyval45 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
when 665 then
--|#line 3482 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3482")
end

yyval45 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
when 666 then
--|#line 3484 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3484")
end

yyval45 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
when 667 then
--|#line 3486 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3486")
end

yyval45 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
when 668 then
--|#line 3488 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3488")
end

yyval45 := yyvs6.item (yyvsp6) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
when 669 then
--|#line 3494 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3494")
end

yyval35 := ast_factory.new_call_agent (yyvs2.item (yyvsp2), Void, yyvs68.item (yyvsp68), yyvs29.item (yyvsp29)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp35 := yyvsp35 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp68 := yyvsp68 -1
	yyvsp29 := yyvsp29 -1
	if yyvsp35 >= yyvsc35 then
		if yyvs35 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs35")
			end
			create yyspecial_routines35
			yyvsc35 := yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.make (yyvsc35)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs35")
			end
			yyvsc35 := yyvsc35 + yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.resize (yyvs35, yyvsc35)
		end
	end
	yyvs35.put (yyval35, yyvsp35)
end
when 670 then
--|#line 3496 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3496")
end

yyval35 := ast_factory.new_call_agent (yyvs2.item (yyvsp2), yyvs30.item (yyvsp30), ast_factory.new_dot_feature_name (yyvs4.item (yyvsp4), yyvs68.item (yyvsp68)), yyvs29.item (yyvsp29)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp35 := yyvsp35 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp30 := yyvsp30 -1
	yyvsp4 := yyvsp4 -1
	yyvsp68 := yyvsp68 -1
	yyvsp29 := yyvsp29 -1
	if yyvsp35 >= yyvsc35 then
		if yyvs35 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs35")
			end
			create yyspecial_routines35
			yyvsc35 := yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.make (yyvsc35)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs35")
			end
			yyvsc35 := yyvsc35 + yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.resize (yyvs35, yyvsc35)
		end
	end
	yyvs35.put (yyval35, yyvsp35)
end
when 671 then
--|#line 3514 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3514")
end

yyval30 := new_agent_identifier_target (yyvs12.item (yyvsp12)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
when 672 then
--|#line 3516 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3516")
end

yyval30 := yyvs96.item (yyvsp96) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp96 := yyvsp96 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
when 673 then
--|#line 3518 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3518")
end

yyval30 := yyvs17.item (yyvsp17) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
when 674 then
--|#line 3520 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3520")
end

yyval30 := yyvs10.item (yyvsp10) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
when 675 then
--|#line 3522 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3522")
end

yyval30 := ast_factory.new_agent_open_target (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp30 := yyvsp30 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
when 676 then
--|#line 3526 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3526")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp29 := yyvsp29 + 1
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
when 677 then
--|#line 3528 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3528")
end

yyval29 := ast_factory.new_agent_argument_operands (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), 0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
when 678 then
--|#line 3530 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3530")
end

			yyval29 := yyvs29.item (yyvsp29)
			remove_symbol
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 -1
	yyvsp4 := yyvsp4 -1
	yyvs29.put (yyval29, yyvsp29)
end
when 679 then
--|#line 3530 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3530")
end

			add_symbol (yyvs4.item (yyvsp4))
			add_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp29 := yyvsp29 + 1
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
when 680 then
--|#line 3543 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3543")
end

			if yyvs27.item (yyvsp27) /= Void then
				yyval29 := ast_factory.new_agent_argument_operands (last_symbol, yyvs4.item (yyvsp4), counter_value + 1)
				if yyval29 /= Void then
					yyval29.put_first (yyvs27.item (yyvsp27))
				end
			else
				yyval29 := ast_factory.new_agent_argument_operands (last_symbol, yyvs4.item (yyvsp4), counter_value)
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 + 1
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
when 681 then
--|#line 3554 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3554")
end

			yyval29 := ast_factory.new_agent_argument_operands (last_symbol, yyvs4.item (yyvsp4), counter_value)
			if yyval29 /= Void and yyvs28.item (yyvsp28) /= Void then
				yyval29.put_first (yyvs28.item (yyvsp28))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 + 1
	yyvsp28 := yyvsp28 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
when 682 then
--|#line 3562 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3562")
end

			yyval29 := yyvs29.item (yyvsp29)
			if yyval29 /= Void and yyvs28.item (yyvsp28) /= Void then
				yyval29.put_first (yyvs28.item (yyvsp28))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 -1
	yyvs29.put (yyval29, yyvsp29)
end
when 683 then
--|#line 3571 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3571")
end

			yyval28 := ast_factory.new_agent_argument_operand_comma (yyvs27.item (yyvsp27), yyvs4.item (yyvsp4))
			if yyval28 /= Void then
				increment_counter
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
when 684 then
--|#line 3580 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3580")
end

yyval27 := yyvs61.item (yyvsp61) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
when 685 then
--|#line 3582 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3582")
end

yyval27 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp23 := yyvsp23 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
when 686 then
--|#line 3584 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3584")
end

yyval27 := ast_factory.new_agent_typed_open_argument (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4), yyvs23.item (yyvsp23)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp27 := yyvsp27 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvsp23 := yyvsp23 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
when 687 then
--|#line 3590 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3590")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 688 then
--|#line 3592 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3592")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 689 then
--|#line 3594 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3594")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 690 then
--|#line 3596 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3596")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 691 then
--|#line 3598 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3598")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 692 then
--|#line 3600 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3600")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 693 then
--|#line 3602 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3602")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 694 then
--|#line 3604 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3604")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 695 then
--|#line 3606 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3606")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 696 then
--|#line 3608 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3608")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 697 then
--|#line 3610 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3610")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 698 then
--|#line 3612 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3612")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 699 then
--|#line 3614 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3614")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 700 then
--|#line 3616 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3616")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 701 then
--|#line 3618 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3618")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 702 then
--|#line 3620 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3620")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 703 then
--|#line 3622 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3622")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 704 then
--|#line 3624 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3624")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 705 then
--|#line 3626 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3626")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 706 then
--|#line 3628 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3628")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 707 then
--|#line 3630 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3630")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 708 then
--|#line 3632 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3632")
end

yyval15 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs15.put (yyval15, yyvsp15)
end
when 709 then
--|#line 3634 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3634")
end

abort 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp15 := yyvsp15 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp15 >= yyvsc15 then
		if yyvs15 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs15")
			end
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs15")
			end
			yyvsc15 := yyvsc15 + yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
		end
	end
	yyvs15.put (yyval15, yyvsp15)
end
when 710 then
--|#line 3638 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3638")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs9.put (yyval9, yyvsp9)
end
when 711 then
--|#line 3640 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3640")
end

abort 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
when 712 then
--|#line 3644 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3644")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs7.put (yyval7, yyvsp7)
end
when 713 then
--|#line 3646 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3646")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs7.put (yyval7, yyvsp7)
end
when 714 then
--|#line 3650 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3650")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
when 715 then
--|#line 3652 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3652")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
when 716 then
--|#line 3656 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3656")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
when 717 then
--|#line 3658 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3658")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
when 718 then
--|#line 3662 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3662")
end

			yyval13 := yyvs13.item (yyvsp13)
			yyval13.set_sign (yyvs19.item (yyvsp19))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs13.put (yyval13, yyvsp13)
end
when 719 then
--|#line 3667 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3667")
end

			yyval13 := yyvs13.item (yyvsp13)
			yyval13.set_sign (yyvs19.item (yyvsp19))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs13.put (yyval13, yyvsp13)
end
when 720 then
--|#line 3674 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3674")
end

			yyval13 := yyvs13.item (yyvsp13)
			yyval13.set_cast_type (ast_factory.new_target_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvs13.put (yyval13, yyvsp13)
end
when 721 then
--|#line 3679 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3679")
end

yyval13 := yyvs13.item (yyvsp13)
			yyval13.set_cast_type (ast_factory.new_target_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)))
			-- XXX Can the 'new_target_type' span the integer
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvs13.put (yyval13, yyvsp13)
end
when 722 then
--|#line 3687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3687")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
when 723 then
--|#line 3689 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3689")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
when 724 then
--|#line 3693 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3693")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
when 725 then
--|#line 3695 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3695")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
when 726 then
--|#line 3699 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3699")
end

			yyval16 := yyvs16.item (yyvsp16)
			yyval16.set_sign (yyvs19.item (yyvsp19))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs16.put (yyval16, yyvsp16)
end
when 727 then
--|#line 3704 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3704")
end

			yyval16 := yyvs16.item (yyvsp16)
			yyval16.set_sign (yyvs19.item (yyvsp19))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 -1
	yyvs16.put (yyval16, yyvsp16)
end
when 728 then
--|#line 3711 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3711")
end

			yyval16 := yyvs16.item (yyvsp16)
			yyval16.set_cast_type (ast_factory.new_target_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvs16.put (yyval16, yyvsp16)
end
when 729 then
--|#line 3716 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3716")
end

			yyval16 := yyvs16.item (yyvsp16)
			yyval16.set_cast_type (ast_factory.new_target_type (yyvs4.item (yyvsp4 - 1), yyvs108.item (yyvsp108), yyvs4.item (yyvsp4)))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -2
	yyvsp108 := yyvsp108 -1
	yyvs16.put (yyval16, yyvsp16)
end
when 730 then
--|#line 3723 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3723")
end

yyval12 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
when 731 then
--|#line 3725 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3725")
end

yyval12 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
when 732 then
--|#line 3727 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3727")
end

				-- TO DO: reserved word `BIT'
			yyval12 := yyvs12.item (yyvsp12)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
when 733 then
--|#line 3736 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3736")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 1217 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,  131,    2,    2,  129,    2,    2,    2,
			  124,  125,  116,  133,  127,  132,  130,  109,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,  126,  137,
			  113,  135,  111,  139,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,  138,    2,  128,  115,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,  122,    2,  123,  134,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,

			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  110,  112,  114,  117,  118,  119,
			  120,  121,  136, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			    0,  341,  341,  172,  342,  342,  171,  171,  171,  171,
			  171,  171,  171,  171,  343,  253,  253,  344,  254,  254,
			  255,  255,  255,  345,  255,  346,  256,  258,  258,  257,
			  257,  261,  261,  259,  259,  259,  259,  259,  259,  259,
			  259,  259,  260,  170,  170,  170,  170,  273,  273,  274,
			  274,  248,  248,  248,  348,  249,  249,  247,  246,  246,
			  246,  246,  246,  246,  246,  246,  246,  196,  196,  349,
			  197,  197,  197,  198,  198,  198,  198,  198,  198,  198,
			  198,  199,  199,  199,  199,  199,  199,  199,  199,  191,
			  191,  190,  190,  192,  192,  192,  192,  187,  194,  194,

			  193,  193,  193,  195,  195,  195,  195,  195,  195,  188,
			  189,  299,  299,  299,  304,  304,  304,  304,  305,  305,
			  352,  352,  352,  352,  339,  339,  339,  339,  337,  337,
			  337,  337,  338,  338,  338,  338,  306,  306,  306,  306,
			  306,  307,  307,  307,  307,  301,  301,  301,  301,  301,
			  301,  302,  303,  303,  320,  320,  353,  321,  321,  321,
			  318,  319,  216,  216,  354,  217,  217,  218,  218,  355,
			  215,  215,  215,  356,  215,  236,  236,  236,  175,  357,
			  175,  176,  176,  176,  176,  173,  174,  280,  280,  358,
			  281,  281,  278,  278,  359,  279,  279,  276,  276,  360,

			  277,  277,  275,  275,  275,  238,  209,  209,  208,  210,
			  210,  361,  206,  206,  206,  362,  206,  363,  206,  206,
			  206,  364,  206,  365,  207,  207,  207,  239,  202,  202,
			  203,  366,  204,  204,  204,  201,  200,  200,  330,  330,
			  367,  331,  331,  329,  234,  234,  233,  235,  235,  231,
			  231,  232,  232,  368,  368,  368,  368,  312,  312,  312,
			  312,  312,  312,  310,  310,  310,  310,  310,  310,  313,
			  313,  313,  313,  313,  313,  313,  313,  313,  313,  313,
			  311,  311,  311,  311,  311,  311,  311,  311,  322,  322,
			  230,  230,  157,  157,  237,  237,  237,  237,  237,  237,

			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  229,  229,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  244,
			  244,  369,  245,  245,  245,  245,  245,  245,  241,  240,
			  242,  243,  287,  287,  287,  370,  288,  288,  288,  288,
			  288,  288,  284,  283,  285,  286,  371,  371,  371,  371,
			  371,  371,  371,  371,  309,  309,  309,  309,  309,  308,

			  308,  308,  308,  308,  272,  272,  271,  271,  290,  290,
			  289,  289,  332,  332,  332,  332,  178,  178,  326,  326,
			  327,  327,  327,  327,  327,  327,  327,  327,  328,  328,
			  328,  328,  328,  328,  328,  328,  251,  145,  145,  147,
			  147,  350,  146,  146,  146,  146,  351,  142,  148,  148,
			  149,  149,  149,  150,  150,  150,  150,  150,  150,  143,
			  144,  282,  282,  179,  179,  180,  180,  181,  181,  182,
			  182,  183,  183,  184,  184,  185,  185,  177,  177,  372,
			  263,  263,  263,  263,  263,  263,  263,  263,  263,  263,
			  263,  263,  263,  263,  263,  263,  264,  264,  264,  264,

			  266,  266,  266,  266,  205,  205,  252,  252,  252,  252,
			  213,  214,  214,  212,  262,  262,  335,  335,  334,  334,
			  333,  168,  168,  373,  169,  169,  169,  167,  164,  164,
			  165,  165,  165,  165,  165,  165,  166,  211,  211,  296,
			  296,  296,  374,  295,  295,  294,  265,  265,  265,  265,
			  265,  265,  224,  224,  162,  323,  323,  221,  221,  220,
			  220,  220,  220,  220,  220,  220,  140,  140,  140,  375,
			  141,  141,  141,  228,  223,  223,  223,  223,  336,  336,
			  219,  219,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,

			  226,  226,  226,  226,  227,  227,  227,  227,  227,  227,
			  227,  227,  227,  227,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  160,  376,  159,  159,
			  159,  300,  222,  340,  340,  291,  291,  377,  292,  292,
			  292,  297,  297,  378,  298,  298,  298,  324,  324,  379,
			  325,  325,  325,  186,  186,  186,  186,  186,  186,  161,
			  161,  155,  155,  155,  155,  155,  153,  153,  153,  380,
			  154,  154,  154,  152,  151,  151,  151,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,

			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  163,  163,  158,  158,  267,  267,  269,  269,  270,  270,
			  268,  268,  314,  314,  316,  316,  317,  317,  315,  315,
			  250,  250,  250,  347, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			    1,    8,    2,   41,   77,   77,   41,   77,    2,   41,
			   41,    2,   77,   78,   78,    1,   22,   75,    2,    2,
			    2,    2,    2,   21,   77,   21,   77,   19,   19,    5,
			    5,   16,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   13,   12,   12,   12,    9,    7,
			    7,    6,    2,    7,    9,   53,   12,   78,   79,   80,
			   81,   13,   13,   15,   16,   16,    4,   75,    2,   95,
			    2,    2,    2,    2,   77,   77,   16,   13,   16,   13,
			    4,   22,    2,   94,    4,    4,   12,   81,    2,    2,

			   73,   74,   75,   12,    2,   15,    2,    2,   99,   99,
			    2,    1,    2,    2,    2,   12,   12,   12,   12,    2,
			    2,    2,    2,   12,   86,  108,  108,    4,   94,    2,
			   81,   12,   12,    4,    4,   75,    4,   15,    4,   55,
			    1,    2,    2,   52,   55,   66,   77,   84,    1,    1,
			    2,    2,   12,   97,   97,   98,   99,   99,   99,   99,
			    2,   12,   12,   12,   22,   26,   26,    1,   19,   19,
			   12,   13,   12,   12,   12,   10,   12,   22,   26,    1,
			    4,   19,   19,   19,    4,    4,    4,    2,   20,   17,
			   16,   14,   13,   12,   12,   12,   11,   10,    6,    4,

			    3,    2,    2,    2,    2,    7,   34,   35,    9,   53,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   62,
			   12,   13,   91,   15,   94,   94,   96,   16,  106,  107,
			  108,  114,   91,    4,    4,   12,   12,    2,    2,    2,
			   49,   12,   86,    4,   12,   52,   52,    2,    2,   54,
			   55,   52,   61,   12,    1,   66,   66,    1,   52,   84,
			   84,    2,    1,   77,    2,   55,   65,   65,   66,    4,
			   26,   26,   21,   99,   99,   99,   99,   21,   99,   99,
			   99,   99,   99,   99,   99,   99,   97,   97,   98,   99,
			   99,    4,   12,   12,   12,    2,    2,    2,   25,   25,

			   25,   26,   26,   12,   12,   86,  108,  108,   26,   26,
			   26,    4,   12,   12,   12,   26,    4,   17,   61,   12,
			   61,   61,   17,   10,    2,    2,   68,   12,   96,   61,
			  108,   61,   61,   61,    4,   91,    4,    4,   24,    4,
			   15,    4,    4,   17,   10,   30,   68,   12,   96,    4,
			    4,   19,   19,    4,    4,   19,   19,   19,   19,   19,
			   19,   19,   19,   19,   14,   14,   14,   14,   11,    4,
			   22,    4,   94,   24,    4,    4,   49,   49,   22,   47,
			   47,    1,   12,   13,   12,   12,   12,    2,   48,   22,
			   47,   47,    1,    4,   66,    4,   43,   54,   43,   54,

			   55,   50,   51,   52,   68,   21,    4,   61,   12,   84,
			   66,   77,    1,   41,    2,   43,   66,    2,   63,   68,
			   12,  102,  102,  103,  103,    1,    4,   12,    2,    2,
			    2,    2,    2,    2,   60,   85,   85,   85,  105,    4,
			   26,    4,   12,   13,    4,   12,   12,   12,   26,   12,
			   12,   12,   26,   26,    4,   26,    4,    4,    4,    4,
			   12,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,

			   15,    4,    4,   13,   13,   91,   16,   61,   62,   91,
			    4,   24,   12,    4,  107,  108,  108,    4,    4,   29,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,    2,   61,    2,   61,   61,
			   12,   34,   61,   61,   48,   48,    4,   12,   12,   12,
			    2,    2,    2,   46,   46,   46,   47,   47,   49,   49,
			   12,   12,   86,   47,   47,   47,    2,   48,    4,   12,
			   12,   12,   47,   84,    4,   43,   54,   54,   69,   12,
			   54,   54,   55,    4,   52,    4,    4,   21,   21,    4,
			   77,   84,    2,   41,    1,    1,   63,  102,  103,    4,

			    4,    4,    2,   72,  102,  103,    2,   31,  102,  103,
			    4,   85,   85,  105,   85,   60,   85,   85,    2,   85,
			   85,   85,   85,   60,   60,    1,    1,    1,   26,   26,
			   26,    4,    4,  108,    1,    1,   24,    4,   13,   16,
			    4,    4,    4,    4,    4,    4,   91,   24,   61,   62,
			    4,   68,   69,  107,    4,    4,   68,    4,   29,   61,
			   61,   24,   33,   61,   62,    4,   47,    4,   12,   13,
			    4,   12,   12,   12,   47,   12,   12,   12,   47,   47,
			    4,    4,    4,   47,   48,   69,   12,    4,    4,   77,
			   42,   42,   43,   12,   54,   54,    4,   54,    4,  110,

			  110,   21,    2,   77,    1,    1,    4,  102,  103,  102,
			  103,  108,    4,   72,   77,    4,    2,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   68,
			   69,   85,   85,   68,  104,  104,  105,   85,   21,   43,
			   59,   60,   85,   85,    2,   85,   26,   26,   26,   26,
			   26,    1,    1,   21,    4,   12,   91,    4,    4,   24,
			   24,    4,    4,    4,  107,    4,   29,   23,    4,   27,
			   28,   29,   61,    4,    4,   33,    1,    1,    1,   47,
			   47,   47,    4,    4,   49,    2,   48,    2,    1,    1,

			    2,    4,   43,    4,   43,    4,    4,  110,    4,    1,
			    2,    1,  102,  103,    2,   32,   70,   70,   71,   71,
			   72,   12,   95,  108,   77,   85,    2,  105,    2,   59,
			   60,   85,    2,   85,   24,    4,   12,  108,    4,    4,
			    4,   29,   47,   47,   47,   47,   47,    1,    1,   21,
			    4,    1,  108,  109,  110,    1,    1,   68,   21,    2,
			   21,   72,   72,    4,   72,    4,   72,    4,    4,    2,
			  101,   32,   95,   63,   67,   68,   69,   60,    2,   85,
			   24,    4,    1,    4,    4,  110,    1,    4,    6,    2,
			    7,    9,   45,   77,   13,   13,   13,   15,   16,   16,

			   16,  108,    2,    1,    2,    2,    2,   89,    2,  101,
			    4,   67,    2,   23,  108,   21,   21,   95,   21,    1,
			    2,  100,   89,   15,    2,    2,   44,   44,   77,    2,
			    2,   89,    4,  101,    2,    1,    2,   12,   87,   87,
			   88,   88,   89,    2,   64,    1,    1,  100,  100,   95,
			  100,   15,   44,   44,    2,    2,   89,    1,   21,    4,
			    4,   89,   89,   89,   89,   15,  100,   21,    4,    4,
			   18,    3,    2,    2,    2,    2,    2,    2,    2,   34,
			   36,   44,   44,   56,   61,   61,   12,   76,   82,   83,
			   83,   83,   83,  114,   44,    2,   44,   44,   44,  101,

			    2,   64,  100,  100,  100,   15,   44,   44,  108,    2,
			    4,  108,  108,    4,   24,   61,   61,    1,    4,    4,
			   93,    4,   17,   12,  114,    2,    1,    4,    4,    2,
			   90,   90,    4,   24,   44,    4,    4,    4,    1,    2,
			    2,    2,    2,   89,   21,  100,   44,   44,    2,   64,
			  100,  100,   21,   21,  114,    4,    4,   12,  113,    1,
			    2,   44,   44,  108,    4,   93,    2,    1,  108,    4,
			    2,   61,   61,    1,    2,  111,   12,   44,   61,   61,
			   61,   44,   21,   21,  100,   15,   44,   44,    2,    2,
			    2,   21,  100,   44,   44,    4,  114,    4,    4,    2,

			    2,   44,    2,   40,  112,  113,    1,    2,   44,   58,
			    1,    4,   15,   92,   93,   44,    4,   12,   61,   12,
			    2,   24,    2,   64,  100,  100,   21,   21,   21,    2,
			    2,    2,   12,    4,   12,   24,    1,    2,   40,   44,
			  113,   44,    2,    2,   44,    2,   57,   58,    4,    4,
			    4,   93,    2,  114,   24,    4,   61,   21,  100,   44,
			   44,   21,   21,   21,   24,   12,   24,   44,    4,   17,
			   10,   36,    9,   37,   38,   38,   39,   40,   61,   61,
			   12,   13,   15,   96,  106,    2,   61,   58,   12,    4,
			   61,    2,   44,    2,    2,    2,   24,  108,    4,    4,

			   40,    4,   24,   44,   24,   12,    1,    2,   21,   21,
			   21,    4,   38,   12,   24,   44,   24,    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    3,    4,    4,
			    4,    4,    4,    4,    4,    4,    5,    6,    7,    7,
			    8,    9,   10,   11,   12,   12,   12,   13,   14,   14,
			   14,   14,   14,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,

			   15,   15,   15,   15,   15,   16,   17,   18,   19,   19,
			   19,   19,   19,   19,   19,   19,   19,   20,    5,    5,
			    5,    2,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,   19,   19,   19,    4,    4,   21,   22,   23, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			   18,   18,   17,    1,   19,   47,    2,  733,   48,   51,
			    3,   49,   16,   23,   25,    0,   54,  111,   49,   49,
			   49,   50,    0,   29,  733,   30,  733,    0,    0,  709,
			  711,  724,  687,  706,  705,  704,  708,  707,  703,  702,
			  701,  700,  699,  698,  697,  696,  695,  694,  693,  692,
			  691,  690,  689,  688,  716,  731,  732,  730,  710,  712,
			  713,   39,    0,   34,   35,    0,   33,   26,   31,    0,
			   27,   36,  717,   38,   37,  725,   52,    0,    0,  114,
			    0,    0,    0,    0,   22,   24,  727,  719,  726,  718,
			    0,  653,   40,    0,    0,   42,   33,   32,    0,    0,

			    0,    0,   53,   58,    0,  112,  127,  124,  733,  733,
			  115,    0,    0,    0,    0,   43,  448,    0,  436,    0,
			    0,    0,    0,  418,  424,    0,  419,  651,    0,   41,
			   28,   60,   59,   55,   57,   56,    0,  113,    0,  228,
			    0,  231,  406,  733,  228,  404,   14,   18,   13,    0,
			  127,  124,  437,  136,  141,  137,  116,  118,  117,  119,
			    0,   46,   45,   44,  441,  427,  449,    0,    0,    0,
			  426,  425,  437,  437,  437,  462,  461,  441,  420,    0,
			  504,    0,    0,    0,    0,    0,    0,    0,  627,  617,
			  622,    0,  621,  731,  732,  730,    0,  618,  631,  647,

			  566,    0,    0,    0,    0,  620,  605,  626,  628,  606,
			    0,    0,  616,  625,  635,  614,  604,  580,  581,    0,
			  578,  623,  633,  629,  607,  652,  619,  624,  615,  634,
			    0,    0,  632,    0,    0,   98,    0,    0,    0,    0,
			   61,   89,   77,  125,    0,  733,  229,  217,  223,  211,
			  207,    0,  386,  578,  407,  245,  404,    0,  733,  405,
			   18,   14,   47,    0,  252,  208,  247,  249,  246,    0,
			  145,  438,  152,  138,  142,  129,  133,  153,  139,  143,
			  130,  134,  140,  144,  131,  135,  136,  141,  137,  128,
			  132,  450,  731,  732,  730,    0,    0,    0,    0,    0,

			    0,  451,  452,    0,  418,  432,    0,    0,  422,  423,
			  421,  439,  448,    0,  436,  440,    0,  617,  610,  566,
			  608,  609,  576,  575,    0,    0,  574,  294,  577,    0,
			    0,  613,  611,  612,  645,    0,  569,    0,  557,  659,
			  630,    0,    0,  673,  674,    0,  676,  671,  672,    0,
			    0,    0,    0,  654,  573,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  637,  655,  656,  559,    0,    0,   63,   62,  441,   99,
			   80,    0,   79,   78,   89,   89,   89,   69,   64,  441,
			   90,   73,    0,  126,  404,  179,  215,    0,  221,    0,

			    0,  232,  233,  230,    0,  387,  388,  390,  578,   18,
			  404,    0,   18,   11,   14,  251,  248,    0,    0,  335,
			  294,  254,  263,  253,  257,  250,  125,    0,  194,  199,
			  156,  189,  164,  151,  195,    0,  190,  200,  165,  446,
			  449,  446,  434,  433,  446,  437,  437,  437,  443,  731,
			  732,  730,  455,  454,    0,  428,  442,  447,  446,  446,
			  566,  317,  295,  298,  332,  331,  330,  329,  328,  327,
			  326,  325,  324,  323,  322,  321,  320,  319,  318,  297,
			  296,  333,  334,  316,  314,  313,  311,  315,  312,  310,
			  309,  308,  307,  306,  305,  304,  303,  302,  301,  300,

			  299,  641,  642,  716,    0,    0,    0,    0,    0,  646,
			  567,    0,    0,  657,    0,    0,    0,    0,  679,  669,
			  591,  590,  583,  584,  585,  587,  589,  592,  594,  593,
			  595,  586,  588,  601,  598,    0,  597,    0,  596,  582,
			  566,    0,  603,  602,   66,   65,  100,  731,  732,  730,
			    0,    0,    0,    0,    0,    0,  101,  102,    0,    0,
			    0,   89,   85,   75,   76,   74,   67,    0,   91,   98,
			    0,  436,   92,   18,  180,    0,    0,  216,  225,  224,
			    0,  222,  210,  235,  234,    0,    0,  389,  391,  392,
			    0,   18,   14,    5,   12,   18,    0,  264,  258,    0,

			    0,  361,   18,    0,  266,  260,    0,  336,  256,  255,
			  126,    0,    0,    0,    0,    0,  196,  190,  150,  191,
			  200,  201,    0,  166,  195,    0,    0,    0,  430,  431,
			  429,  446,  446,  459,    0,    0,  505,    0,  720,  728,
			    0,  721,  644,  729,  648,  649,  650,  568,    0,    0,
			  566,    0,    0,  658,    0,  675,  676,  677,    0,  600,
			  599,  565,  636,    0,    0,  446,   99,  446,   87,   86,
			  446,   89,   89,   89,   94,  731,  732,  730,  105,  104,
			   93,   97,    0,   90,   68,    0,    0,  446,  446,    0,
			    0,    0,  178,  185,  214,  226,  227,  220,  240,  236,

			    0,  393,   14,    0,   18,   10,    0,  268,  262,  265,
			  259,  292,  359,    0,  111,    0,   18,  358,  337,  356,
			  353,  357,  355,  352,  350,  354,  351,  349,  348,  347,
			  346,  345,  344,  343,  342,  341,  340,  339,  338,  202,
			  203,  193,  198,    0,  157,  158,  155,  188,  174,  173,
			  169,  163,  200,    0,  149,  190,  445,  457,  458,  444,
			  456,    0,    0,  460,  453,  566,    0,  570,  571,  572,
			  558,  205,  660,  661,  662,    0,  670,  685,    0,    0,
			    0,  678,  684,  638,  639,  640,    0,    0,    0,   83,
			   84,   82,  446,  446,  109,   71,   72,   70,    0,    0,

			   14,  181,  184,  182,  183,  186,  238,    0,  237,   18,
			   14,    9,  267,  261,    0,  288,    0,    0,    0,    0,
			  360,  369,  394,  292,  111,  204,    0,  159,  170,    0,
			    0,    0,  148,  200,  556,  643,  566,    0,  683,  680,
			  681,  682,   96,  107,  108,   95,  106,    0,    0,  110,
			  103,   18,    0,    0,  239,    8,   18,  293,  289,   18,
			  269,  365,  364,  362,  367,  363,  366,  368,    0,  395,
			  372,    0,  394,  160,  172,  175,  176,  168,  147,    0,
			  555,  642,    6,  243,  241,  242,    7,    0,  668,  288,
			  663,  664,  288,  111,  665,  715,  714,  667,  666,  723,

			  722,  370,  396,  397,  399,  375,    0,    0,   18,  372,
			  161,  177,  146,  686,    0,  271,  270,  394,  371,  398,
			  400,    0,    0,  290,  733,  733,  399,  399,  111,  399,
			    0,    0,    0,  372,  401,  402,  288,  383,    0,    0,
			  376,  377,  374,    0,  399,    0,    0,  416,  416,  394,
			    0,  290,  399,  399,  399,    0,    0,  403,  284,  382,
			    0,  379,  378,  381,  380,  291,    0,  495,    0,    0,
			  494,  566,    0,    0,  733,    0,  539,    0,    0,    0,
			    0,  466,  408,  491,    0,    0,  578,  488,  489,  479,
			  480,  482,  481,    0,  464,  733,    0,  417,    0,  372,

			  288,  399,  416,  416,    0,  290,  399,  399,  384,  288,
			    0,    0,    0,    0,  557,  733,    0,    0,    0,  542,
			  733,    0,  579,  578,  502,  492,    0,    0,    0,  410,
			  409,  412,    0,  559,    0,    0,    0,    0,    0,  288,
			  288,  399,    0,    0,  285,    0,    0,    0,  288,  399,
			  416,  416,  385,  286,  498,    0,  642,    0,    0,    0,
			  733,  733,  474,    0,  540,    0,  537,    0,    0,    0,
			  493,  484,  483,  411,  413,    0,  566,  478,  486,  487,
			  485,  472,  280,  282,    0,  290,  399,  399,  288,  288,
			  288,  276,    0,    0,    0,    0,  496,    0,  566,  515,

			  733,    0,  523,    0,  518,  517,    0,  506,    0,    0,
			    0,    0,    0,    0,  541,    0,    0,  566,  414,  578,
			    0,  565,  288,  399,  416,  416,  287,  281,  283,  288,
			  288,  288,  566,    0,  566,  558,    0,  514,    0,  520,
			  519,  468,  507,  508,    0,    0,  511,  510,    0,  545,
			  543,  544,  538,  500,  503,    0,    0,  277,    0,    0,
			    0,  278,  272,  274,  499,  566,  556,  470,    0,  560,
			  561,  533,  531,  524,  528,  532,  525,  522,    0,  563,
			  566,  530,  536,  562,  564,  509,    0,  512,  566,    0,
			  415,  733,    0,  288,  288,  288,  497,    0,  527,    0,

			  526,    0,  559,  513,  555,  566,    0,  490,  279,  273,
			  275,    0,  529,  566,  501,  476,  565,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			  373,  647,  298,  299,  300,  270,  756,  271,  165,  166,
			  757,  779,  780,  519,  781,  345,  607,  815,  205,  662,
			  206,  207,  980,  208, 1173, 1174, 1175, 1176, 1103, 1177,
			    9,   10,  593,  690,  691,  749,  692,  981,  996,  926,
			  927, 1061, 1101,  997,  982, 1192,  892,  553,  554,  555,
			  390,  391,  842,  666,  380,  843,  388,  684,  558,  559,
			  401,  402,  245,  246,  403,  209,  249,  577,  144,  139,
			  250,  983, 1146, 1109, 1147,  750,  434,  624,  751,  252,
			  211,  212,  213,  214,  215,  216,  217,  218,  219,  418,
			  944,  266,  267,  255,  256,  268,  874,  419,  740,  578,

			  816,  817,  818,  819,  603,  820,  100,  101,   17,  102,
			  220,  123,  987,    4,    5,   12,   13,   14,   67,   68,
			   69,   70,  988,  989,  990,  991,  992, 1181,  221,  504,
			   72,  259,  260,   11,   22,  741,  621,  622,  616,  617,
			  619,  620,  124,  938,  939,  940,  941,  907,  942, 1030,
			 1031,  222,  509,  223, 1113, 1114, 1020,  224,  225,   79,
			  226,  153,  154,  155,  108,  109,  273,  274,  921,  870,
			  421,  422,  423,  424,  898,  227,  506,   75,  744,  745,
			  438,  746,  860,  228,  229,  653,  230,  126,  307,  853,
			  699,  854, 1075, 1104, 1105, 1058,  231,  158,  159,  160,

			  232, 1217,  594,  148,    7,   24,   26,   15,   77,  567,
			  179,  625,  111,  613,  615,  830,  829,  575,  614,  611,
			  612,  400,  576,  397,  580,  399,  251,  807,  425,  713,
			  922,  254, 1034, 1138, 1065,  511,  541,  335,  128,  514,
			  658, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			   48,  943, 4942, -32768, -32768, 1330, -32768, -32768, -32768, 1324,
			 -32768,  498, -32768, 1123, 1051, 1642, 1317,  917, 1434, 1434,
			 1434, -32768, 1443, -32768, -32768, -32768, -32768,  229,   59, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1331, -32768, -32768,   12, 1308, -32768, 1321, 1642,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1095, 5032,  738,
			 1432, 1428, 1427, 1018, -32768, -32768, -32768, -32768, -32768, -32768,
			  910, 1305, -32768, 1392, 1642, -32768, -32768, -32768, 1018, 1018,

			  452, 1095, -32768, 1347, 5210, -32768,  398,  392,  671, 1250,
			 -32768,  346, 1018, 1018, 1018, -32768, 1266,  360, -32768,  763,
			  763,  763,  829, 1089, -32768, 1265, -32768, -32768, 4199, -32768,
			 -32768, 1329, 1326, -32768, -32768, -32768,  937, -32768,  163, 1332,
			  509, -32768, 4199,  330, 1332, 1241, 1368,  943, -32768,  670,
			 -32768, 1259, 1089,  103,   73,  346, -32768, -32768, -32768, -32768,
			  763, -32768, -32768, -32768, 1246, -32768, -32768, 1426, 1303, 1301,
			 -32768, -32768, 1089, 1089, 1089, -32768, -32768, 1230, -32768, 1297,
			 1240, 4303, 4303, 4303,  453, 4199,  910, 4303, -32768,  349,
			 -32768, 4303, -32768,   67,  360,   42, 4303, 1239, -32768, 1307,

			  634, 1235, 5210, 1244,  721, -32768, -32768, -32768, -32768, -32768,
			 5253, 1234, 1233, -32768, -32768, -32768,  753, -32768, -32768, 4093,
			 1945, -32768, -32768, -32768, -32768, -32768, 1231, -32768, 1227, -32768,
			 1290, 1289, -32768,  937,  937, 1218,  360,  763,  763,  763,
			 1294,  918, -32768,  341, 1229,  330, -32768,  604,  534,  566,
			 -32768,  428, 5137, 2625, 4199, -32768, 1241, 1318,  330, -32768,
			  943, -32768, 1330, 1323, 1228, -32768, 1318,  627, -32768,  150,
			 1472, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   20,    1,  763, -32768,
			 -32768, -32768,  899,  882,  814,  763,  763,  763, 1297, 1107,

			 1107, -32768, -32768, 1215, 1089, 1212, 1211, 1209, -32768, -32768,
			 -32768, -32768,  368,  360, 1204, -32768, 1018, 1187, -32768,  119,
			 -32768, -32768, -32768, -32768, 5373, 5351, -32768, -32768, -32768, 5297,
			  573, -32768, -32768, -32768, -32768, 4199, 1191,  763, -32768, 1190,
			 -32768,  910,  910, -32768, -32768, 1184,  955, 2353, -32768, 4199,
			 4199, 4199, 4199, -32768, -32768, 4199, 4199, 4199, 4199, 4199,
			 4199, 4199, 4199, 4199, 4199, 4199, 3987, 3880, 4199, 1018,
			 -32768, -32768, -32768, 2217, 4199, 4199, 1294, 1294, 1173, -32768,
			 -32768,  924, -32768, -32768,  918,  918,  918, 1283, -32768, 1169,
			 -32768, -32768,  921,  324, 1241, 1168, 1068, 1018, 1052, 1018,

			  509, 1160,  428, -32768,  511, -32768, 1135, 5065, 2489,  943,
			 1241, 1252,  123, -32768, -32768, -32768, -32768,  428,  782, -32768,
			 1260, -32768, -32768, -32768, -32768,  627, -32768, 1136,  307, 1237,
			 1530,   50,  908, -32768, 1059, 1236,  993,  965, 1216, -32768,
			 1116, -32768, 1114, 1106, -32768, 1089, 1089, 1089, -32768, 1103,
			 1097, 1081, -32768, -32768,  910, 1079, -32768, -32768, -32768, -32768,
			  119, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768,  607, 1047, 1071, 1064, 1062, 5076, 3774, -32768,
			 -32768, 4199, 1056, -32768,  428, 1053, 1043,  428, 1039, -32768,
			  659,  659,  934,  934,  -14,  -14,  -14,  659,  659,  659,
			  659,  -14,  -14, 4964, 5282, 4199, 5282, 4199, 1481, -32768,
			  119, 4199, 1197, 1197, -32768, -32768, -32768,  758,  806,  694,
			  763,  763,  763,  921, 1036, 1036, -32768, -32768, 1032, 1028,
			 1024,  918, 1021, -32768, -32768, -32768, -32768, 1018, -32768,  313,
			  360, 1015, -32768,  943, -32768, 1018, 1018, -32768, 1018, 1006,
			 1018, -32768, -32768, -32768, -32768, 1010, 1010, -32768, -32768,  999,
			 1111,  943, -32768, -32768, -32768,  123,  617, -32768, -32768,  627,

			  910,  996,  943,   66, -32768, -32768, 1809, -32768, -32768, -32768,
			 -32768,  428,  428,  428,  428,  -23, -32768,  993, -32768, -32768,
			  965, -32768, 1105, -32768, 1059, 1426, 1107, 1426,  974,  971,
			  970, -32768, -32768,  372, 1297, 1297, -32768, 1018, -32768, -32768,
			 1029, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 5209, 3667,
			  119,  504,  550, -32768,  951, -32768,  955, -32768, 1569, 5282,
			 1481, 2081, -32768, 5148, 3561, -32768,  949, -32768,  942,  923,
			 -32768,  918,  918,  918, -32768,  947,  941,  927, -32768, -32768,
			 -32768, -32768,  937,  926, -32768,  218,   29, -32768, -32768, 1030,
			  740,  712, -32768,  913, -32768, -32768, -32768, -32768,  915, -32768,

			  911, -32768, -32768, 1020,  123, -32768,  627, -32768, -32768, -32768,
			 -32768,  963, -32768, 1018,  917,  910,  943, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  856,
			  428, -32768, -32768, 1027, -32768,  428, -32768, -32768, -32768,  114,
			  827, -32768,  965, 1016, -32768,  993, -32768, -32768, -32768, -32768,
			 -32768, 1107, 1107, -32768, -32768,  119,  905, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, 1018, -32768, -32768,  910,  472,
			 1325, -32768, 1197, -32768, -32768, -32768,  924, 1036,  924,  896,
			  893,  890, -32768, -32768,  201, -32768, -32768, -32768,  921,  921,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  910, -32768,  123,
			 -32768, -32768, -32768, -32768,  428,   44, 1018, 1018,  706,    2,
			 -32768,  597,  907,  963,  917, -32768,  428, -32768, -32768,  428,
			  -23,  995, -32768,  965, -32768, -32768,  119,  460, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1036, 1036, -32768,
			 -32768,  123,   89,  910, -32768, -32768,  123, -32768, -32768, 1437,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  910, 3455,
			  752,  952,  907,  878, -32768,  856,  428, -32768, -32768,  962,
			 -32768,  583, -32768, -32768, -32768, -32768, -32768,  910, -32768,  129,
			 -32768, -32768,  129,  917, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768,  833, 4199, 4199,  515,  365, 5210,  255,  943,  720,
			 -32768, -32768, -32768, -32768,  595, -32768, -32768,  907, -32768, 4199,
			 3348,  948, 1018,  681,  655,  366,  515,  515,  917,  515,
			 5210,  255,  463,  711, 4199, 4199,  129,  199, 1018, 1018,
			 1018, 1018, -32768, 5210,  515, 4929, 4929,  403,  403,  907,
			  929,  681,  515,  515,  515, 5210,  255, 4199, -32768, -32768,
			  910, -32768, -32768, -32768, -32768, -32768,  928, -32768,  423,  910,
			 -32768,  448, 4199, 4199,  487,  812,  788,  778, 3242,  866,
			  865, -32768,  867, -32768,  762,  753, 2893, -32768, -32768, 1100,
			 -32768, -32768, -32768,  645, -32768,  864,  862, -32768,  861,  408,

			  129,  515,  403,  403,  850,  681,  515,  515,  725,  129,
			  916,  709,  378,  763, 4806, 1210, 1359, 4929,  910,  730,
			  819,  910, -32768, -32768,  700, -32768, 3131, 4199, 4199, 4199,
			 -32768,  775, 1018, 3025, 4929, 4199, 4199, 4199, 4929,  129,
			  129,  515, 5210,  255, -32768,  804,  789,  787,  129,  515,
			  403,  403, -32768, -32768,  668,  916,  479,  661,  523,  548,
			  875,  257, -32768,  632, -32768, 5210, -32768, 4929,  612, 1018,
			 -32768, 1197, 1197, 4199, 4199,  602,  119, -32768, 1197, 1197,
			 1197, -32768, -32768, -32768,  761,  681,  515,  515,  129,  129,
			  129, -32768,  715,  702,  683, 1018,  480, 1018,  119, -32768,

			  649,  639,  601,  571,  548, -32768, 4929, -32768,  561,   97,
			  414,  433,  342, 5210, -32768,  536,  916,  119, 1197, 1806,
			 4199, 2761,  129,  515,  403,  403, -32768, -32768, -32768,  129,
			  129,  129,  119, 1018,  119, 4681, 4929, -32768, 1745, -32768,
			 -32768, -32768, -32768, -32768,  466, 4199,  414, -32768, 1018, -32768,
			 -32768, -32768, -32768,  277, -32768, 4199, 4977, -32768,  435,  395,
			  387, -32768, -32768, -32768, -32768,  119, 4556, -32768,  910, -32768,
			 -32768, -32768, -32768,  262,  335, -32768, 1745, -32768,  244, -32768,
			  259, -32768, -32768, -32768,  203, -32768, 1359, -32768,  119, 1018,
			 1197,  267,  264,  129,  129,  129, -32768,  409, -32768, 1745,

			 -32768, 1018, -32768, -32768, 4431,  119, 4929, -32768, -32768, -32768,
			 -32768,  231, -32768,  119, -32768, -32768,  190,  193,  169, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
		once
			Result := yyfixed_array (<<
			   61,  925, -32768, -32768, -32768, -134, -159, -100, -32768,  -84,
			 -156, -32768, -32768,  912,  793, -32768, -32768,  743,  -11,  901,
			 -554, -32768, -916,  -13, -32768,  364, -32768, -32768, -32768,  388,
			 -32768, 1298,  870, -32768, -32768,  486,  159, -897, -602, -859,
			 -890, -1061, -776, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 1000, -352, -357, 1327, -32768, -366,  413,  873, -118, -32768,
			 -32768, -32768, 1408, 1448, 1142,   38, -32768, -330, -32768, -32768,
			 -120, -32768, -32768, -32768,  400, -32768, 1115, -32768,  686,  854,
			 -682, -1016, -32768, -32768, -32768, -576, -32768, 1057, -309, -408,
			 -888, -32768, -32768, 1402, -165, 1277,  631, -167, -498, -537,

			 -32768, -32768, -32768, -32768, -32768,  438, -32768, -32768, -32768, 1397,
			   -9,  998, -32768, -32768,  -95,  835, -32768, -32768, -32768, -32768,
			 -32768,  290, -32768, -32768, -32768, -32768, -32768,  640, -837,  -15,
			 -32768, 1388, -169, -32768, 1262, -550, 1249, -610, 1245,  872,
			 1223, -592,  -27, -32768, -32768, -32768, -32768, -788,  260, -32768,
			 -32768, -325,  982,   -8, -32768,  375, -32768, 1420, 1267, -663,
			 -183,  117,  109,   55, -32768, -32768,  145,  142, -287, -746,
			 -370, 1067, -382, 1065, -32768,  622,  -12, -32768, -32768, -32768,
			 -32768,  734, -215, -1088, -32768,  828,   34, -32768, -32768, -32768,
			  879,  613, -32768, -32768,  357, -32768, -779, 1108, 1092, 1376,

			 -32768, -32768, -528, -127, -32768, -32768, -32768,  -96, -32768, -32768,
			   75, -413, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -734, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 5477)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   71,  328,   64,   74,   63,  505,   66,   73,  301,  596,
			  753,  302,  140,  149,  146,  557,  652,  326,  240,  262,
			  315,  348,  895,  178,  556,  752,  508,   92,  626,  265,
			  685,  627,  563,  564,  565,  572,  605,  346,  308,  309,
			  310,  953, 1139,  609,  797,  634,  635,  257,  604,  994,
			 1184,  822,  263,   65,   71,  608,   64,   74,   63,  368,
			   96,   73,  742, 1001,  747, -187, 1007,  705,  103,  581,
			  105,    2,  952,  859,  115,  118,   57,   56,   55,   71,
			  394,   64,   74,   63,  404,   96,   73,  409, 1184,  131,
			  132, -187,  103,  410,  118,  716,  137, 1006,  151,  395,

			  150,  356,  171,  161,  162,  163, -436,   65,  170,  242,
			 1100, 1184, 1143,  176,  748,  376,  377, 1049,    1,  828,
			 1062,  931, 1179,   -4,  125, 1203,  909,  865,  151, -171,
			  150, -448,   65,  253,  412,  903,   89, 1077,  277,  448,
			  305, 1081,  831,  452,  453,  956,    2,  118,  685,  257,
			   91, -171,  305, 1087,  652, -171,  696,  272,  303, -171,
			 1179,  872,  257,  833,   88,  411,  993,  993,  919, 1219,
			 1115,  933,  319,  319,  319,  327,  811,  118,  319,  171,
			 -436,  858,  319, 1179, 1086,  170,  935,  319,  678,  679,
			  825,  167,  715, 1218,  340,  347,  674, 1123, 1024,  508,

			  957,  306,  649,  999,  455,  164,  242,  242,  440, 1141,
			  277, 1043,  884,  306,  708,  288,  883,  710,  761,  762,
			  330,  383, 1171,  879,  427,  573,  707,  382,  440,  709,
			  917, 1054,  664,  795, -554,  404, -171,  244,  993, 1167,
			  272,  591,  327,  336, 1026,  408,  694, -535,  695, -554,
			  697, -171,  786,  157,  787,  993,  156,  788,  420,  993,
			 1171,  338, -535,  984,  984,  949,  858,  925,  167,  287,
			 1100,  305, 1107,  426,  798,  799, 1096,  286,  443, 1207,
			  582,  855, -475, 1171,  442, 1108,  243,  595,  993,  924,
			  303,  303,   57,   56,   55, 1073,  279,  283,  443,  278,

			  282,  895,  290, -534,  442,  289,   87,  460,   54, 1215,
			  381,  628,  629,  630,  590,  766,  392, -554, -534,  789,
			  790,  791, -192,  882,  813,  960,  959,  993,  886,  850,
			 -535,  876,  306, 1144,   86,  984,  812, 1153,  849,  895,
			  649,  288,  288,  288, -192, -244,  998,  651, -192, -122,
			  656, -122,  984, -244,  562,  664,  984,  993, -244,   97,
			  540,  637,  895,  169,  168,  562, -121,  167, -121,  985,
			  985,  151,  560,  150, 1201,  515,  516, -373,  876,  847,
			  848, -463, -463,  336,  130,  984, -534,  167,  579, 1198,
			  579,  979,  979,  327, 1199,  287,  287,  287, -122, -373,

			 1046, 1047, 1195,  286,  286,  286, -463, 1189,  420,  420,
			 1194, -579, -579, -579, -579, -121,  420, -120,  873, -120,
			  118,  844,  846, -123,  984, -123, 1042,  993, 1145,  279,
			  283,  845,  278,  282,   57,   56,   55,   54,  199,  905,
			  687,  985,  845,  995,  739,  739,  743,  739, 1093, 1094,
			 1193,  378,  325,  122,  984,  503, 1178, 1041,  985,  392,
			  392,  392,  985,  979,  324,  704, -120, 1150,  759, 1149,
			  758,  760, -123,  121,  120,  119,  759,  325,  689, -560,
			  979, 1185,  846,   31,  979,  651,   54,  638,  633,  324,
			  639,  985,  169,  168, 1178,  458,  703,  118,  117,  116,

			  764, 1056,   57,   56,   55,  327,  164,  714,  327,  763,
			   28,   27,  505,  979,  138, -473,   21, 1178,  248,  247,
			  199,  636, 1159, 1160,  984,  323,  562,   57,   56,   55,
			  985,  920, 1211,  669, -473, -473, 1100,  503, 1099,  668,
			   54,  169,  168, -219, -219,  560,  560,   20,   19, -219,
			   18, 1152,  979, -219, 1010,  669,   54, -219,  686,  322,
			  985,  668, -219, 1148,  794,   31,  693,  579,   31,  579,
			 1013,  579,  336,  739,  325,  809, 1142,  185,  743,  134,
			  133, -209,  979,  881,   31, -209,  324,  420, -219, -209,
			  420, 1102,   28,   27, -209,   28,   27,  839,  305,  838,

			  305,  661,  327,  327,  327,  327,  760,  305,  305, 1097,
			 1133,   28,   27, -213, -213, 1060,  303,  303,  303, -213,
			 -209,  824,  381, -213,   57,   56,   55, -213,  765,  772,
			  985,  771, -213,  199,  711,  586,  392,  585,  417,  947,
			  948,  325,  950,  327,  381, -521,  602,  857,  417, 1120,
			  503,  325,  979,  324, 1137,  242,  395,  966, -213,  306,
			   54,  306,  875,  324, -469, 1002, 1003, 1004,  306,  306,
			 -465, -465,   54,  851,  915,  773,  686,  916,   31,  248,
			  247,  693,  693,  856,   54,  943, -206,  505,   31,  264,
			 -206,   57,   56,   55, -206, -465,  502,  420, 1131, -206,

			   31,   57,   56,   55,  821,   28,   27, 1037, 1036,  875,
			 1035,  770,   31,  637, 1045,   28,   27, 1130,  932, 1050,
			 1051,  958,  913,  868,  867, -206,  395,   28,   27,  955,
			 1129,  327,  368,  396,  398, 1116,  327,  637,  930,   28,
			   27,  601,  905,  600,  706,  325,  392,  392,  392,  823,
			  415,  905,  303,  303, 1084, 1111,  337,  324,  336,  562,
			  954,  562, 1092,  107,  893,  106,  836,  363,  362,  929,
			  906,  562,  562,  357,  356,  355, 1122,  560,  560,  560,
			   57,   56,   55,  905, 1098, 1044,   57,   56,   55,  544,
			  545,  352,  351,  344, 1053,   57,   56,   55, 1095, 1124,

			 1125,  904, 1090,  417, 1089,  327,  325,  821,  821,  821,
			  821,  602,  837,  928,   57,   56,   55,  420,  324, 1088,
			  327,  670, -436, 1074, 1082, 1083,  834,  343,  945,  946,
			 1069,  863, -436, 1091, 1066,  803, 1158,  118,  560,  560,
			 1055,  852, -167,  342,  896,  185,  891,  900,  890,  802,
			  804,  897,   57,   56,   55, 1064,   57,   56,   55,   84,
			  253,   85, 1052,  801, -167, 1048,  638,  327, -167,  639,
			    3,    6, -167, 1126, 1127, 1128, 1040, 1039, 1017, -471,
			   57,   56,   55,   54, 1022,  665,  -98,  852, -467, -467,
			 -467,  370, 1032,  253,  408, 1029,  378,  880,  923, 1038,

			 1021,  175,  901,   57,   56,   55,  601, 1157,  600,  599,
			  408,  253, 1019,  937, 1161, 1162, 1163,  638, -467, 1059,
			  639,  914,  951, -162, 1067,  253,  408, 1028, 1027,  937,
			  937,  937,  937,  667, 1018,  965,  986,  986,  169,  168,
			  122,  444, -436, 1009, 1000, -162,  869, 1005,  408, -162,
			   78,  122, -436, -162,  122, 1183,   57,   56,   55,   54,
			  121,  120,  119,  936, 1106, 1110,    2,  122, 1023,  253,
			  918,  552,  551,  550,  552,  551,  550,  912, 1208, 1209,
			 1210,  908,  210,  771,  118,  117,  116,  239,  238,  237,
			   57,   56,   55, 1183, 1008,  571,  570,  569,  549,  548,

			  547, 1023, 1011, 1012, 1136,  910,  429,  368,  986,  441,
			  878,  118,  236,  235,  169,  168, 1183,  408,  -74,  814,
			  253,  -76, 1022, 1076,  -75,  986,  439, -448,  835,  986,
			  431,  832, 1014,  826, 1085,  810,  808,  164,  806,  329,
			  805,  638,  363,  362,  639,  800, 1023, 1033,  357,  356,
			  355,  -78, 1063,  -81,  793, 1068,  389, 1112,  986,  -21,
			 1117, -218, -218,  -21,  408, 1119,  -21, -218,  667,  -21,
			  -79, -218,  -21,  210,  792, -218,  -88, -212, -212,  518,
			 -218,  775,  -21, -212,  -21,  -21, 1132, -212, 1134,  199,
			  -21, -212,   57,   56,   55, 1206, -212,  986, -421, -423,

			  -21,  -21, -422,  -21,  428, 1112, -218, 1023,  407,  152,
			  677,  676,  675, -477, -477, -477, -477,  172,  173,  174,
			  754,  712, -212,  896, 1165, 1172,  702,  986, -477, 1180,
			 1182,  -20,  698,  696,  241,  -20,  701, 1121,  -20, 1188,
			 -477,  -20,  688, -477,  -20,   99,   98, -477, -477,  -77,
			  682,  152,  152,  152,  -20,  681,  -20,  -20,  152, 1135,
			  680,  896,  -20, 1172,  657,  304,  655, 1180, 1182,   57,
			   56,   55,  -20,  -20,  640,  -20,  654,  304, 1154,  650,
			 1205,  451,  450,  449,  896,  643, 1172,  642,   25,  507,
			 1180, 1182, 1213, 1164,  641, 1166,  638,  986,  961,  962,

			  963,  964, 1197,  520,  521,  522,  523, -420,  632,  524,
			  525,  526,  527,  528,  529,  530,  531,  532,  533,  534,
			  536,  538,  539, -516,  441, -516, 1196,  177,  542,  543,
			  631,  241,  241,  432, -425,  384,  385,  386,  318,  320,
			  321, 1202, -426, -435,  331,  276,  281,  285,  332, 1204,
			  -14,  618, -197,  333,  861,  862,  864,  866,  -18,  610,
			   23,  275,  280,  284,  606,  -18, 1214,  592,  -18,  142,
			  368,  -18,  587,    2, 1216,  367,  366,  365,  142,  364,
			   80,   81,   82,  368,  152,  152,  152,  583,  367,  366,
			  365,  574,  364,  445,  446,  447,  304,  568,  566,  -18,

			  -18,  546,  -18,  387,  141,  363,  362,  361,  360,  359,
			  358,  357,  356,  355,  517,  513,  510, -560,  363,  362,
			  361,  360,  359,  358,  357,  356,  355,  122,  204,  352,
			  351,  459,  350,  349,   62,  512,  457,  264,  414,  456,
			 -424,  454,  352,  351,  203,  350,  349,  297,  296,  295,
			  395,    8,  393,  375,  374,  122,  378, -564,  311,  339,
			  202, -562,  507, -563,  369,  648,  341,  201,  334, -561,
			  316,  314,  313,  312,  291,  121,  120,  119,   89,  561,
			   87,  269,  200,  261,  234,  199,  141,  233,  180,  659,
			  561,  660,  198,   60,   59,  663,   58,  197,  196,  195,

			  194,  193,  192, 1060,  164,  136,  191,  129,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			  190,  189,  368,  127,   94,  114,  113,  367,  366,  365,
			  112,  364,  188,   30,   29,   76,  187,  778,   95,  185,
			  840,   83,   21,   90,  184,  110,  122,  183,  182,  181,
			    2, 1140,   16,   91,  777,  700,  885,  363,  362,  361,
			  360,  359,  358,  357,  356,  355,  297,  296,  295,  827,
			  774,  899,  598,  889,  597,   93,  372,  433, 1151,  432,
			  646,  352,  351,  437,  350,  349,  755,  147,  135,  894,

			  294,  293,  292,  648,  888,   60,   59,  911,   58,  431,
			  430,  145,  782,  429,   54,  436,  877,  428,  663,  435,
			   53,   52,   51,   50,   49,   48,   47,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,  416,  584, -154, 1187, -154,  671,  672,
			  673,  561,  258,  623,  368,   30,   29,  143,  796,  887,
			  413,  683,  379, 1212, 1200,  785,  871, -154,  776,   28,
			   27, -154,  204,  841,  769, -154,    0,    0,   62,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  203,  363,
			  362,  361,  360,  359,  358,  357,  356,  355,    0,  122,

			    0,    0,    0,    0,  202,    0,    0,    0,    0,    0,
			    0,  201,    0,  352,  351,    0,  350,  349,    0,  121,
			  120,  119,    0,  304,    0,  304,  200,    0,    0,  199,
			    0,    0,  304,  304,  782,    0,  198,   60,   59,    0,
			   58,  197,  196,  195,  194,  193,  192,    0,    0,    0,
			  191,   62,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,  190,  189,    0,    0,    0,    0,
			  241,    0,    0,    0,    0,    0,  188,   30,   29,    0,
			  187,  778,    0,  185,    0,    0,    0,    0,  184,    0,

			    0,  183,  182,  181,    0,    0,    0,   91,  777,   61,
			   60,   59,    0,   58,    0,    0,   57,   56,   55,   54,
			    0,    0,    0,    0,    0,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  407,    0,    0,
			   30,   29,    0,    0,  203,    0,    0,    0,    0,    0,
			    0,    0,    0,  407,   28,   27,    0,    0,    0,    0,
			    0,    0,    0,    0,  561,    0,  561,    0,    0,  407,
			    0,    0,    0,    0,    0,    0,  561,  561,    0,    0,

			    0,    0,  200,    0,    0,    0,    0,    0,    0,    0,
			    0,  407,    0,    0,    0,    0,   58, 1170,    0,   57,
			   56,   55,   54,    0,    0,    0, 1015, 1016,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			    0, 1169,    0, -566,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   30,   29,    0,    0, 1168,    0,  185,
			    0,    0,    0,    0,    0,    0,    0,  169,  168, -566,
			  407, 1071, 1072,    0, -566, -566, -566,    0, -566, 1078,
			 1079, 1080,  738,  737,  736,  735,  734,  733,  732,  731,

			  730,  729,  728,  727,  726,  725,  724,  723,  722,  721,
			  720,  719,  718,  717, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566,    0,    0,    0,    0,  407, 1118,    0,
			  336,    0, 1155,    0,    0,    0, -566,    0, -566, -566,
			    0, -566, -566,    0, -566,    0,    0,    0, -566,    0,
			    0,    0, -566,    0, -566,    0, -566, -566, -566, -566,
			 -566, -566,    0, -566, -566, -566,    0, -566, -566,    0,
			    0, -566,    0, -566, 1156, -566, -566, -566,    0, -566,
			 -566,    0,    0,    0,    0, -566,    0, -566, -566, -566,
			    0,    0, -566, -566, -566, -566, -566, -566,    0, 1186,

			    0,    0, -566,    0,    0, -566, -566,    0,    0, 1190,
			    0, 1057, -566, -566, -566,    0, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566,    0, -566, -566,    0,  336,
			 -566,    0, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -553,    0,    0,    0, -553,    0,
			 -553,    0, -553, -553, -553, -553, -553, -553,    0, -553,

			 -553, -553,    0, -553, -553,    0,    0, -553,    0, -553,
			    0, -553, -553, -553,    0, -553, -553,    0,    0,    0,
			    0, -553,    0, -553, -553, -553,    0,    0, -553, -553,
			 -553, -553, -553, -553,    0,    0,    0,    0, -553,    0,
			    0, -553, -553,    0,    0,    0,    0,    0, -553, -553,
			 -553,    0, -553, -553, -553, -553, -553, -553, -553, -553,
			 -553, -553, -553, -553, -553, -553, -553, -553, -553, -553,
			 -553, -553, -553, -553, -553, -553, -553, -553, -553, -553,
			 -553, -553, -553, -553, -553, -553, -553, -553, -553, -553,
			 -553, -553, -553, -553, -553, -553, -553, -553, -553, -553,

			 -553,    0, -553, -553,    0, -553, -553,    0, -553, -553,
			 -553,    0, -553, -553, -553, -553, -553, -553, -553, -553,
			 -552,    0,    0,    0, -552,    0, -552,    0, -552, -552,
			 -552, -552, -552, -552,    0, -552, -552, -552,    0, -552,
			 -552,    0,    0, -552,    0, -552,    0, -552, -552, -552,
			    0, -552, -552,    0,    0,    0,    0, -552,    0, -552,
			 -552, -552,    0,    0, -552, -552, -552, -552, -552, -552,
			    0,    0,    0,    0, -552,    0,    0, -552, -552,    0,
			    0,    0,    0,    0, -552, -552, -552,    0, -552, -552,
			 -552, -552, -552, -552, -552, -552, -552, -552, -552, -552,

			 -552, -552, -552, -552, -552, -552, -552, -552, -552, -552,
			 -552, -552, -552, -552, -552, -552, -552, -552, -552, -552,
			 -552, -552, -552, -552, -552, -552, -552, -552, -552, -552,
			 -552, -552, -552, -552, -552, -552, -552,    0, -552, -552,
			    0, -552, -552,    0, -552, -552, -552,    0, -552, -552,
			 -552, -552, -552, -552, -552, -552, -294,    0,    0,    0,
			 -294,    0, -294,    0, -294, -294, -294, -294, -294, -294,
			    0, -294, -294, -294,    0, -294, -294,    0,    0, -294,
			    0, -294,    0, -294, -294, -294,    0, -294, -294,    0,
			    0,    0,    0, -294,    0, -294, -294, -294,    0,    0,

			 -294, -294, -294, -294, -294, -294,    0,    0,    0,    0,
			 -294,    0,    0, -294, -294,    0,    0,    0,    0,    0,
			 -294, -294, -294,    0, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294,    0, -294, -294,    0, -294, -294,    0,
			 -294, -294, -294,    0, -294, -294, -294, -294, -294, -294,
			 -294, -294, -566,    0,    0,    0,    0,    0, -566,    0,

			    0, -566,    0,    0, -566,    0,    0, -566, -566,    0,
			    0,    0, -566,    0,    0,    0,    0,    0,    0, -566,
			 -566,    0,    0, -566, -566,    0,    0,    0,    0, -566,
			    0, -566,    0,    0,    0,    0, -566, -566, -566, -566,
			 -566, -566,    0,    0,    0,    0, -566,    0,    0, -566,
			    0,    0,    0,    0,    0,    0, -566, -566, -566,    0,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566,    0, -566, -566, -566,

			 -566, -566, -566, -566, -566, -566, -566, -566, -566,    0,
			 -566, -566,    0,  336,    0,  589,    0,    0, -566, -566,
			    0, -566, -566, -566, -566, -566, -566, -566, -566,    0,
			    0,    0,    0,    0, -566,    0,    0, -566,    0,    0,
			 -566,    0,    0, -566, -566,    0,    0,    0, -566,    0,
			    0,    0,    0,    0,    0, -566, -566,    0,    0, -566,
			 -566,    0,    0,    0,    0, -566,    0, -566,    0,    0,
			    0,    0, -566, -566, -566, -566, -566, -566,    0,    0,
			    0,    0, -566,    0,    0, -566,    0,    0,    0,    0,
			    0,    0, -566, -566, -566,    0, -566, -566, -566, -566,

			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566,    0, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566,    0, -566, -566,    0,  336,
			    0,  406,    0,    0, -566, -566,    0, -566, -566, -566,
			 -566, -566, -566, -566, -547,    0,    0,    0, -547,    0,
			 -547,    0, -547,    0, -547, -547, -547, -547,    0,    0,
			 -547, -547,    0, -547,    0,    0,    0, -547,    0, -547,
			    0,    0,    0,    0,    0,    0, -547,    0,    0,    0,

			    0, -547,    0, -547, -547,    0,    0,    0, -547, -547,
			    0,    0,    0,    0,    0,    0,    0,    0, -547,    0,
			    0, -547,    0, -554,    0,    0,    0,    0, -547, -547,
			 -547,    0, -547, -547,    0, -547, -547, -547, -547,    0,
			    0,    0,    0,    0, -547, -547, -547, -547, -547, -547,
			 -547, -547, -547, -547, -547, -547, -547, -547, -547, -547,
			 -547, -547, -547, -547, -547, -547, -547, -547, -547,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -547, -547,
			 -547,    0,    0, -547,    0, -547,    0,    0,    0,    0,
			 -547,    0, -547,    0,    0,    0, -566,    0, -547, -553,

			 -566,    0, -566,    0, -566,    0, -566, -566, -566, -566,
			    0,    0, -566, -566,    0, -566,    0,    0,    0, -566,
			    0, -566,    0,    0,    0,    0,    0,    0, -566,    0,
			    0,    0,    0, -566,    0, -566, -566,    0,    0,    0,
			 -566, -566,    0,    0,    0,    0,    0,    0,    0,    0,
			 -566,    0,    0, -566,    0,    0,    0,    0,    0,    0,
			 -566, -566, -566,    0, -566, -566,    0, -566, -566, -566,
			 -566,    0,    0,    0,    0,    0, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566,
			 -566, -566, -566, -566, -566, -566, -566, -566, -566, -566, yyDummy>>,
			1, 3000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -566,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -566, -566, -566,    0,    0, -566,    0,  336,    0,    0,
			    0,    0, -566, -566, -566,    0,    0,    0, -546,    0,
			 -566, -566, -546,    0, -546,    0, -546,    0, -546, -546,
			 -546, -546,    0,    0, -546, -546,    0, -546,    0,    0,
			    0, -546,    0, -546,    0,    0,    0,    0,    0,    0,
			 -546,    0,    0,    0,    0, -546,    0, -546, -546,    0,
			    0,    0, -546, -546,    0,    0,    0,    0,    0,    0,
			    0,    0, -546,    0,    0, -546,    0,    0,    0,    0,
			    0,    0, -546, -546, -546,    0, -546, -546,    0, -546,

			 -546, -546, -546,    0,    0,    0,    0,    0, -546, -546,
			 -546, -546, -546, -546, -546, -546, -546, -546, -546, -546,
			 -546, -546, -546, -546, -546, -546, -546, -546, -546, -546,
			 -546, -546, -546,    0,  204,    0,    0,    0,    0,    0,
			   62,    0, -546, -546, -546,    0, 1070, -546,    0, -546,
			  203,    0,    0,    0, -546,    0, -546,    0,    0,    0,
			    0,  122, -546, -552,    0,    0,  202,    0,    0,    0,
			    0,    0,    0,  201,    0,    0,    0,    0,    0,    0,
			    0,  121,  120,  119,    0,    0,    0,    0,  200,    0,
			    0,  199,    0,    0,    0,    0,    0,    0,  198,   60,

			   59,    0,   58,  197,  196,  195,  194,  193,  192,    0,
			    0,    0,  191,    0,   53,   52,   51,   50,   49,   48,
			   47,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,  190,  189,    0,    0,
			    0,    0,    0,    0,    0,  204,    0,    0,  188,   30,
			   29,   62,  187,  186,    0,  185,    0, 1025,    0,    0,
			  184,  203,    0,  183,  182,  181,    0,    0,    0,   91,
			    0,    0,  122,    0,    0,    0,    0,  202,    0,    0,
			    0,    0,    0,    0,  201,    0,    0,    0,    0,    0,
			    0,    0,  121,  120,  119,    0,    0,    0,    0,  200,

			    0,    0,  199,    0,    0,    0,    0,    0,    0,  198,
			   60,   59,    0,   58,  197,  196,  195,  194,  193,  192,
			    0,    0,    0,  191,    0,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,  190,  189,    0,
			    0,  204,    0,    0,    0,    0,    0,   62,    0,  188,
			   30,   29,    0,  187,  186,    0,  185,  203,    0,    0,
			    0,  184,    0,    0,  183,  182,  181,    0,  122,    0,
			   91,    0,    0,  202,    0,    0,    0,    0,    0,    0,
			  201,    0,  934,    0,    0,    0,    0,    0,  121,  120,

			  119,    0,    0,    0,    0,  200,    0,    0,  199,    0,
			    0,    0,    0,    0,    0,  198,   60,   59,    0,   58,
			  197,  196,  195,  194,  193,  192,    0,    0,    0,  191,
			    0,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,  190,  189,    0,    0,    0,  204,    0,
			    0,    0,    0,    0,   62,  188,   30,   29,  902,  187,
			  186,    0,  185,    0,  203,    0,    0,  184,    0,    0,
			  183,  182,  181,    0,    0,  122,   91,    0,    0,    0,
			  202,    0,    0,    0,    0,    0,    0,  201,    0,    0,

			    0,    0,    0,    0,    0,  121,  120,  119,    0,    0,
			    0,    0,  200,    0,    0,  199,    0,    0,    0,    0,
			    0,    0,  198,   60,   59,    0,   58,  197,  196,  195,
			  194,  193,  192,    0,    0,    0,  191,    0,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			  190,  189,    0,    0,  204,    0,    0,    0,    0,    0,
			   62,    0,  188,   30,   29,    0,  187,  186,    0,  185,
			  203,    0,    0,    0,  184,    0,    0,  183,  182,  181,
			    0,  122,    0,   91,    0,    0,  202,    0,    0,    0,

			    0,    0,    0,  201,    0,    0,    0,    0,    0,    0,
			    0,  121,  120,  119,    0,    0,    0,    0,  200,    0,
			    0,  199,    0,    0,    0,    0,    0,    0,  198,   60,
			   59,    0,   58,  197,  196,  195,  194,  193,  192,    0,
			    0,    0,  191,    0,   53,   52,   51,   50,   49,   48,
			   47,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,  190,  189,    0,    0,
			  204,    0,    0,    0,    0,    0,   62,    0,  188,   30,
			   29,    0,  187,  186,    0,  185,  203,    0,    0,  784,
			  184,    0,    0,  183,  182,  181,    0,  122,    0,   91,

			    0,    0,  202,    0,    0,    0,    0,    0,    0,  201,
			    0,    0,    0,    0,    0,    0,    0,  121,  120,  119,
			    0,    0,    0,    0,  200,    0,    0,  199,    0,    0,
			    0,    0,    0,    0,  198,   60,   59,    0,   58,  197,
			  196,  195,  194,  193,  192,    0,    0,    0,  191,    0,
			   53,   52,   51,   50,   49,   48,   47,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,  190,  189,    0,    0,    0,  204,    0,    0,
			    0,    0,    0,   62,  188,   30,   29,    0,  187,  186,
			    0,  185,  768,  203,    0,    0,  184,    0,    0,  183,

			  182,  181,    0,    0,  122,   91,    0,    0,    0,  202,
			    0,    0,    0,    0,    0,    0,  201,    0,    0,    0,
			    0,    0,    0,    0,  121,  120,  119,    0,    0,    0,
			    0,  200,    0,    0,  199,  645,    0,    0,    0,    0,
			    0,  198,   60,   59,    0,   58,  197,  196,  195,  194,
			  193,  192,    0,    0,    0,  191,    0,   53,   52,   51,
			   50,   49,   48,   47,   46,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,  190,
			  189,    0,    0,  204,    0,    0,    0,    0,    0,   62,
			    0,  188,   30,   29,    0,  187,  186,    0,  185,  203,

			    0,    0,    0,  184,    0,    0,  183,  182,  181,    0,
			  122,    0,   91,    0,    0,  202,    0,    0,    0,    0,
			    0,    0,  201,    0,  537,    0,    0,    0,    0,    0,
			  121,  120,  119,    0,    0,    0,    0,  200,    0,    0,
			  199,    0,    0,    0,    0,    0,    0,  198,   60,   59,
			    0,   58,  197,  196,  195,  194,  193,  192,    0,    0,
			    0,  191,    0,   53,   52,   51,   50,   49,   48,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,  190,  189,    0,    0,    0,
			  204,    0,    0,    0,    0,    0,   62,  188,   30,   29,

			  535,  187,  186,    0,  185,    0,  203,    0,    0,  184,
			    0,    0,  183,  182,  181,    0,    0,  122,   91,    0,
			    0,    0,  202,    0,    0,    0,    0,    0,    0,  201,
			    0,    0,    0,    0,    0,    0,    0,  121,  120,  119,
			    0,    0,    0,    0,  200,    0,    0,  199,    0,    0,
			    0,    0,    0,    0,  198,   60,   59,    0,   58,  197,
			  196,  195,  194,  193,  192,    0,    0,    0,  191,    0,
			   53,   52,   51,   50,   49,   48,   47,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,  190,  189,    0,    0,  204,    0,    0,    0,

			    0,    0,   62,    0,  188,   30,   29,    0,  187,  186,
			    0,  185,  203,    0,    0,    0,  184,    0,    0,  183,
			  182,  181,    0,  122,    0,   91,    0,    0,  202,    0,
			    0,    0,    0,    0,    0,  201,    0,    0,    0,    0,
			    0,    0,    0,  121,  120,  119,    0,    0,    0,    0,
			  200,    0,    0,  199,    0,    0,    0,    0,    0,    0,
			  198,   60,   59,    0,   58,  197,  196,  195,  194,  193,
			  192,    0,    0,    0,  191,    0,   53,   52,   51,   50,
			   49,   48,   47,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,  190,  189,

			    0,    0,  204,    0,    0,    0,    0,    0,   62,    0,
			  188,   30,   29,    0,  187,  186,    0,  185,  203,    0,
			    0,  371,  184,    0,    0,  183,  182,  181,    0,  122,
			    0,   91,    0,    0,  202,    0,    0,    0,    0,    0,
			    0,  201,    0,    0,    0,    0,    0,    0,    0,  121,
			  120,  119,    0,    0,    0,    0,  200,    0,    0,  199,
			    0,    0,    0,    0,    0,    0,  198,   60,   59,    0,
			   58,  197,  196,  195,  194,  193,  192,    0,    0,    0,
			  191,    0,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,

			   35,   34,   33,   32,  190,  189,  204,    0,    0,    0,
			    0,    0,   62,    0,    0,    0,  188,   30,   29,    0,
			  187,  186,  203,  185,    0,    0,    0,    0,  184,    0,
			    0,  183,  182,  181,    0,    0,    0,   91,  202,    0,
			    0,    0,    0,    0,    0,  201,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  200,    0,    0,  199,    0,    0,    0,    0,    0,    0,
			  198,   60,   59,    0,   58,  197,  196,   57,   56,   55,
			  192,    0,    0,    0,  191,    0,   53,   52,   51,   50,
			   49,   48,   47,   46,   45,   44,   43,   42,   41,   40,

			   39,   38,   37,   36,   35,   34,   33,   32,  190,  317,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  188,   30,   29,    0,  187,  186,    0,  185,    0,    0,
			    0,    0,  184,    0, -550,  183,  182,  181, -550,    0,
			 -550,   91, -550,    0, -550, -550, -550, -550,    0,    0,
			 -550, -550,    0, -550,    0,    0,    0, -550,    0, -550,
			    0,    0,    0,    0,    0,    0, -550,    0,    0,    0,
			    0, -550,    0, -550, -550,    0,    0,    0, -550, -550,
			    0,    0,    0,    0,    0,    0,    0,    0, -550,    0,
			    0, -550,    0,    0,    0,    0,    0,    0, -550, -550,

			 -550,    0, -550, -550,    0, -550, -550, -550, -550,    0,
			    0,    0,    0,    0, -550, -550, -550, -550, -550, -550,
			 -550, -550, -550, -550, -550, -550, -550, -550, -550, -550,
			 -550, -550, -550, -550, -550, -550, -550, -550, -550,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -550, -550,
			 -550,    0,    0, -550,    0, -550,    0,    0,    0, -551,
			 -550,    0, -550, -551,    0, -551,    0, -551, -550, -551,
			 -551, -551, -551,    0,    0, -551, -551,    0, -551,    0,
			    0,    0, -551,    0, -551,    0,    0,    0,    0,    0,
			    0, -551,    0,    0,    0,    0, -551,    0, -551, -551,

			    0,    0,    0, -551, -551,    0,    0,    0,    0,    0,
			    0,    0,    0, -551,    0,    0, -551,    0,    0,    0,
			    0,    0,    0, -551, -551, -551,    0, -551, -551,    0,
			 -551, -551, -551, -551,    0,    0,    0,    0,    0, -551,
			 -551, -551, -551, -551, -551, -551, -551, -551, -551, -551,
			 -551, -551, -551, -551, -551, -551, -551, -551, -551, -551,
			 -551, -551, -551, -551,    0,    0,    0,    0,    0,    0,
			    0,    0,    0, -551, -551, -551,    0,    0, -551,    0,
			 -551,    0,    0,    0, -549, -551,    0, -551, -549,    0,
			 -549,    0, -549, -551, -549, -549, -549, -549,    0,    0,

			 -549, -549,    0, -549,    0,    0,    0, -549,    0, -549,
			    0,    0,    0,    0,    0,    0, -549,    0,    0,    0,
			    0, -549,    0, -549, -549,    0,    0,    0, -549, -549,
			    0,    0,    0,    0,    0,    0,    0,    0, -549,    0,
			    0, -549,    0,    0,    0,    0,    0,    0, -549, -549,
			 -549,    0, -549, -549,    0, -549, -549, -549, -549,    0,
			    0,    0,    0,    0, -549, -549, -549, -549, -549, -549,
			 -549, -549, -549, -549, -549, -549, -549, -549, -549, -549,
			 -549, -549, -549, -549, -549, -549, -549, -549, -549,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -549, -549,

			 -549,    0,    0, -549,    0, -549,    0,    0,    0, -548,
			 -549,    0, -549, -548,    0, -548,    0, -548, -549, -548,
			 -548, -548, -548,    0,    0, -548, -548,    0, -548,    0,
			    0,    0, -548,    0, -548,    0,    0,    0,    0,    0,
			    0, -548,    0,    0,    0,    0, -548,    0, -548, -548,
			    0,    0,    0, -548, -548,    0,    0,    0,    0,    0,
			    0,    0,    0, -548,    0,    0, -548,    0,    0,    0,
			    0,    0,    0, -548, -548, -548,    0, -548, -548,    0,
			 -548, -548, -548, -548,    0,    0,    0,    0,    0, -548,
			 -548, -548, -548, -548, -548, -548, -548, -548, -548, -548,

			 -548, -548, -548, -548, -548, -548, -548, -548, -548, -548,
			 -548, -548, -548, -548,    0,    0,    0,    0,    0,    0,
			    0,    0,    0, -548, -548, -548,    0,    0, -548,    0,
			 -548,    0,  204,    0,    0, -548,  978, -548,  977,    0,
			  976,    0,    0, -548,    0,    0,    0,    0,  975,  974,
			  -15,  973,    0,    0,  -15,  972,    0,  -15,    0,    0,
			  -15,    0,    0,  -15,  202,    0,    0,    0,    0,    0,
			    0,  201,    0,  -15,    0,  -15,  -15,    0,    0,    0,
			    0,  -15,    0,    0,    0,    0,  971,    0,    0,  199,
			    0,  -15,  -15,    0,  -15,    0,  198,   60,   59,    0,

			   58,  197,    0,   57,   56,   55,  192,    0,    0, 1191,
			    0,    0,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,  190,  189,  970,  368,    0,    0,
			    0,    0,  367,  366,  365,    0,  188,   30,   29,    0,
			  368,  969,    0,  185,    0,  367,  366,  365,  184,  364,
			  968,    0,    0,    0,    0,    0,  967,  104,    0,    0,
			    0,    0,  363,  362,  361,  360,  359,  358,  357,  356,
			  355,    0,    0,    0,    0,  363,  362,  361,  360,  359,
			  358,  357,  356,  355,    0,    0,  352,  351,    0,  350,

			  349,    0,    0,    0,    0,    0,    0,    0,    0,  352,
			  351,    0,  350,  349,    0,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,  644,  368,    0,
			    0,    0,    0,  367,  366,  365,    0,  364,    0,  368,
			    0,   29,    0,    0,  367,  366,  365,    0,  364,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  363,  362,  361,  360,  359,  358,  357,
			  356,  355,    0,    0,  363,  362,  361,  360,  359,  358,
			  357,  356,  355,    0,    0,    0,    0,  352,  351,    0,

			  350,  349,  588,  354,    0,    0,    0,    0,  352,  351,
			  368,  350,  349,    0,    0,  367,  366,  365,    0,  364,
			    0,  368,    0,    0,    0,    0,  367,  366,  365,    0,
			  364,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  363,  362,  361,  360,  359,
			  358,  357,  356,  355,    0,    0,  363,  362,  361,  360,
			  359,  358,  357,  356,  355,    0,    0,    0,    0,  352,
			  351,    0,  350,  349,  405,  354,  783,    0,    0,    0,
			  352,  351,  368,  350,  349,    0,    0,  367,  366,  365,
			    0,  364,    0,   53,   52,   51,   50,   49,   48,   47,

			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,    0,    0,  363,  362,  361,
			  360,  359,  358,  357,  356,  355,  368,    0,    0,   29,
			    0,  367,  366,  365,  767,  364,  354,    0,    0,    0,
			    0,  352,  351,    0,  350,  349,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  368,    0,    0,    0,    0,
			  367,  363,  362,  361,  360,  359,  358,  357,  356,  355,
			  368,    0,    0,    0,    0,  367,  366,  365,    0,  364,
			  354,  353,    0,    0,    0,  352,  351,    0,  350,  349,
			  363,  362,  361,  360,  359,  358,  357,  356,  355,    0,

			    0,    0,    0,    0,    0,  363,  362,  361,  360,  359,
			  358,  357,  356,  355,  352,  351,    0,  350,  349,    0,
			    0,    0,  501,    0,    0,    0,    0,    0,    0,  352,
			  351,    0,  350,  349,  500,  499,  498,  497,  496,  495,
			  494,  493,  492,  491,  490,  489,  488,  487,  486,  485,
			    0,    0,  484,  483,  482,  481,  480,  479,  478,  477,
			  476,  475,  474,  473,  472,  471,  470,  469,  468,  467,
			  466,  465,    0,    0,  464,  463,  462,  461, yyDummy>>,
			1, 2478, 3000)
		end

	yycheck_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 5477)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   15,  184,   15,   15,   15,  330,   15,   15,  167,  417,
			  620,  167,  108,  109,  109,  381,  514,  184,  136,  146,
			  179,  204,  859,  123,  381,  617,  335,   15,  441,  149,
			  567,  444,  384,  385,  386,  392,  418,  204,  172,  173,
			  174,  931, 1103,  425,   15,  458,  459,  143,  418,  946,
			 1138,  714,  147,   15,   69,  425,   69,   69,   69,   73,
			   69,   69,  612,  951,  614,   15,  956,  595,   77,  399,
			   78,   23,  931,   29,   83,   74,   74,   75,   76,   94,
			  245,   94,   94,   94,  251,   94,   94,  256, 1176,   98,
			   99,   41,  101,  258,   74,   29,  104,  956,   25,  122,

			   27,  115,  117,  112,  113,  114,   64,   69,  117,  136,
			   13, 1199,   15,  122,  137,  233,  234, 1005,   70,    5,
			 1017,  909, 1138,    0,   90, 1186,  872,  125,   25,   15,
			   27,   64,   94,  142,  261,  869,   77, 1034,  137,  298,
			  167, 1038,  752,  299,  300,  933,   23,   74,  685,  245,
			  138,   37,  179, 1043,  652,   41,  127,  137,  167,   45,
			 1176,  824,  258,  755,  105,  260,  945,  946,  902,    0,
			 1067,  917,  181,  182,  183,  184,  704,   74,  187,  194,
			  138,  137,  191, 1199, 1043,  194,  920,  196,  554,  555,
			  740,  116,  126,    0,  202,  204,  553, 1085,  977,  508,

			  934,  167,  511,  949,  304,  138,  233,  234,  292, 1106,
			  137,  999,  123,  179,  596,  160,  127,  599,  631,  632,
			  186,  236, 1138,  833,   74,  394,  596,  236,  312,  599,
			  893, 1010,  541,   15,   44,  402,  122,   74, 1017, 1136,
			  137,  410,  251,  124,  978,  254,  576,   44,  578,   59,
			  580,  137,  665,  111,  667, 1034,  111,  670,  267, 1038,
			 1176,  200,   59,  945,  946,  928,  137,   12,  193,  160,
			   13,  298,   15,  123,  687,  688, 1055,  160,  293,   15,
			  400,  809,   15, 1199,  293, 1061,  123,  414, 1067,   34,
			  299,  300,   74,   75,   76, 1029,  154,  155,  313,  154,

			  155, 1138,  160,   44,  313,  160,   77,  316,   77, 1206,
			  235,  445,  446,  447,  409,  640,  241,  127,   59,  671,
			  672,  673,   15,  851,  706,  126,  127, 1106,  856,  128,
			  127,  829,  298, 1109,  105, 1017,  706, 1116,  137, 1176,
			  649,  286,  287,  288,   37,   15,  948,  514,   41,   25,
			  517,   27, 1034,   23,  381,  664, 1038, 1136,   28,   69,
			  369,  130, 1199,  132,  133,  392,   25,  292,   27,  945,
			  946,   25,  381,   27,  130,  341,  342,   12,  876,  792,
			  793,   15,   16,  124,   94, 1067,  127,  312,  397,  127,
			  399,  945,  946,  402,   59,  286,  287,  288,   74,   34,

			 1002, 1003,   15,  286,  287,  288,   40,  130,  417,  418,
			   15,   62,   63,   64,   65,   74,  425,   25,  826,   27,
			   74,  787,  788,   25, 1106,   27,   18, 1206,   14,  287,
			  288,  788,  287,  288,   74,   75,   76,   77,   60,   31,
			  127, 1017,  799,   40,  611,  612,  613,  614, 1050, 1051,
			   15,  138,   24,   30, 1136,   77, 1138,   49, 1034,  384,
			  385,  386, 1038, 1017,   36,  592,   74,  125,  627,  127,
			  626,  627,   74,   50,   51,   52,  635,   24,  573,  130,
			 1034,   15,  848,  105, 1038,  652,   77,  502,  454,   36,
			  502, 1067,  132,  133, 1176,  127,  591,   74,   75,   76,

			  128,  123,   74,   75,   76,  514,  138,  602,  517,  137,
			  132,  133,  837, 1067,  122,   28,   18, 1199,    9,   10,
			   60,  460, 1124, 1125, 1206,   72,  553,   74,   75,   76,
			 1106,   16,  123,  548,   47,   48,   13,   77,   15,  548,
			   77,  132,  133,    9,   10,  554,  555,   49,   50,   15,
			   52,   15, 1106,   19,  131,  570,   77,   23,  567,  106,
			 1136,  570,   28,  130,  682,  105,  575,  576,  105,  578,
			  122,  580,  124,  740,   24,  702,   15,  124,  745,  127,
			  128,   15, 1136,  123,  105,   19,   36,  596,   54,   23,
			  599,   43,  132,  133,   28,  132,  133,  125,  625,  127,

			  627,  540,  611,  612,  613,  614,  762,  634,  635,  130,
			  130,  132,  133,    9,   10,   44,  625,  626,  627,   15,
			   54,  716,  547,   19,   74,   75,   76,   23,  637,  125,
			 1206,  127,   28,   60,  600,  124,  561,  126,   21,  926,
			  927,   24,  929,  652,  569,   44,   29,  814,   21,   47,
			   77,   24, 1206,   36,   15,  682,  122,  944,   54,  625,
			   77,  627,  829,   36,   15,  952,  953,  954,  634,  635,
			   15,   16,   77,  800,  889,  125,  685,  892,  105,    9,
			   10,  690,  691,  810,   77,    4,   15, 1012,  105,   19,
			   19,   74,   75,   76,   23,   40,  123,  706,   15,   28,

			  105,   74,   75,   76,  713,  132,  133,   62,   63,  876,
			   65,  650,  105,  130, 1001,  132,  133,   15,  123, 1006,
			 1007,  936,  139,  126,  127,   54,  122,  132,  133,   18,
			   15,  740,   73,  247,  248,  123,  745,  130,   18,  132,
			  133,  124,   31,  126,  127,   24,  671,  672,  673,  715,
			  264,   31,  761,  762, 1041,  123,  122,   36,  124,  786,
			   49,  788, 1049,   25,  859,   27,  775,  108,  109,   49,
			   18,  798,  799,  114,  115,  116,   15,  786,  787,  788,
			   74,   75,   76,   31,  123, 1000,   74,   75,   76,  376,
			  377,  132,  133,   72, 1009,   74,   75,   76,  130, 1086,

			 1087,   49,   15,   21,   15,  814,   24,  816,  817,  818,
			  819,   29,  778,  908,   74,   75,   76,  826,   36,   15,
			  829,  127,  128,   48, 1039, 1040,  765,  106,  924,  925,
			  130,  125,  138, 1048,   15,  123, 1123,   74,  847,  848,
			  131,  807,   15,  122,  859,  124,  859,  859,  859,  690,
			  691,  859,   74,   75,   76,  125,   74,   75,   76,   24,
			  869,   26,  137,  123,   37,   15,  881,  876,   41,  881,
			    0,    1,   45, 1088, 1089, 1090,   15,   15,  974,   15,
			   74,   75,   76,   77,  106,  127,  128,  853,   13,   14,
			   15,  138,  130,  902,  903,   28,  138,  836,  906,  995,

			  122,   72,  868,   74,   75,   76,  124, 1122,  126,  127,
			  919,  920,  124,  922, 1129, 1130, 1131,  932,   43, 1015,
			  932,  887,  930,   15, 1020,  934,  935,   62,   62,  938,
			  939,  940,  941,  127,  122,  943,  945,  946,  132,  133,
			   30,  127,  128,   15,   15,   37,   39,  955,  957,   41,
			   33,   30,  138,   45,   30, 1138,   74,   75,   76,   77,
			   50,   51,   52,   15, 1060, 1061,   23,   30,  977,  978,
			  137,   50,   51,   52,   50,   51,   52,   15, 1193, 1194,
			 1195,   29,  128,  127,   74,   75,   76,   50,   51,   52,
			   74,   75,   76, 1176,  960,   74,   75,   76,   74,   75,

			   76, 1010,  968,  969, 1100,  127,   41,   73, 1017,  127,
			   15,   74,   75,   76,  132,  133, 1199, 1026,  128,   56,
			 1029,  128,  106, 1032,  128, 1034,  127,  128,  123, 1038,
			   37,   15,  971,    6, 1042,   15,  125,  138,  123,  185,
			  127, 1056,  108,  109, 1056,   15, 1055,  986,  114,  115,
			  116,  128, 1018,  127,  127, 1021,  138, 1065, 1067,    8,
			 1069,    9,   10,   12, 1073, 1074,   15,   15,  127,   18,
			  128,   19,   21,  219,  127,   23,  127,    9,   10,  124,
			   28,  130,   31,   15,   33,   34, 1095,   19, 1097,   60,
			   39,   23,   74,   75,   76, 1191,   28, 1106,  128,  128,

			   49,   50,  128,   52,   45, 1113,   54, 1116,  254,  111,
			   74,   75,   76,   13,   14,   15,   16,  119,  120,  121,
			   15,  125,   54, 1138, 1133, 1138,   15, 1136,   28, 1138,
			 1138,    8,  122,  127,  136,   12,  137, 1076,   15, 1148,
			   40,   18,  127,   43,   21,   50,   51,   47,   48,  128,
			  126,  153,  154,  155,   31,  127,   33,   34,  160, 1098,
			  128, 1176,   39, 1176,  125,  167,  123, 1176, 1176,   74,
			   75,   76,   49,   50,  127,   52,  123,  179, 1117,  123,
			 1189,   74,   75,   76, 1199,  123, 1199,  123,  137,  335,
			 1199, 1199, 1201, 1132,  123, 1134, 1211, 1206,  938,  939,

			  940,  941, 1168,  349,  350,  351,  352,  128,  127,  355,
			  356,  357,  358,  359,  360,  361,  362,  363,  364,  365,
			  366,  367,  368,   13,  127,   15, 1165,  138,  374,  375,
			  127,  233,  234,   17,  128,  237,  238,  239,  181,  182,
			  183, 1180,  128,  127,  187,  153,  154,  155,  191, 1188,
			    0,   15,   15,  196,  816,  817,  818,  819,    8,  123,
			  137,  153,  154,  155,    4,   15, 1205,   15,   18,   28,
			   73,   21,  137,   23, 1213,   78,   79,   80,   28,   82,
			   18,   19,   20,   73,  286,  287,  288,  127,   78,   79,
			   80,  123,   82,  295,  296,  297,  298,  128,   15,   49,

			   50,  128,   52,    9,   54,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  130,  125,  125,  130,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,   30,    3,  132,
			  133,  127,  135,  136,    9,  337,  127,   19,   15,  128,
			  128,  126,  132,  133,   19,  135,  136,   50,   51,   52,
			  122,   21,  123,   64,   64,   30,  138,  130,  128,  124,
			   35,  130,  508,  130,  130,  511,  122,   42,   61,  130,
			  130,   74,   75,   76,  128,   50,   51,   52,   77,  381,
			   77,  122,   57,   15,   58,   60,   54,   58,  123,  535,
			  392,  537,   67,   68,   69,  541,   71,   72,   73,   74,

			   75,   76,   77,   44,  138,   58,   81,   15,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,   73,  128,  126,    8,    8,   78,   79,   80,
			    8,   82,  117,  118,  119,  128,  121,  122,  127,  124,
			  125,    8,   18,  122,  129,   79,   30,  132,  133,  134,
			   23, 1104,  138,  138,  139,  586,  853,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,   50,   51,   52,  745,
			  652,  859,  417,   46,  417,   65,  219,   15, 1113,   17,
			  508,  132,  133,  270,  135,  136,  624,  109,  101,  859,

			   74,   75,   76,  649,   67,   68,   69,  876,   71,   37,
			   38,  109,  658,   41,   77,  270,  830,   45,  664,  270,
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,
			  103,  104,  105,  266,  402,   15, 1146,   17,  550,  551,
			  552,  553,  144,  438,   73,  118,  119,  109,  685,  122,
			  262,  561,  235, 1199, 1176,  664,  823,   37,  656,  132,
			  133,   41,    3,  780,  649,   45,   -1,   -1,    9,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   19,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,   -1,   30,

			   -1,   -1,   -1,   -1,   35,   -1,   -1,   -1,   -1,   -1,
			   -1,   42,   -1,  132,  133,   -1,  135,  136,   -1,   50,
			   51,   52,   -1,  625,   -1,  627,   57,   -1,   -1,   60,
			   -1,   -1,  634,  635,  780,   -1,   67,   68,   69,   -1,
			   71,   72,   73,   74,   75,   76,   77,   -1,   -1,   -1,
			   81,    9,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,   -1,   -1,   -1,   -1,
			  682,   -1,   -1,   -1,   -1,   -1,  117,  118,  119,   -1,
			  121,  122,   -1,  124,   -1,   -1,   -1,   -1,  129,   -1,

			   -1,  132,  133,  134,   -1,   -1,   -1,  138,  139,   67,
			   68,   69,   -1,   71,   -1,   -1,   74,   75,   76,   77,
			   -1,   -1,   -1,   -1,   -1,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,  104,  105,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  903,   -1,   -1,
			  118,  119,   -1,   -1,   19,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  919,  132,  133,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  786,   -1,  788,   -1,   -1,  935,
			   -1,   -1,   -1,   -1,   -1,   -1,  798,  799,   -1,   -1,

			   -1,   -1,   57,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  957,   -1,   -1,   -1,   -1,   71,   72,   -1,   74,
			   75,   76,   77,   -1,   -1,   -1,  972,  973,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			   -1,  106,   -1,   47,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  118,  119,   -1,   -1,  122,   -1,  124,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  132,  133,   73,
			 1026, 1027, 1028,   -1,   78,   79,   80,   -1,   82, 1035,
			 1036, 1037,   83,   84,   85,   86,   87,   88,   89,   90,

			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,   -1,   -1,   -1,   -1, 1073, 1074,   -1,
			  124,   -1,  126,   -1,   -1,   -1,  130,   -1,  132,  133,
			   -1,  135,  136,   -1,  138,   -1,   -1,   -1,    3,   -1,
			   -1,   -1,    7,   -1,    9,   -1,   11,   12,   13,   14,
			   15,   16,   -1,   18,   19,   20,   -1,   22,   23,   -1,
			   -1,   26,   -1,   28, 1120,   30,   31,   32,   -1,   34,
			   35,   -1,   -1,   -1,   -1,   40,   -1,   42,   43,   44,
			   -1,   -1,   47,   48,   49,   50,   51,   52,   -1, 1145,

			   -1,   -1,   57,   -1,   -1,   60,   61,   -1,   -1, 1155,
			   -1, 1013,   67,   68,   69,   -1,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,   -1,  121,  122,   -1,  124,
			  125,   -1,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,    3,   -1,   -1,   -1,    7,   -1,
			    9,   -1,   11,   12,   13,   14,   15,   16,   -1,   18,

			   19,   20,   -1,   22,   23,   -1,   -1,   26,   -1,   28,
			   -1,   30,   31,   32,   -1,   34,   35,   -1,   -1,   -1,
			   -1,   40,   -1,   42,   43,   44,   -1,   -1,   47,   48,
			   49,   50,   51,   52,   -1,   -1,   -1,   -1,   57,   -1,
			   -1,   60,   61,   -1,   -1,   -1,   -1,   -1,   67,   68,
			   69,   -1,   71,   72,   73,   74,   75,   76,   77,   78,
			   79,   80,   81,   82,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,

			  119,   -1,  121,  122,   -1,  124,  125,   -1,  127,  128,
			  129,   -1,  131,  132,  133,  134,  135,  136,  137,  138,
			    3,   -1,   -1,   -1,    7,   -1,    9,   -1,   11,   12,
			   13,   14,   15,   16,   -1,   18,   19,   20,   -1,   22,
			   23,   -1,   -1,   26,   -1,   28,   -1,   30,   31,   32,
			   -1,   34,   35,   -1,   -1,   -1,   -1,   40,   -1,   42,
			   43,   44,   -1,   -1,   47,   48,   49,   50,   51,   52,
			   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,   61,   -1,
			   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,
			   73,   74,   75,   76,   77,   78,   79,   80,   81,   82,

			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,
			  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,   -1,  121,  122,
			   -1,  124,  125,   -1,  127,  128,  129,   -1,  131,  132,
			  133,  134,  135,  136,  137,  138,    3,   -1,   -1,   -1,
			    7,   -1,    9,   -1,   11,   12,   13,   14,   15,   16,
			   -1,   18,   19,   20,   -1,   22,   23,   -1,   -1,   26,
			   -1,   28,   -1,   30,   31,   32,   -1,   34,   35,   -1,
			   -1,   -1,   -1,   40,   -1,   42,   43,   44,   -1,   -1,

			   47,   48,   49,   50,   51,   52,   -1,   -1,   -1,   -1,
			   57,   -1,   -1,   60,   61,   -1,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   73,   74,   75,   76,
			   77,   78,   79,   80,   81,   82,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,   -1,  121,  122,   -1,  124,  125,   -1,
			  127,  128,  129,   -1,  131,  132,  133,  134,  135,  136,
			  137,  138,    3,   -1,   -1,   -1,   -1,   -1,    9,   -1,

			   -1,   12,   -1,   -1,   15,   -1,   -1,   18,   19,   -1,
			   -1,   -1,   23,   -1,   -1,   -1,   -1,   -1,   -1,   30,
			   31,   -1,   -1,   34,   35,   -1,   -1,   -1,   -1,   40,
			   -1,   42,   -1,   -1,   -1,   -1,   47,   48,   49,   50,
			   51,   52,   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,
			   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,   69,   -1,
			   71,   72,   73,   74,   75,   76,   77,   78,   79,   80,
			   81,   82,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,   -1,  108,  109,  110,

			  111,  112,  113,  114,  115,  116,  117,  118,  119,   -1,
			  121,  122,   -1,  124,   -1,  126,   -1,   -1,  129,  130,
			   -1,  132,  133,  134,  135,  136,  137,  138,    3,   -1,
			   -1,   -1,   -1,   -1,    9,   -1,   -1,   12,   -1,   -1,
			   15,   -1,   -1,   18,   19,   -1,   -1,   -1,   23,   -1,
			   -1,   -1,   -1,   -1,   -1,   30,   31,   -1,   -1,   34,
			   35,   -1,   -1,   -1,   -1,   40,   -1,   42,   -1,   -1,
			   -1,   -1,   47,   48,   49,   50,   51,   52,   -1,   -1,
			   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,
			   -1,   -1,   67,   68,   69,   -1,   71,   72,   73,   74,

			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,   -1,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,   -1,  121,  122,   -1,  124,
			   -1,  126,   -1,   -1,  129,  130,   -1,  132,  133,  134,
			  135,  136,  137,  138,    3,   -1,   -1,   -1,    7,   -1,
			    9,   -1,   11,   -1,   13,   14,   15,   16,   -1,   -1,
			   19,   20,   -1,   22,   -1,   -1,   -1,   26,   -1,   28,
			   -1,   -1,   -1,   -1,   -1,   -1,   35,   -1,   -1,   -1,

			   -1,   40,   -1,   42,   43,   -1,   -1,   -1,   47,   48,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   57,   -1,
			   -1,   60,   -1,   62,   -1,   -1,   -1,   -1,   67,   68,
			   69,   -1,   71,   72,   -1,   74,   75,   76,   77,   -1,
			   -1,   -1,   -1,   -1,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,  106,  107,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  117,  118,
			  119,   -1,   -1,  122,   -1,  124,   -1,   -1,   -1,   -1,
			  129,   -1,  131,   -1,   -1,   -1,    3,   -1,  137,  138,

			    7,   -1,    9,   -1,   11,   -1,   13,   14,   15,   16,
			   -1,   -1,   19,   20,   -1,   22,   -1,   -1,   -1,   26,
			   -1,   28,   -1,   -1,   -1,   -1,   -1,   -1,   35,   -1,
			   -1,   -1,   -1,   40,   -1,   42,   43,   -1,   -1,   -1,
			   47,   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   -1,   74,   75,   76,
			   77,   -1,   -1,   -1,   -1,   -1,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,  106, yyDummy>>,
			1, 3000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  107,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  117,  118,  119,   -1,   -1,  122,   -1,  124,   -1,   -1,
			   -1,   -1,  129,  130,  131,   -1,   -1,   -1,    3,   -1,
			  137,  138,    7,   -1,    9,   -1,   11,   -1,   13,   14,
			   15,   16,   -1,   -1,   19,   20,   -1,   22,   -1,   -1,
			   -1,   26,   -1,   28,   -1,   -1,   -1,   -1,   -1,   -1,
			   35,   -1,   -1,   -1,   -1,   40,   -1,   42,   43,   -1,
			   -1,   -1,   47,   48,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,
			   -1,   -1,   67,   68,   69,   -1,   71,   72,   -1,   74,

			   75,   76,   77,   -1,   -1,   -1,   -1,   -1,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,   -1,    3,   -1,   -1,   -1,   -1,   -1,
			    9,   -1,  117,  118,  119,   -1,   15,  122,   -1,  124,
			   19,   -1,   -1,   -1,  129,   -1,  131,   -1,   -1,   -1,
			   -1,   30,  137,  138,   -1,   -1,   35,   -1,   -1,   -1,
			   -1,   -1,   -1,   42,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   50,   51,   52,   -1,   -1,   -1,   -1,   57,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,

			   69,   -1,   71,   72,   73,   74,   75,   76,   77,   -1,
			   -1,   -1,   81,   -1,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,  106,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,    3,   -1,   -1,  117,  118,
			  119,    9,  121,  122,   -1,  124,   -1,   15,   -1,   -1,
			  129,   19,   -1,  132,  133,  134,   -1,   -1,   -1,  138,
			   -1,   -1,   30,   -1,   -1,   -1,   -1,   35,   -1,   -1,
			   -1,   -1,   -1,   -1,   42,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   50,   51,   52,   -1,   -1,   -1,   -1,   57,

			   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   67,
			   68,   69,   -1,   71,   72,   73,   74,   75,   76,   77,
			   -1,   -1,   -1,   81,   -1,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,  104,  105,  106,   -1,
			   -1,    3,   -1,   -1,   -1,   -1,   -1,    9,   -1,  117,
			  118,  119,   -1,  121,  122,   -1,  124,   19,   -1,   -1,
			   -1,  129,   -1,   -1,  132,  133,  134,   -1,   30,   -1,
			  138,   -1,   -1,   35,   -1,   -1,   -1,   -1,   -1,   -1,
			   42,   -1,   44,   -1,   -1,   -1,   -1,   -1,   50,   51,

			   52,   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,   -1,
			   -1,   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,
			   72,   73,   74,   75,   76,   77,   -1,   -1,   -1,   81,
			   -1,   83,   84,   85,   86,   87,   88,   89,   90,   91,
			   92,   93,   94,   95,   96,   97,   98,   99,  100,  101,
			  102,  103,  104,  105,  106,   -1,   -1,   -1,    3,   -1,
			   -1,   -1,   -1,   -1,    9,  117,  118,  119,   13,  121,
			  122,   -1,  124,   -1,   19,   -1,   -1,  129,   -1,   -1,
			  132,  133,  134,   -1,   -1,   30,  138,   -1,   -1,   -1,
			   35,   -1,   -1,   -1,   -1,   -1,   -1,   42,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   50,   51,   52,   -1,   -1,
			   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,
			   -1,   -1,   67,   68,   69,   -1,   71,   72,   73,   74,
			   75,   76,   77,   -1,   -1,   -1,   81,   -1,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,   -1,   -1,    3,   -1,   -1,   -1,   -1,   -1,
			    9,   -1,  117,  118,  119,   -1,  121,  122,   -1,  124,
			   19,   -1,   -1,   -1,  129,   -1,   -1,  132,  133,  134,
			   -1,   30,   -1,  138,   -1,   -1,   35,   -1,   -1,   -1,

			   -1,   -1,   -1,   42,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   50,   51,   52,   -1,   -1,   -1,   -1,   57,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,
			   69,   -1,   71,   72,   73,   74,   75,   76,   77,   -1,
			   -1,   -1,   81,   -1,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,  106,   -1,   -1,
			    3,   -1,   -1,   -1,   -1,   -1,    9,   -1,  117,  118,
			  119,   -1,  121,  122,   -1,  124,   19,   -1,   -1,  128,
			  129,   -1,   -1,  132,  133,  134,   -1,   30,   -1,  138,

			   -1,   -1,   35,   -1,   -1,   -1,   -1,   -1,   -1,   42,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   50,   51,   52,
			   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,
			   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,
			   73,   74,   75,   76,   77,   -1,   -1,   -1,   81,   -1,
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,
			  103,  104,  105,  106,   -1,   -1,   -1,    3,   -1,   -1,
			   -1,   -1,   -1,    9,  117,  118,  119,   -1,  121,  122,
			   -1,  124,  125,   19,   -1,   -1,  129,   -1,   -1,  132,

			  133,  134,   -1,   -1,   30,  138,   -1,   -1,   -1,   35,
			   -1,   -1,   -1,   -1,   -1,   -1,   42,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   50,   51,   52,   -1,   -1,   -1,
			   -1,   57,   -1,   -1,   60,   61,   -1,   -1,   -1,   -1,
			   -1,   67,   68,   69,   -1,   71,   72,   73,   74,   75,
			   76,   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,  104,  105,
			  106,   -1,   -1,    3,   -1,   -1,   -1,   -1,   -1,    9,
			   -1,  117,  118,  119,   -1,  121,  122,   -1,  124,   19,

			   -1,   -1,   -1,  129,   -1,   -1,  132,  133,  134,   -1,
			   30,   -1,  138,   -1,   -1,   35,   -1,   -1,   -1,   -1,
			   -1,   -1,   42,   -1,   44,   -1,   -1,   -1,   -1,   -1,
			   50,   51,   52,   -1,   -1,   -1,   -1,   57,   -1,   -1,
			   60,   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,   69,
			   -1,   71,   72,   73,   74,   75,   76,   77,   -1,   -1,
			   -1,   81,   -1,   83,   84,   85,   86,   87,   88,   89,
			   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,
			  100,  101,  102,  103,  104,  105,  106,   -1,   -1,   -1,
			    3,   -1,   -1,   -1,   -1,   -1,    9,  117,  118,  119,

			   13,  121,  122,   -1,  124,   -1,   19,   -1,   -1,  129,
			   -1,   -1,  132,  133,  134,   -1,   -1,   30,  138,   -1,
			   -1,   -1,   35,   -1,   -1,   -1,   -1,   -1,   -1,   42,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   50,   51,   52,
			   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,
			   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,
			   73,   74,   75,   76,   77,   -1,   -1,   -1,   81,   -1,
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,
			  103,  104,  105,  106,   -1,   -1,    3,   -1,   -1,   -1,

			   -1,   -1,    9,   -1,  117,  118,  119,   -1,  121,  122,
			   -1,  124,   19,   -1,   -1,   -1,  129,   -1,   -1,  132,
			  133,  134,   -1,   30,   -1,  138,   -1,   -1,   35,   -1,
			   -1,   -1,   -1,   -1,   -1,   42,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   50,   51,   52,   -1,   -1,   -1,   -1,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   73,   74,   75,   76,
			   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,  106,

			   -1,   -1,    3,   -1,   -1,   -1,   -1,   -1,    9,   -1,
			  117,  118,  119,   -1,  121,  122,   -1,  124,   19,   -1,
			   -1,  128,  129,   -1,   -1,  132,  133,  134,   -1,   30,
			   -1,  138,   -1,   -1,   35,   -1,   -1,   -1,   -1,   -1,
			   -1,   42,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   50,
			   51,   52,   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,
			   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,   69,   -1,
			   71,   72,   73,   74,   75,   76,   77,   -1,   -1,   -1,
			   81,   -1,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,

			  101,  102,  103,  104,  105,  106,    3,   -1,   -1,   -1,
			   -1,   -1,    9,   -1,   -1,   -1,  117,  118,  119,   -1,
			  121,  122,   19,  124,   -1,   -1,   -1,   -1,  129,   -1,
			   -1,  132,  133,  134,   -1,   -1,   -1,  138,   35,   -1,
			   -1,   -1,   -1,   -1,   -1,   42,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   73,   74,   75,   76,
			   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,

			   97,   98,   99,  100,  101,  102,  103,  104,  105,  106,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  117,  118,  119,   -1,  121,  122,   -1,  124,   -1,   -1,
			   -1,   -1,  129,   -1,    3,  132,  133,  134,    7,   -1,
			    9,  138,   11,   -1,   13,   14,   15,   16,   -1,   -1,
			   19,   20,   -1,   22,   -1,   -1,   -1,   26,   -1,   28,
			   -1,   -1,   -1,   -1,   -1,   -1,   35,   -1,   -1,   -1,
			   -1,   40,   -1,   42,   43,   -1,   -1,   -1,   47,   48,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   57,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,

			   69,   -1,   71,   72,   -1,   74,   75,   76,   77,   -1,
			   -1,   -1,   -1,   -1,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,  106,  107,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  117,  118,
			  119,   -1,   -1,  122,   -1,  124,   -1,   -1,   -1,    3,
			  129,   -1,  131,    7,   -1,    9,   -1,   11,  137,   13,
			   14,   15,   16,   -1,   -1,   19,   20,   -1,   22,   -1,
			   -1,   -1,   26,   -1,   28,   -1,   -1,   -1,   -1,   -1,
			   -1,   35,   -1,   -1,   -1,   -1,   40,   -1,   42,   43,

			   -1,   -1,   -1,   47,   48,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,   -1,
			   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,   -1,
			   74,   75,   76,   77,   -1,   -1,   -1,   -1,   -1,   83,
			   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,  101,  102,  103,
			  104,  105,  106,  107,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  117,  118,  119,   -1,   -1,  122,   -1,
			  124,   -1,   -1,   -1,    3,  129,   -1,  131,    7,   -1,
			    9,   -1,   11,  137,   13,   14,   15,   16,   -1,   -1,

			   19,   20,   -1,   22,   -1,   -1,   -1,   26,   -1,   28,
			   -1,   -1,   -1,   -1,   -1,   -1,   35,   -1,   -1,   -1,
			   -1,   40,   -1,   42,   43,   -1,   -1,   -1,   47,   48,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   57,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   67,   68,
			   69,   -1,   71,   72,   -1,   74,   75,   76,   77,   -1,
			   -1,   -1,   -1,   -1,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,  106,  107,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  117,  118,

			  119,   -1,   -1,  122,   -1,  124,   -1,   -1,   -1,    3,
			  129,   -1,  131,    7,   -1,    9,   -1,   11,  137,   13,
			   14,   15,   16,   -1,   -1,   19,   20,   -1,   22,   -1,
			   -1,   -1,   26,   -1,   28,   -1,   -1,   -1,   -1,   -1,
			   -1,   35,   -1,   -1,   -1,   -1,   40,   -1,   42,   43,
			   -1,   -1,   -1,   47,   48,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   57,   -1,   -1,   60,   -1,   -1,   -1,
			   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,   -1,
			   74,   75,   76,   77,   -1,   -1,   -1,   -1,   -1,   83,
			   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,

			   94,   95,   96,   97,   98,   99,  100,  101,  102,  103,
			  104,  105,  106,  107,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  117,  118,  119,   -1,   -1,  122,   -1,
			  124,   -1,    3,   -1,   -1,  129,    7,  131,    9,   -1,
			   11,   -1,   -1,  137,   -1,   -1,   -1,   -1,   19,   20,
			    8,   22,   -1,   -1,   12,   26,   -1,   15,   -1,   -1,
			   18,   -1,   -1,   21,   35,   -1,   -1,   -1,   -1,   -1,
			   -1,   42,   -1,   31,   -1,   33,   34,   -1,   -1,   -1,
			   -1,   39,   -1,   -1,   -1,   -1,   57,   -1,   -1,   60,
			   -1,   49,   50,   -1,   52,   -1,   67,   68,   69,   -1,

			   71,   72,   -1,   74,   75,   76,   77,   -1,   -1,   32,
			   -1,   -1,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,  107,   73,   -1,   -1,
			   -1,   -1,   78,   79,   80,   -1,  117,  118,  119,   -1,
			   73,  122,   -1,  124,   -1,   78,   79,   80,  129,   82,
			  131,   -1,   -1,   -1,   -1,   -1,  137,   35,   -1,   -1,
			   -1,   -1,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,   -1,   -1,   -1,   -1,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,   -1,   -1,  132,  133,   -1,  135,

			  136,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  132,
			  133,   -1,  135,  136,   -1,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,  104,   61,   73,   -1,
			   -1,   -1,   -1,   78,   79,   80,   -1,   82,   -1,   73,
			   -1,  119,   -1,   -1,   78,   79,   80,   -1,   82,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,   -1,   -1,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,   -1,   -1,   -1,   -1,  132,  133,   -1,

			  135,  136,  137,  127,   -1,   -1,   -1,   -1,  132,  133,
			   73,  135,  136,   -1,   -1,   78,   79,   80,   -1,   82,
			   -1,   73,   -1,   -1,   -1,   -1,   78,   79,   80,   -1,
			   82,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,   -1,   -1,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,   -1,   -1,   -1,   -1,  132,
			  133,   -1,  135,  136,  137,  127,  128,   -1,   -1,   -1,
			  132,  133,   73,  135,  136,   -1,   -1,   78,   79,   80,
			   -1,   82,   -1,   83,   84,   85,   86,   87,   88,   89,

			   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,
			  100,  101,  102,  103,  104,   -1,   -1,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,   73,   -1,   -1,  119,
			   -1,   78,   79,   80,  125,   82,  127,   -1,   -1,   -1,
			   -1,  132,  133,   -1,  135,  136,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   73,   -1,   -1,   -1,   -1,
			   78,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			   73,   -1,   -1,   -1,   -1,   78,   79,   80,   -1,   82,
			  127,  128,   -1,   -1,   -1,  132,  133,   -1,  135,  136,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,   -1,

			   -1,   -1,   -1,   -1,   -1,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  132,  133,   -1,  135,  136,   -1,
			   -1,   -1,  125,   -1,   -1,   -1,   -1,   -1,   -1,  132,
			  133,   -1,  135,  136,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   -1,   -1,  101,  102,  103,  104,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   -1,   -1,  101,  102,  103,  104, yyDummy>>,
			1, 2478, 3000)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [ANY]
			-- Stack for semantic values of type ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [ANY]
			-- Routines that ought to be in SPECIAL [ANY]

	yyvs2: SPECIAL [ET_KEYWORD]
			-- Stack for semantic values of type ET_KEYWORD

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [ET_KEYWORD]
			-- Routines that ought to be in SPECIAL [ET_KEYWORD]

	yyvs3: SPECIAL [ET_PRECURSOR_KEYWORD]
			-- Stack for semantic values of type ET_PRECURSOR_KEYWORD

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [ET_PRECURSOR_KEYWORD]
			-- Routines that ought to be in SPECIAL [ET_PRECURSOR_KEYWORD]

	yyvs4: SPECIAL [ET_SYMBOL]
			-- Stack for semantic values of type ET_SYMBOL

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [ET_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_SYMBOL]

	yyvs5: SPECIAL [ET_POSITION]
			-- Stack for semantic values of type ET_POSITION

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [ET_POSITION]
			-- Routines that ought to be in SPECIAL [ET_POSITION]

	yyvs6: SPECIAL [ET_BIT_CONSTANT]
			-- Stack for semantic values of type ET_BIT_CONSTANT

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [ET_BIT_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_BIT_CONSTANT]

	yyvs7: SPECIAL [ET_BOOLEAN_CONSTANT]
			-- Stack for semantic values of type ET_BOOLEAN_CONSTANT

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [ET_BOOLEAN_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_BOOLEAN_CONSTANT]

	yyvs8: SPECIAL [ET_BREAK]
			-- Stack for semantic values of type ET_BREAK

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [ET_BREAK]
			-- Routines that ought to be in SPECIAL [ET_BREAK]

	yyvs9: SPECIAL [ET_CHARACTER_CONSTANT]
			-- Stack for semantic values of type ET_CHARACTER_CONSTANT

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [ET_CHARACTER_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_CHARACTER_CONSTANT]

	yyvs10: SPECIAL [ET_CURRENT]
			-- Stack for semantic values of type ET_CURRENT

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [ET_CURRENT]
			-- Routines that ought to be in SPECIAL [ET_CURRENT]

	yyvs11: SPECIAL [ET_FREE_OPERATOR]
			-- Stack for semantic values of type ET_FREE_OPERATOR

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [ET_FREE_OPERATOR]
			-- Routines that ought to be in SPECIAL [ET_FREE_OPERATOR]

	yyvs12: SPECIAL [ET_IDENTIFIER]
			-- Stack for semantic values of type ET_IDENTIFIER

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [ET_IDENTIFIER]
			-- Routines that ought to be in SPECIAL [ET_IDENTIFIER]

	yyvs13: SPECIAL [ET_INTEGER_CONSTANT]
			-- Stack for semantic values of type ET_INTEGER_CONSTANT

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [ET_INTEGER_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_INTEGER_CONSTANT]

	yyvs14: SPECIAL [ET_KEYWORD_OPERATOR]
			-- Stack for semantic values of type ET_KEYWORD_OPERATOR

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [ET_KEYWORD_OPERATOR]
			-- Routines that ought to be in SPECIAL [ET_KEYWORD_OPERATOR]

	yyvs15: SPECIAL [ET_MANIFEST_STRING]
			-- Stack for semantic values of type ET_MANIFEST_STRING

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [ET_MANIFEST_STRING]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_STRING]

	yyvs16: SPECIAL [ET_REAL_CONSTANT]
			-- Stack for semantic values of type ET_REAL_CONSTANT

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [ET_REAL_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_REAL_CONSTANT]

	yyvs17: SPECIAL [ET_RESULT]
			-- Stack for semantic values of type ET_RESULT

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [ET_RESULT]
			-- Routines that ought to be in SPECIAL [ET_RESULT]

	yyvs18: SPECIAL [ET_RETRY_INSTRUCTION]
			-- Stack for semantic values of type ET_RETRY_INSTRUCTION

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [ET_RETRY_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_RETRY_INSTRUCTION]

	yyvs19: SPECIAL [ET_SYMBOL_OPERATOR]
			-- Stack for semantic values of type ET_SYMBOL_OPERATOR

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [ET_SYMBOL_OPERATOR]
			-- Routines that ought to be in SPECIAL [ET_SYMBOL_OPERATOR]

	yyvs20: SPECIAL [ET_VOID]
			-- Stack for semantic values of type ET_VOID

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [ET_VOID]
			-- Routines that ought to be in SPECIAL [ET_VOID]

	yyvs21: SPECIAL [ET_SEMICOLON_SYMBOL]
			-- Stack for semantic values of type ET_SEMICOLON_SYMBOL

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [ET_SEMICOLON_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_SEMICOLON_SYMBOL]

	yyvs22: SPECIAL [ET_BRACKET_SYMBOL]
			-- Stack for semantic values of type ET_BRACKET_SYMBOL

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [ET_BRACKET_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_BRACKET_SYMBOL]

	yyvs23: SPECIAL [ET_QUESTION_MARK_SYMBOL]
			-- Stack for semantic values of type ET_QUESTION_MARK_SYMBOL

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [ET_QUESTION_MARK_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_QUESTION_MARK_SYMBOL]

	yyvs24: SPECIAL [ET_ACTUAL_ARGUMENT_LIST]
			-- Stack for semantic values of type ET_ACTUAL_ARGUMENT_LIST

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [ET_ACTUAL_ARGUMENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_ACTUAL_ARGUMENT_LIST]

	yyvs25: SPECIAL [ET_ACTUAL_PARAMETER_ITEM]
			-- Stack for semantic values of type ET_ACTUAL_PARAMETER_ITEM

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [ET_ACTUAL_PARAMETER_ITEM]
			-- Routines that ought to be in SPECIAL [ET_ACTUAL_PARAMETER_ITEM]

	yyvs26: SPECIAL [ET_ACTUAL_PARAMETER_LIST]
			-- Stack for semantic values of type ET_ACTUAL_PARAMETER_LIST

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [ET_ACTUAL_PARAMETER_LIST]
			-- Routines that ought to be in SPECIAL [ET_ACTUAL_PARAMETER_LIST]

	yyvs27: SPECIAL [ET_AGENT_ARGUMENT_OPERAND]
			-- Stack for semantic values of type ET_AGENT_ARGUMENT_OPERAND

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [ET_AGENT_ARGUMENT_OPERAND]
			-- Routines that ought to be in SPECIAL [ET_AGENT_ARGUMENT_OPERAND]

	yyvs28: SPECIAL [ET_AGENT_ARGUMENT_OPERAND_ITEM]
			-- Stack for semantic values of type ET_AGENT_ARGUMENT_OPERAND_ITEM

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [ET_AGENT_ARGUMENT_OPERAND_ITEM]
			-- Routines that ought to be in SPECIAL [ET_AGENT_ARGUMENT_OPERAND_ITEM]

	yyvs29: SPECIAL [ET_AGENT_ARGUMENT_OPERAND_LIST]
			-- Stack for semantic values of type ET_AGENT_ARGUMENT_OPERAND_LIST

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [ET_AGENT_ARGUMENT_OPERAND_LIST]
			-- Routines that ought to be in SPECIAL [ET_AGENT_ARGUMENT_OPERAND_LIST]

	yyvs30: SPECIAL [ET_AGENT_TARGET]
			-- Stack for semantic values of type ET_AGENT_TARGET

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: KL_SPECIAL_ROUTINES [ET_AGENT_TARGET]
			-- Routines that ought to be in SPECIAL [ET_AGENT_TARGET]

	yyvs31: SPECIAL [ET_ALIAS_NAME]
			-- Stack for semantic values of type ET_ALIAS_NAME

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: KL_SPECIAL_ROUTINES [ET_ALIAS_NAME]
			-- Routines that ought to be in SPECIAL [ET_ALIAS_NAME]

	yyvs32: SPECIAL [ET_ASSIGNER]
			-- Stack for semantic values of type ET_ASSIGNER

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: KL_SPECIAL_ROUTINES [ET_ASSIGNER]
			-- Routines that ought to be in SPECIAL [ET_ASSIGNER]

	yyvs33: SPECIAL [ET_BRACKET_ARGUMENT_LIST]
			-- Stack for semantic values of type ET_BRACKET_ARGUMENT_LIST

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: KL_SPECIAL_ROUTINES [ET_BRACKET_ARGUMENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_BRACKET_ARGUMENT_LIST]

	yyvs34: SPECIAL [ET_BRACKET_EXPRESSION]
			-- Stack for semantic values of type ET_BRACKET_EXPRESSION

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: KL_SPECIAL_ROUTINES [ET_BRACKET_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_BRACKET_EXPRESSION]

	yyvs35: SPECIAL [ET_CALL_AGENT]
			-- Stack for semantic values of type ET_CALL_AGENT

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: KL_SPECIAL_ROUTINES [ET_CALL_AGENT]
			-- Routines that ought to be in SPECIAL [ET_CALL_AGENT]

	yyvs36: SPECIAL [ET_CALL_EXPRESSION]
			-- Stack for semantic values of type ET_CALL_EXPRESSION

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: KL_SPECIAL_ROUTINES [ET_CALL_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_CALL_EXPRESSION]

	yyvs37: SPECIAL [ET_CHOICE]
			-- Stack for semantic values of type ET_CHOICE

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: KL_SPECIAL_ROUTINES [ET_CHOICE]
			-- Routines that ought to be in SPECIAL [ET_CHOICE]

	yyvs38: SPECIAL [ET_CHOICE_CONSTANT]
			-- Stack for semantic values of type ET_CHOICE_CONSTANT

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: KL_SPECIAL_ROUTINES [ET_CHOICE_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_CHOICE_CONSTANT]

	yyvs39: SPECIAL [ET_CHOICE_ITEM]
			-- Stack for semantic values of type ET_CHOICE_ITEM

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: KL_SPECIAL_ROUTINES [ET_CHOICE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CHOICE_ITEM]

	yyvs40: SPECIAL [ET_CHOICE_LIST]
			-- Stack for semantic values of type ET_CHOICE_LIST

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: KL_SPECIAL_ROUTINES [ET_CHOICE_LIST]
			-- Routines that ought to be in SPECIAL [ET_CHOICE_LIST]

	yyvs41: SPECIAL [ET_CLASS]
			-- Stack for semantic values of type ET_CLASS

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: KL_SPECIAL_ROUTINES [ET_CLASS]
			-- Routines that ought to be in SPECIAL [ET_CLASS]

	yyvs42: SPECIAL [ET_CLASS_NAME_ITEM]
			-- Stack for semantic values of type ET_CLASS_NAME_ITEM

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: KL_SPECIAL_ROUTINES [ET_CLASS_NAME_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CLASS_NAME_ITEM]

	yyvs43: SPECIAL [ET_CLIENTS]
			-- Stack for semantic values of type ET_CLIENTS

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: KL_SPECIAL_ROUTINES [ET_CLIENTS]
			-- Routines that ought to be in SPECIAL [ET_CLIENTS]

	yyvs44: SPECIAL [ET_COMPOUND]
			-- Stack for semantic values of type ET_COMPOUND

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: KL_SPECIAL_ROUTINES [ET_COMPOUND]
			-- Routines that ought to be in SPECIAL [ET_COMPOUND]

	yyvs45: SPECIAL [ET_CONSTANT]
			-- Stack for semantic values of type ET_CONSTANT

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: KL_SPECIAL_ROUTINES [ET_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_CONSTANT]

	yyvs46: SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM]
			-- Stack for semantic values of type ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM]

	yyvs47: SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_LIST]
			-- Stack for semantic values of type ET_CONSTRAINT_ACTUAL_PARAMETER_LIST

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_ACTUAL_PARAMETER_LIST]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_LIST]

	yyvs48: SPECIAL [ET_CONSTRAINT_CREATOR]
			-- Stack for semantic values of type ET_CONSTRAINT_CREATOR

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_CREATOR]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_CREATOR]

	yyvs49: SPECIAL [ET_CONSTRAINT_TYPE]
			-- Stack for semantic values of type ET_CONSTRAINT_TYPE

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_TYPE]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_TYPE]

	yyvs50: SPECIAL [ET_CONVERT_FEATURE]
			-- Stack for semantic values of type ET_CONVERT_FEATURE

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: KL_SPECIAL_ROUTINES [ET_CONVERT_FEATURE]
			-- Routines that ought to be in SPECIAL [ET_CONVERT_FEATURE]

	yyvs51: SPECIAL [ET_CONVERT_FEATURE_ITEM]
			-- Stack for semantic values of type ET_CONVERT_FEATURE_ITEM

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: KL_SPECIAL_ROUTINES [ET_CONVERT_FEATURE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CONVERT_FEATURE_ITEM]

	yyvs52: SPECIAL [ET_CONVERT_FEATURE_LIST]
			-- Stack for semantic values of type ET_CONVERT_FEATURE_LIST

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: KL_SPECIAL_ROUTINES [ET_CONVERT_FEATURE_LIST]
			-- Routines that ought to be in SPECIAL [ET_CONVERT_FEATURE_LIST]

	yyvs53: SPECIAL [ET_CREATE_EXPRESSION]
			-- Stack for semantic values of type ET_CREATE_EXPRESSION

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: KL_SPECIAL_ROUTINES [ET_CREATE_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_CREATE_EXPRESSION]

	yyvs54: SPECIAL [ET_CREATOR]
			-- Stack for semantic values of type ET_CREATOR

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: KL_SPECIAL_ROUTINES [ET_CREATOR]
			-- Routines that ought to be in SPECIAL [ET_CREATOR]

	yyvs55: SPECIAL [ET_CREATOR_LIST]
			-- Stack for semantic values of type ET_CREATOR_LIST

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: KL_SPECIAL_ROUTINES [ET_CREATOR_LIST]
			-- Routines that ought to be in SPECIAL [ET_CREATOR_LIST]

	yyvs56: SPECIAL [ET_DEBUG_INSTRUCTION]
			-- Stack for semantic values of type ET_DEBUG_INSTRUCTION

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: KL_SPECIAL_ROUTINES [ET_DEBUG_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_DEBUG_INSTRUCTION]

	yyvs57: SPECIAL [ET_ELSEIF_PART]
			-- Stack for semantic values of type ET_ELSEIF_PART

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: KL_SPECIAL_ROUTINES [ET_ELSEIF_PART]
			-- Routines that ought to be in SPECIAL [ET_ELSEIF_PART]

	yyvs58: SPECIAL [ET_ELSEIF_PART_LIST]
			-- Stack for semantic values of type ET_ELSEIF_PART_LIST

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: KL_SPECIAL_ROUTINES [ET_ELSEIF_PART_LIST]
			-- Routines that ought to be in SPECIAL [ET_ELSEIF_PART_LIST]

	yyvs59: SPECIAL [ET_EXPORT]
			-- Stack for semantic values of type ET_EXPORT

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: KL_SPECIAL_ROUTINES [ET_EXPORT]
			-- Routines that ought to be in SPECIAL [ET_EXPORT]

	yyvs60: SPECIAL [ET_EXPORT_LIST]
			-- Stack for semantic values of type ET_EXPORT_LIST

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: KL_SPECIAL_ROUTINES [ET_EXPORT_LIST]
			-- Routines that ought to be in SPECIAL [ET_EXPORT_LIST]

	yyvs61: SPECIAL [ET_EXPRESSION]
			-- Stack for semantic values of type ET_EXPRESSION

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: KL_SPECIAL_ROUTINES [ET_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_EXPRESSION]

	yyvs62: SPECIAL [ET_EXPRESSION_ITEM]
			-- Stack for semantic values of type ET_EXPRESSION_ITEM

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: KL_SPECIAL_ROUTINES [ET_EXPRESSION_ITEM]
			-- Routines that ought to be in SPECIAL [ET_EXPRESSION_ITEM]

	yyvs63: SPECIAL [ET_EXTENDED_FEATURE_NAME]
			-- Stack for semantic values of type ET_EXTENDED_FEATURE_NAME

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: KL_SPECIAL_ROUTINES [ET_EXTENDED_FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [ET_EXTENDED_FEATURE_NAME]

	yyvs64: SPECIAL [ET_EXTERNAL_ALIAS]
			-- Stack for semantic values of type ET_EXTERNAL_ALIAS

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: KL_SPECIAL_ROUTINES [ET_EXTERNAL_ALIAS]
			-- Routines that ought to be in SPECIAL [ET_EXTERNAL_ALIAS]

	yyvs65: SPECIAL [ET_FEATURE_CLAUSE]
			-- Stack for semantic values of type ET_FEATURE_CLAUSE

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: KL_SPECIAL_ROUTINES [ET_FEATURE_CLAUSE]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_CLAUSE]

	yyvs66: SPECIAL [ET_FEATURE_CLAUSE_LIST]
			-- Stack for semantic values of type ET_FEATURE_CLAUSE_LIST

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: KL_SPECIAL_ROUTINES [ET_FEATURE_CLAUSE_LIST]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_CLAUSE_LIST]

	yyvs67: SPECIAL [ET_FEATURE_EXPORT]
			-- Stack for semantic values of type ET_FEATURE_EXPORT

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: KL_SPECIAL_ROUTINES [ET_FEATURE_EXPORT]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_EXPORT]

	yyvs68: SPECIAL [ET_FEATURE_NAME]
			-- Stack for semantic values of type ET_FEATURE_NAME

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: KL_SPECIAL_ROUTINES [ET_FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_NAME]

	yyvs69: SPECIAL [ET_FEATURE_NAME_ITEM]
			-- Stack for semantic values of type ET_FEATURE_NAME_ITEM

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: KL_SPECIAL_ROUTINES [ET_FEATURE_NAME_ITEM]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_NAME_ITEM]

	yyvs70: SPECIAL [ET_FORMAL_ARGUMENT]
			-- Stack for semantic values of type ET_FORMAL_ARGUMENT

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: KL_SPECIAL_ROUTINES [ET_FORMAL_ARGUMENT]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_ARGUMENT]

	yyvs71: SPECIAL [ET_FORMAL_ARGUMENT_ITEM]
			-- Stack for semantic values of type ET_FORMAL_ARGUMENT_ITEM

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: KL_SPECIAL_ROUTINES [ET_FORMAL_ARGUMENT_ITEM]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_ARGUMENT_ITEM]

	yyvs72: SPECIAL [ET_FORMAL_ARGUMENT_LIST]
			-- Stack for semantic values of type ET_FORMAL_ARGUMENT_LIST

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: KL_SPECIAL_ROUTINES [ET_FORMAL_ARGUMENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_ARGUMENT_LIST]

	yyvs73: SPECIAL [ET_FORMAL_PARAMETER]
			-- Stack for semantic values of type ET_FORMAL_PARAMETER

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: KL_SPECIAL_ROUTINES [ET_FORMAL_PARAMETER]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_PARAMETER]

	yyvs74: SPECIAL [ET_FORMAL_PARAMETER_ITEM]
			-- Stack for semantic values of type ET_FORMAL_PARAMETER_ITEM

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: KL_SPECIAL_ROUTINES [ET_FORMAL_PARAMETER_ITEM]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_PARAMETER_ITEM]

	yyvs75: SPECIAL [ET_FORMAL_PARAMETER_LIST]
			-- Stack for semantic values of type ET_FORMAL_PARAMETER_LIST

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: KL_SPECIAL_ROUTINES [ET_FORMAL_PARAMETER_LIST]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_PARAMETER_LIST]

	yyvs76: SPECIAL [ET_IF_INSTRUCTION]
			-- Stack for semantic values of type ET_IF_INSTRUCTION

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: KL_SPECIAL_ROUTINES [ET_IF_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_IF_INSTRUCTION]

	yyvs77: SPECIAL [ET_INDEXING_LIST]
			-- Stack for semantic values of type ET_INDEXING_LIST

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: KL_SPECIAL_ROUTINES [ET_INDEXING_LIST]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_LIST]

	yyvs78: SPECIAL [ET_INDEXING_ITEM]
			-- Stack for semantic values of type ET_INDEXING_ITEM

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: KL_SPECIAL_ROUTINES [ET_INDEXING_ITEM]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_ITEM]

	yyvs79: SPECIAL [ET_INDEXING_TERM]
			-- Stack for semantic values of type ET_INDEXING_TERM

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: KL_SPECIAL_ROUTINES [ET_INDEXING_TERM]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_TERM]

	yyvs80: SPECIAL [ET_INDEXING_TERM_ITEM]
			-- Stack for semantic values of type ET_INDEXING_TERM_ITEM

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: KL_SPECIAL_ROUTINES [ET_INDEXING_TERM_ITEM]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_TERM_ITEM]

	yyvs81: SPECIAL [ET_INDEXING_TERM_LIST]
			-- Stack for semantic values of type ET_INDEXING_TERM_LIST

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: KL_SPECIAL_ROUTINES [ET_INDEXING_TERM_LIST]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_TERM_LIST]

	yyvs82: SPECIAL [ET_INSPECT_INSTRUCTION]
			-- Stack for semantic values of type ET_INSPECT_INSTRUCTION

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: KL_SPECIAL_ROUTINES [ET_INSPECT_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_INSPECT_INSTRUCTION]

	yyvs83: SPECIAL [ET_INSTRUCTION]
			-- Stack for semantic values of type ET_INSTRUCTION

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: KL_SPECIAL_ROUTINES [ET_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_INSTRUCTION]

	yyvs84: SPECIAL [ET_INVARIANTS]
			-- Stack for semantic values of type ET_INVARIANTS

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: KL_SPECIAL_ROUTINES [ET_INVARIANTS]
			-- Routines that ought to be in SPECIAL [ET_INVARIANTS]

	yyvs85: SPECIAL [ET_KEYWORD_FEATURE_NAME_LIST]
			-- Stack for semantic values of type ET_KEYWORD_FEATURE_NAME_LIST

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: KL_SPECIAL_ROUTINES [ET_KEYWORD_FEATURE_NAME_LIST]
			-- Routines that ought to be in SPECIAL [ET_KEYWORD_FEATURE_NAME_LIST]

	yyvs86: SPECIAL [ET_LIKE_TYPE]
			-- Stack for semantic values of type ET_LIKE_TYPE

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: KL_SPECIAL_ROUTINES [ET_LIKE_TYPE]
			-- Routines that ought to be in SPECIAL [ET_LIKE_TYPE]

	yyvs87: SPECIAL [ET_LOCAL_VARIABLE]
			-- Stack for semantic values of type ET_LOCAL_VARIABLE

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: KL_SPECIAL_ROUTINES [ET_LOCAL_VARIABLE]
			-- Routines that ought to be in SPECIAL [ET_LOCAL_VARIABLE]

	yyvs88: SPECIAL [ET_LOCAL_VARIABLE_ITEM]
			-- Stack for semantic values of type ET_LOCAL_VARIABLE_ITEM

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: KL_SPECIAL_ROUTINES [ET_LOCAL_VARIABLE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_LOCAL_VARIABLE_ITEM]

	yyvs89: SPECIAL [ET_LOCAL_VARIABLE_LIST]
			-- Stack for semantic values of type ET_LOCAL_VARIABLE_LIST

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: KL_SPECIAL_ROUTINES [ET_LOCAL_VARIABLE_LIST]
			-- Routines that ought to be in SPECIAL [ET_LOCAL_VARIABLE_LIST]

	yyvs90: SPECIAL [ET_LOOP_INVARIANTS]
			-- Stack for semantic values of type ET_LOOP_INVARIANTS

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: KL_SPECIAL_ROUTINES [ET_LOOP_INVARIANTS]
			-- Routines that ought to be in SPECIAL [ET_LOOP_INVARIANTS]

	yyvs91: SPECIAL [ET_MANIFEST_ARRAY]
			-- Stack for semantic values of type ET_MANIFEST_ARRAY

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: KL_SPECIAL_ROUTINES [ET_MANIFEST_ARRAY]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_ARRAY]

	yyvs92: SPECIAL [ET_MANIFEST_STRING_ITEM]
			-- Stack for semantic values of type ET_MANIFEST_STRING_ITEM

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: KL_SPECIAL_ROUTINES [ET_MANIFEST_STRING_ITEM]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_STRING_ITEM]

	yyvs93: SPECIAL [ET_MANIFEST_STRING_LIST]
			-- Stack for semantic values of type ET_MANIFEST_STRING_LIST

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: KL_SPECIAL_ROUTINES [ET_MANIFEST_STRING_LIST]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_STRING_LIST]

	yyvs94: SPECIAL [ET_MANIFEST_TUPLE]
			-- Stack for semantic values of type ET_MANIFEST_TUPLE

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: KL_SPECIAL_ROUTINES [ET_MANIFEST_TUPLE]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_TUPLE]

	yyvs95: SPECIAL [ET_OBSOLETE]
			-- Stack for semantic values of type ET_OBSOLETE

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: KL_SPECIAL_ROUTINES [ET_OBSOLETE]
			-- Routines that ought to be in SPECIAL [ET_OBSOLETE]

	yyvs96: SPECIAL [ET_PARENTHESIZED_EXPRESSION]
			-- Stack for semantic values of type ET_PARENTHESIZED_EXPRESSION

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: KL_SPECIAL_ROUTINES [ET_PARENTHESIZED_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_PARENTHESIZED_EXPRESSION]

	yyvs97: SPECIAL [ET_PARENT]
			-- Stack for semantic values of type ET_PARENT

	yyvsc97: INTEGER
			-- Capacity of semantic value stack `yyvs97'

	yyvsp97: INTEGER
			-- Top of semantic value stack `yyvs97'

	yyspecial_routines97: KL_SPECIAL_ROUTINES [ET_PARENT]
			-- Routines that ought to be in SPECIAL [ET_PARENT]

	yyvs98: SPECIAL [ET_PARENT_ITEM]
			-- Stack for semantic values of type ET_PARENT_ITEM

	yyvsc98: INTEGER
			-- Capacity of semantic value stack `yyvs98'

	yyvsp98: INTEGER
			-- Top of semantic value stack `yyvs98'

	yyspecial_routines98: KL_SPECIAL_ROUTINES [ET_PARENT_ITEM]
			-- Routines that ought to be in SPECIAL [ET_PARENT_ITEM]

	yyvs99: SPECIAL [ET_PARENT_LIST]
			-- Stack for semantic values of type ET_PARENT_LIST

	yyvsc99: INTEGER
			-- Capacity of semantic value stack `yyvs99'

	yyvsp99: INTEGER
			-- Top of semantic value stack `yyvs99'

	yyspecial_routines99: KL_SPECIAL_ROUTINES [ET_PARENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_PARENT_LIST]

	yyvs100: SPECIAL [ET_POSTCONDITIONS]
			-- Stack for semantic values of type ET_POSTCONDITIONS

	yyvsc100: INTEGER
			-- Capacity of semantic value stack `yyvs100'

	yyvsp100: INTEGER
			-- Top of semantic value stack `yyvs100'

	yyspecial_routines100: KL_SPECIAL_ROUTINES [ET_POSTCONDITIONS]
			-- Routines that ought to be in SPECIAL [ET_POSTCONDITIONS]

	yyvs101: SPECIAL [ET_PRECONDITIONS]
			-- Stack for semantic values of type ET_PRECONDITIONS

	yyvsc101: INTEGER
			-- Capacity of semantic value stack `yyvs101'

	yyvsp101: INTEGER
			-- Top of semantic value stack `yyvs101'

	yyspecial_routines101: KL_SPECIAL_ROUTINES [ET_PRECONDITIONS]
			-- Routines that ought to be in SPECIAL [ET_PRECONDITIONS]

	yyvs102: SPECIAL [ET_PROCEDURE]
			-- Stack for semantic values of type ET_PROCEDURE

	yyvsc102: INTEGER
			-- Capacity of semantic value stack `yyvs102'

	yyvsp102: INTEGER
			-- Top of semantic value stack `yyvs102'

	yyspecial_routines102: KL_SPECIAL_ROUTINES [ET_PROCEDURE]
			-- Routines that ought to be in SPECIAL [ET_PROCEDURE]

	yyvs103: SPECIAL [ET_QUERY]
			-- Stack for semantic values of type ET_QUERY

	yyvsc103: INTEGER
			-- Capacity of semantic value stack `yyvs103'

	yyvsp103: INTEGER
			-- Top of semantic value stack `yyvs103'

	yyspecial_routines103: KL_SPECIAL_ROUTINES [ET_QUERY]
			-- Routines that ought to be in SPECIAL [ET_QUERY]

	yyvs104: SPECIAL [ET_RENAME_ITEM]
			-- Stack for semantic values of type ET_RENAME_ITEM

	yyvsc104: INTEGER
			-- Capacity of semantic value stack `yyvs104'

	yyvsp104: INTEGER
			-- Top of semantic value stack `yyvs104'

	yyspecial_routines104: KL_SPECIAL_ROUTINES [ET_RENAME_ITEM]
			-- Routines that ought to be in SPECIAL [ET_RENAME_ITEM]

	yyvs105: SPECIAL [ET_RENAME_LIST]
			-- Stack for semantic values of type ET_RENAME_LIST

	yyvsc105: INTEGER
			-- Capacity of semantic value stack `yyvs105'

	yyvsp105: INTEGER
			-- Top of semantic value stack `yyvs105'

	yyspecial_routines105: KL_SPECIAL_ROUTINES [ET_RENAME_LIST]
			-- Routines that ought to be in SPECIAL [ET_RENAME_LIST]

	yyvs106: SPECIAL [ET_STATIC_CALL_EXPRESSION]
			-- Stack for semantic values of type ET_STATIC_CALL_EXPRESSION

	yyvsc106: INTEGER
			-- Capacity of semantic value stack `yyvs106'

	yyvsp106: INTEGER
			-- Top of semantic value stack `yyvs106'

	yyspecial_routines106: KL_SPECIAL_ROUTINES [ET_STATIC_CALL_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_STATIC_CALL_EXPRESSION]

	yyvs107: SPECIAL [ET_STRIP_EXPRESSION]
			-- Stack for semantic values of type ET_STRIP_EXPRESSION

	yyvsc107: INTEGER
			-- Capacity of semantic value stack `yyvs107'

	yyvsp107: INTEGER
			-- Top of semantic value stack `yyvs107'

	yyspecial_routines107: KL_SPECIAL_ROUTINES [ET_STRIP_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_STRIP_EXPRESSION]

	yyvs108: SPECIAL [ET_TYPE]
			-- Stack for semantic values of type ET_TYPE

	yyvsc108: INTEGER
			-- Capacity of semantic value stack `yyvs108'

	yyvsp108: INTEGER
			-- Top of semantic value stack `yyvs108'

	yyspecial_routines108: KL_SPECIAL_ROUTINES [ET_TYPE]
			-- Routines that ought to be in SPECIAL [ET_TYPE]

	yyvs109: SPECIAL [ET_TYPE_ITEM]
			-- Stack for semantic values of type ET_TYPE_ITEM

	yyvsc109: INTEGER
			-- Capacity of semantic value stack `yyvs109'

	yyvsp109: INTEGER
			-- Top of semantic value stack `yyvs109'

	yyspecial_routines109: KL_SPECIAL_ROUTINES [ET_TYPE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_TYPE_ITEM]

	yyvs110: SPECIAL [ET_TYPE_LIST]
			-- Stack for semantic values of type ET_TYPE_LIST

	yyvsc110: INTEGER
			-- Capacity of semantic value stack `yyvs110'

	yyvsp110: INTEGER
			-- Top of semantic value stack `yyvs110'

	yyspecial_routines110: KL_SPECIAL_ROUTINES [ET_TYPE_LIST]
			-- Routines that ought to be in SPECIAL [ET_TYPE_LIST]

	yyvs111: SPECIAL [ET_VARIANT]
			-- Stack for semantic values of type ET_VARIANT

	yyvsc111: INTEGER
			-- Capacity of semantic value stack `yyvs111'

	yyvsp111: INTEGER
			-- Top of semantic value stack `yyvs111'

	yyspecial_routines111: KL_SPECIAL_ROUTINES [ET_VARIANT]
			-- Routines that ought to be in SPECIAL [ET_VARIANT]

	yyvs112: SPECIAL [ET_WHEN_PART]
			-- Stack for semantic values of type ET_WHEN_PART

	yyvsc112: INTEGER
			-- Capacity of semantic value stack `yyvs112'

	yyvsp112: INTEGER
			-- Top of semantic value stack `yyvs112'

	yyspecial_routines112: KL_SPECIAL_ROUTINES [ET_WHEN_PART]
			-- Routines that ought to be in SPECIAL [ET_WHEN_PART]

	yyvs113: SPECIAL [ET_WHEN_PART_LIST]
			-- Stack for semantic values of type ET_WHEN_PART_LIST

	yyvsc113: INTEGER
			-- Capacity of semantic value stack `yyvs113'

	yyvsp113: INTEGER
			-- Top of semantic value stack `yyvs113'

	yyspecial_routines113: KL_SPECIAL_ROUTINES [ET_WHEN_PART_LIST]
			-- Routines that ought to be in SPECIAL [ET_WHEN_PART_LIST]

	yyvs114: SPECIAL [ET_WRITABLE]
			-- Stack for semantic values of type ET_WRITABLE

	yyvsc114: INTEGER
			-- Capacity of semantic value stack `yyvs114'

	yyvsp114: INTEGER
			-- Top of semantic value stack `yyvs114'

	yyspecial_routines114: KL_SPECIAL_ROUTINES [ET_WRITABLE]
			-- Routines that ought to be in SPECIAL [ET_WRITABLE]

feature {NONE} -- Constants

	yyFinal: INTEGER = 1219
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 140
			-- Number of tokens

	yyLast: INTEGER = 5477
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 372
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 381
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature -- Access

	universe: ET_UNIVERSE
			-- Surrounding universe

feature -- Parsing

	yyparse
			-- (NOTE: THIS IS THE COPY/PASTE VERSION OF THE CODE IN
			-- THE YY_PARSER_SKELETON CLASS, FOR OPTIMISATION WITH
			-- ISE EIFFEL (ALLOW INLINING NOT POSSIBLE IN
			-- YY_PARSER_SKELETON).)

			-- Parse input stream.
			-- Set `syntax_error' to True if
			-- parsing has not been successful.
		local
			yystacksize: INTEGER
			yystate: INTEGER
			yyn: INTEGER
			yychar1: INTEGER
			index, yyss_top: INTEGER
			yy_goto: INTEGER
		do
				-- This routine is implemented with a loop whose body
				-- is a big inspect instruction. This is a mere
				-- translation of C gotos into Eiffel. Needless to
				-- say that I'm not very proud of this piece of code.
				-- However I performed some benchmarks and the results
				-- were that this implementation runs amazingly faster
				-- than an alternative implementation with no loop nor
				-- inspect instructions and where every branch of the
				-- old inspect instruction was written in a separate
				-- routine. I think that the performance penalty is due
				-- to the routine call overhead and the depth of the call
				-- stack. Anyway, I prefer to provide you with a big and
				-- ugly but fast parsing routine rather than a nice and
				-- slow version. I hope you won't blame me for that! :-)
			from
				if yy_parsing_status = yySuspended then
					yystacksize := yy_suspended_yystacksize
					yystate := yy_suspended_yystate
					yyn := yy_suspended_yyn
					yychar1 := yy_suspended_yychar1
					index := yy_suspended_index
					yyss_top := yy_suspended_yyss_top
					yy_goto := yy_suspended_yy_goto
					yy_parsing_status := yyContinue
				else
					error_count := 0
					yy_lookahead_needed := True
					yyerrstatus := 0
					yy_init_value_stacks
					yyssp := -1
					yystacksize := yyss.count
					yy_parsing_status := yyContinue
					yy_goto := yyNewstate
				end
			until
				yy_parsing_status /= yyContinue
			loop
				inspect yy_goto
				when yyNewstate then
					yyssp := yyssp + 1
					if yyssp >= yystacksize then
						yystacksize := yystacksize + yyInitial_stack_size
						yyss := SPECIAL_INTEGER_.resize (yyss, yystacksize)
						debug ("GEYACC")
							std.error.put_string ("Stack (yyss) size increased to ")
							std.error.put_integer (yystacksize)
							std.error.put_character ('%N')
						end
					end
					debug ("GEYACC")
						std.error.put_string ("Entering state ")
						std.error.put_integer (yystate)
						std.error.put_character ('%N')
					end
					yyss.put (yystate, yyssp)
						-- Do appropriate processing given the current state.
						-- Read a lookahead token if one is needed.
					yyn := yypact.item (yystate)
						-- First try to decide what to do without reference
						-- lookahead token.
					if yyn = yyFlag then
						yy_goto := yyDefault
					else
							-- Not known => get a lookahead token if don't
							-- already have one.
						if yy_lookahead_needed then
							debug ("GEYACC")
								std.error.put_string ("Reading a token%N")
							end
							read_token
							yy_lookahead_needed := False
						end
							-- Convert token to internal form (in `yychar1')
							-- for indexing tables.
						if last_token > yyEof then
							debug ("GEYACC")
								std.error.put_string ("Next token is ")
								std.error.put_integer (last_token)
								std.error.put_character ('%N')
							end
								-- Translate lexical token `last_token' into
								-- geyacc internal token code.
							if last_token <= yyMax_token then
								yychar1 := yytranslate.item (last_token)
							else
								yychar1 := yyNsyms
							end
							yyn := yyn + yychar1
						elseif last_token = yyEof then
								-- This means end of input.
							debug ("GEYACC")
								std.error.put_string ("Now at end of input.%N")
							end
							yychar1 := 0
						else
								-- An error occurred in the scanner.
							debug ("GEYACC")
								std.error.put_string ("Error in scanner.%N")
							end
							error_count := error_count + 1
							yy_do_error_action (yystate)
							abort
								-- Skip next conditional instruction:
							yyn := -1
						end
						if
							(yyn < 0 or yyn > yyLast) or else
							yycheck.item (yyn) /= yychar1
						then
							yy_goto := yyDefault
						else
							yyn := yytable.item (yyn)
								-- `yyn' is what to do for this token type in
								-- this state:
								-- Negative => reduce, -`yyn' is rule number.
								-- Positive => shift, `yyn' is new state.
								-- New state is final state => don't bother to
								-- shift, just return success.
								-- 0, or most negative number => error.
							if yyn < 0 then
								if yyn = yyFlag then
									yy_goto := yyErrlab
								else
									yyn := -yyn
									yy_goto := yyReduce
								end
							elseif yyn = 0 then
								yy_goto := yyErrlab
							elseif yyn = yyFinal then
								accept
							else
									-- Shift the lookahead token.
								debug ("GEYACC")
									std.error.put_string ("Shifting token ")
									std.error.put_integer (last_token)
									std.error.put_character ('%N')
								end
									-- Discard the token being shifted
									-- unless it is eof.
								if last_token > yyEof then
									yy_lookahead_needed := True
								end
								yy_push_last_value (yychar1)
									-- Count tokens shifted since error;
									-- after three, turn off error status.
								if yyerrstatus /= 0 then
									yyerrstatus := yyerrstatus - 1
								end
								yystate := yyn
								check
									newstate: yy_goto = yyNewstate
								end
							end
						end
					end
				when yyDefault then
						-- Do the default action for the current state.
					yyn := yydefact.item (yystate)
					if yyn = 0 then
						yy_goto := yyErrlab
					else
						yy_goto := yyReduce
					end
				when yyReduce then
						-- Do a reduction. `yyn' is the number of a rule
						-- to reduce with.
					debug ("GEYACC")
						std.error.put_string ("Reducing via rule #")
						std.error.put_integer (yyn)
						std.error.put_character ('%N')
					end
					yy_do_action (yyn)
					inspect yy_parsing_status
					when yyContinue then
							-- Now "shift" the result of the reduction.
							-- Determine what state that goes to,
							-- based on the state we popped back to
							-- and the rule number reduced by.
						yyn := yyr1.item (yyn)
						yyss_top := yyss.item (yyssp)
						index := yyn - yyNtbase
						yystate := yypgoto.item (index) + yyss_top
						if
							(yystate >= 0 and yystate <= yyLast) and then
							yycheck.item (yystate) = yyss_top
						then
							yystate := yytable.item (yystate)
						else
							yystate := yydefgoto.item (index)
						end
						yy_goto := yyNewstate
					when yySuspended then
						yy_suspended_yystacksize := yystacksize
						yy_suspended_yystate := yystate
						yy_suspended_yyn := yyn
						yy_suspended_yychar1 := yychar1
						yy_suspended_index := index
						yy_suspended_yyss_top := yyss_top
						yy_suspended_yy_goto := yy_goto
					when yyError_raised then
							-- Handle error raised explicitly by an action.
						yy_parsing_status := yyContinue
						yy_goto := yyErrlab
					else
							-- Accepted or aborted.
					end
				when yyErrlab then
						-- Detect error.
					if yyerrstatus = 3 then
							-- If just tried and failed to reuse lookahead
							-- token after an error, discard it. Return
							-- failure if at end of input.
						if last_token <= yyEof then
							abort
						else
							debug ("GEYACC")
								std.error.put_string ("Discarding token ")
								std.error.put_integer (last_token)
								std.error.put_character ('%N')
							end
							yy_lookahead_needed := True
							yy_goto := yyErrhandle
						end
					else
						if yyerrstatus = 0 then
								-- If not already recovering from an error,
								-- report this error.
							error_count := error_count + 1
							yy_do_error_action (yystate)
						end
						yyerrstatus := 3
						yy_goto := yyErrhandle
					end
				when yyErrhandle then
						-- Handle error.
					yyn := yypact.item (yystate)
					if yyn = yyFlag then
						yy_goto := yyErrpop
					else
						yyn := yyn + yyTerror
						if
							(yyn < 0 or yyn > yyLast) or else
							yycheck.item (yyn) /= yyTerror
						then
							yy_goto := yyErrpop
						else
							yyn := yytable.item (yyn)
							if yyn < 0 then
								if yyn = yyFlag then
									yy_goto := yyErrpop
								else
									yyn := -yyn
									yy_goto := yyReduce
								end
							elseif yyn = 0 then
								yy_goto := yyErrpop
							elseif yyn = yyFinal then
								accept
							else
								yy_push_error_value
								yystate := yyn
								yy_goto := yyNewstate
							end
						end
					end
				when yyErrpop then
						-- Pop the current state because it cannot handle
						-- the error token.
					if yyssp = 0 then
						abort
					else
						yy_pop_last_value (yystate)
						yyssp := yyssp - 1
						yystate := yyss.item (yyssp)
						yy_goto := yyErrhandle
					end
				end
			end
			if yy_parsing_status /= yySuspended then
				yy_clear_all
			end
		rescue
			debug ("GEYACC")
				std.error.put_line ("Entering rescue clause of parser")
			end
			abort
			yy_clear_all
		end

end
