indexing

	description:

		"Objects that represent compiled xsl:result-documents"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_COMPILED_RESULT_DOCUMENT

inherit

	XM_XSLT_INSTRUCTION
		redefine
			promote_instruction, item_type, sub_expressions
		end

	XM_XSLT_VALIDATION

create

	make

feature {NONE} -- Initialization

	make (an_executable: XM_XSLT_EXECUTABLE; a_property_set: XM_XSLT_OUTPUT_PROPERTIES; an_href: XM_XPATH_EXPRESSION;
			a_base_uri: STRING; a_validation_action: INTEGER; a_schema_type: XM_XPATH_SCHEMA_TYPE;
			some_formatting_attributes: DS_HASH_TABLE [XM_XPATH_EXPRESSION, INTEGER];
			a_namespace_resolver: XM_XPATH_NAMESPACE_RESOLVER; a_content: XM_XPATH_EXPRESSION) is
			-- Establish invariant.
		require
			executable_not_void: an_executable /= Void
			property_set_not_void: a_property_set /= Void
			base_uri: a_base_uri /= Void
			only_basic_xslt_as_yet: a_validation_action = Validation_strip
			no_schema_type_as_yet: a_schema_type = Void
			formatting_attributes_not_void: some_formatting_attributes /= Void
			content_not_void: a_content /= Void
		local
			a_cursor: DS_HASH_TABLE_CURSOR [XM_XPATH_EXPRESSION, INTEGER]
		do
			executable := an_executable
			base_uri := a_base_uri
			property_set := a_property_set
			href := an_href; if href /= Void then adopt_child_expression (href) end
			validation_action := a_validation_action
			schema_type := a_schema_type
			formatting_attributes := some_formatting_attributes
			namespace_resolver := a_namespace_resolver
			content := a_content; adopt_child_expression (content)
			from
				a_cursor := formatting_attributes.new_cursor; a_cursor.start
			until
				a_cursor.after
			loop
				adopt_child_expression (a_cursor.item)
				a_cursor.forth
			end
			compute_static_properties
			initialized := True
		ensure
			executable_set: executable = an_executable
			base_uri_set: base_uri = a_base_uri
			output_properties_set: property_set = a_property_set
			href_set: href = an_href
			validation_action_set: validation_action = a_validation_action
			schema_type_set: schema_type = a_schema_type
			formatting_attributes_set: formatting_attributes = some_formatting_attributes
			namespace_resolver_set: namespace_resolver = a_namespace_resolver
			content_set: content = a_content
		end

feature -- Access
	
	property_set: XM_XSLT_OUTPUT_PROPERTIES
			-- Output properties

	href: XM_XPATH_EXPRESSION
			--	Optional URI for output destination

	base_uri: STRING
			-- Base URI

	validation_action: INTEGER
			-- Validation_action

	schema_type: XM_XPATH_SCHEMA_TYPE
			-- Schema type

	formatting_attributes: DS_HASH_TABLE [XM_XPATH_EXPRESSION, INTEGER]
			-- Overrides of xsl:output attributes

	namespace_resolver: XM_XPATH_NAMESPACE_RESOLVER
			-- Optional namespace resolver

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, when known
		do
			Result := empty_item
		end

	sub_expressions: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION] is
			-- Immediate sub-expressions of `Current'
		local
			a_cursor: DS_HASH_TABLE_CURSOR [XM_XPATH_EXPRESSION, INTEGER]
		do
			create Result.make (2 + formatting_attributes.count)
			Result.set_equality_tester (expression_tester)
			Result.put (content, 1)
			if href /= Void then Result.put (href, 2) end
			from
				a_cursor := formatting_attributes.new_cursor; a_cursor.start
			until
				a_cursor.after
			loop
				Result.put_last (a_cursor.item)
				a_cursor.forth
			end
		end

feature -- Status report

	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		do
			todo ("display", False)
		end

feature -- Optimization

	simplify is
			-- Perform context-independent static optimizations.
		local
			a_cursor: DS_HASH_TABLE_CURSOR [XM_XPATH_EXPRESSION, INTEGER]
			an_attribute: XM_XPATH_EXPRESSION
		do
			content.simplify
			if content.was_expression_replaced then
				content := content.replacement_expression; adopt_child_expression (content)
			end
			if href /= Void then
				href.simplify
				if href.was_expression_replaced then
					href := href.replacement_expression; adopt_child_expression (href)
				end
			end
			from
				a_cursor := formatting_attributes.new_cursor; a_cursor.start
			until
				a_cursor.after
			loop
				an_attribute := a_cursor.item
				an_attribute.simplify
				if an_attribute.was_expression_replaced then
					an_attribute := an_attribute.replacement_expression; adopt_child_expression (an_attribute)
					a_cursor.replace (an_attribute)
				end
				a_cursor.forth
			end
		end

	analyze (a_context: XM_XPATH_STATIC_CONTEXT) is
			-- Perform static analysis of `Current' and its subexpressions.
		local
			a_cursor: DS_HASH_TABLE_CURSOR [XM_XPATH_EXPRESSION, INTEGER]
			an_attribute: XM_XPATH_EXPRESSION
		do
			content.analyze (a_context)
			if content.was_expression_replaced then
				content := content.replacement_expression; adopt_child_expression (content)
			end
			if href /= Void then
				href.analyze (a_context)
				if href.was_expression_replaced then
					href := href.replacement_expression; adopt_child_expression (href)
				end
			end
			from
				a_cursor := formatting_attributes.new_cursor; a_cursor.start
			until
				a_cursor.after
			loop
				an_attribute := a_cursor.item
				an_attribute.analyze (a_context)
				if an_attribute.was_expression_replaced then
					an_attribute := an_attribute.replacement_expression; adopt_child_expression (an_attribute)
					a_cursor.replace (an_attribute)
				end
				a_cursor.forth
			end
		end

	promote_instruction (an_offer: XM_XPATH_PROMOTION_OFFER) is
			-- Promote this instruction.
		local
			a_cursor: DS_HASH_TABLE_CURSOR [XM_XPATH_EXPRESSION, INTEGER]
			an_attribute: XM_XPATH_EXPRESSION
		do
			content.promote (an_offer)
			if content.was_expression_replaced then
				content := content.replacement_expression; adopt_child_expression (content)
			end
			if href /= Void then
				href.promote (an_offer)
				if href.was_expression_replaced then
					href := href.replacement_expression; adopt_child_expression (href)
				end
			end
			from
				a_cursor := formatting_attributes.new_cursor; a_cursor.start
			until
				a_cursor.after
			loop
				an_attribute := a_cursor.item
				an_attribute.promote (an_offer)
				if an_attribute.was_expression_replaced then
					an_attribute := an_attribute.replacement_expression; adopt_child_expression (an_attribute)
					a_cursor.replace (an_attribute)
				end
				a_cursor.forth
			end
		end

