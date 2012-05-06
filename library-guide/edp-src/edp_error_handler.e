--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
class EDP_ERROR_HANDLER

inherit

	ET_ERROR_HANDLER
		redefine
			report_cluster_error,
			report_error,
			report_warning,
			report_info,
			report_preparsing_status,
			report_compilation_status,
			report_validity_error
		end

create

	make

feature -- Attributes

	target: EDP_ERROR_TARGET

feature -- Creation

	make
		do
		--	make_standard
			make_null
			is_ge := True
		end

	set_target (a_target: EDP_ERROR_TARGET)
		do
			target := a_target
		end

feature -- Report routines

	report_validity_error (an_error: ET_VALIDITY_ERROR)
		do
			if (not is_ge) or (not an_error.ge_reported) then
				print (once "EDP_ERROR_HANDLER.report_validity_error called%N")
				print (once "  is_ge: "); print (is_ge.out)
				print (once " .ge_reported: "); print (an_error.ge_reported.out)
				print (once "%N")
			end
			Precursor (an_error)
		end

	report_cluster_error (an_error: ET_CLUSTER_ERROR)
			-- Report cluster error.
		do
			if target /= Void then
				target.report_error (an_error)
				-- TODO report cluster error instead
			else
				Precursor (an_error)
			end
		end

	report_error (an_error: UT_ERROR)
		do
			if target /= Void then
				target.report_error (an_error)
			else
				Precursor (an_error)
			end
		end

	report_warning (a_message: UT_ERROR)
		do
			if target /= Void then
		--		target.report_warning (a_message)
				target.report_error (a_message)
			else
				Precursor (a_message)
			end
		end

	report_info (an_info: UT_ERROR)
		do
			if target /= Void then
		--		target.report_info(an_info)
				target.report_error(an_info)
			else
				Precursor(an_info)
			end
		end

feature -- Compilation report

	report_preparsing_status (a_cluster: ET_CLUSTER)
			-- Report that `a_cluster' is currently being preparsed.
		require else
			a_cluster_not_void: a_cluster /= Void
		do
			if False then
				print ("Pre-parsing: ")
				print (a_cluster.full_name ('.'))
				print (once "%N")
			end
		end

	report_compilation_status (a_processor: ET_AST_PROCESSOR; a_class: ET_CLASS)
			-- Report that `a_processor' is currently processing `a_class'.
		require else
			a_processor_not_void: a_processor /= Void
			a_class_not_void: a_class /= Void
		local
			a_universe: ET_UNIVERSE
		do
			if False then
--				a_universe := a_processor.universe
--				if True and a_processor = a_universe.eiffel_parser then
					print ("eiffel_parser: ")
					print (a_class.name.name)
					print (once ": ")
					print (a_class.group.cluster.pathname)
					print (once "%N")
--				elseif False and a_processor = a_universe.ancestor_builder then
					print ("ancestor_builder: ")
					print (a_class.name.name)
					print (once "%N")
--				elseif False and a_processor = a_universe.feature_flattener then
					print ("feature_flattener: ")
					print (a_class.name.name)
					print (once "%N")
--				elseif False and a_processor = a_universe.interface_checker then
					print ("interface_checker: ")
					print (a_class.name.name)
					print (once "%N")
--				elseif False and a_processor = a_universe.implementation_checker then
					print ("implementation_checker: ")
					print (a_class.name.name)
					print (once "%N")
--				end
			end
		end
end