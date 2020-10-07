module SearchFilterHelper
	def search_filter_criteria(field, options = {})
		session[:search_filter] ||= {}
		session[:search_filter][field] ||= options
	end
	def search_filter_update
		session[:search_filter].each_key {|field| session[:search_filter][field][:value] = params[field]  }
	end
	def search_filter_clause
		clause = "1=1"
		session[:search_filter].each {|field, criteria| clause = clause + " AND " + field + "='" + session[:search_filter][field][:value] + "'" unless session[:search_filter][field][:value].nil? || session[:search_filter][field][:value].empty? }
		clause
	end
	def search_filter_tag(field)
		option_values = []
		option_values = eval session[:search_filter][field][:values]
		content_tag("select", 
				content_tag("option", "[All]", :value => "") +
				options_from_collection_for_select(option_values, 
										"id",
										session[:search_filter][field][:label]  || "name",
										session[:search_filter][field][:value].to_i
										),
				:name => field
				)
	end
end