feature -- Evaluation

	process_leaving_tail (a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.
		local
			a_transformer: XM_XSLT_TRANSFORMER
			a_result: XM_XSLT_TRANSFORMATION_RESULT
			an_output_resolver: XM_XSLT_OUTPUT_URI_RESOLVER
			a_cursor: DS_HASH_TABLE_CURSOR [XM_XPATH_EXPRESSION, INTEGER]
			a_fingerprint: INTEGER
			an_expression: XM_XPATH_EXPRESSION
			a_value: XM_XPATH_STRING_VALUE
			a_property_set: XM_XSLT_OUTPUT_PROPERTIES
			a_receiver: XM_XPATH_SEQUENCE_RECEIVER
			a_uri: UT_URI
			a_uri_to_use: STRING
			an_error: XM_XPATH_ERROR_VALUE
			a_new_context: XM_XSLT_EVALUATION_CONTEXT
		do
			a_transformer := a_context.transformer
			a_new_context := a_context.new_minor_context
			if a_new_context.is_temporary_destination then
				create an_error.make_from_string ("Attempt to evaluate xsl:document while writing a temporary tree", "", "XTDE1480", Dynamic_error)
				a_transformer.report_fatal_error (an_error, Current)
			else
				an_output_resolver := a_transformer.output_resolver
				if href = Void then
					a_result := a_transformer.principal_result
					if a_result.is_document_started then
						create an_error.make_from_string (STRING_.concat ("Attempt to generate two result trees to URI ", a_transformer.principal_result_uri), "", "XTDE1490", Dynamic_error)
						a_transformer.report_fatal_error (an_error, Current)
					end
				else
					href.evaluate_as_string (a_context)
					if href.last_evaluated_string.is_error then
						a_transformer.report_fatal_error (href.last_evaluated_string.error_value, Current)
					else
						an_output_resolver := a_transformer.output_resolver
						create a_uri.make (a_transformer.principal_result_uri)
						create a_uri.make_resolve (a_uri, href.last_evaluated_string.string_value)
						a_uri_to_use := a_uri.full_reference
						if an_output_resolver.output_destinations.has (a_uri_to_use) then
							create an_error.make_from_string (STRING_.concat ("Attempt to generate two result trees to URI ", a_uri_to_use), "", "XTDE1490", Dynamic_error)
							a_transformer.report_fatal_error (an_error, Current)
						else
							an_output_resolver.resolve (a_uri)
							a_result := an_output_resolver.last_result
							if a_result = Void then
								create an_error.make_from_string (an_output_resolver.error_message, Gexslt_eiffel_type_uri, "OUTPUT_RESOLVER_ERROR", Dynamic_error)
								a_transformer.report_fatal_error (an_error, Current)
							else
								a_property_set := property_set
								if formatting_attributes.count > 0 then
									a_property_set := property_set.another
									from
										a_cursor := formatting_attributes.new_cursor; a_cursor.start
									until
										a_cursor.after
									loop
										a_fingerprint := a_cursor.key
										an_expression := a_cursor.item
										an_expression.evaluate_as_string (a_context)
										a_value :=  an_expression.last_evaluated_string
										if a_value.is_error then
											a_transformer.report_fatal_error (a_value.error_value, Current)
											a_cursor.go_after
										else
											a_property_set.set_property (a_fingerprint, a_value.string_value, namespace_resolver)
											a_cursor.forth
										end
									end
								end
							end
						end
					end
				end
			end
			if not a_transformer.is_error then
				-- TODO - next-in-chain processing
				a_new_context.change_output_destination (a_property_set, a_result, True, validation_action, schema_type)
				a_receiver := a_new_context.current_receiver
				if not a_receiver.is_document_started then a_receiver.start_document end
				content.process (a_new_context)
				a_receiver.end_document
				an_output_resolver.close (a_result)
			end
			last_tail_call := Void
		end

feature {NONE} -- Implementation

	content: XM_XPATH_EXPRESSION
			-- Sequence constructor

invariant

	base_uri: initialized implies base_uri /= Void
	property_set_not_void: initialized implies property_set /= Void
	only_basic_xslt_as_yet: initialized implies validation_action = Validation_strip
	no_schema_type_as_yet: initialized implies schema_type = Void
	formatting_attributes_not_void: initialized implies formatting_attributes /= Void
	content_not_void: initialized implies content /= Void

end

