module CustomFieldsHelper
	def custom_field_tag(custom_value)
		custom_field = custom_value.custom_field
		field_name = "custom_fields[#{custom_field.id}]"
		case custom_field.typ
		when 0 .. 2
			text_field_tag field_name, custom_value.value
		when 3
			check_box field_name
		when 4
			select_tag field_name, 
					options_for_select(custom_field.possible_values.split('|'),
					custom_value.value)
		end
	end
end
