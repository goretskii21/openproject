module ApplicationHelper
	def loggedin?
		session[:user]
	end
	def admin_loggedin?
		session[:user] && session[:user].admin
	end
	def authorize_for(controller, action)  
    if @project.public? and Permission.allowed_to_public "%s/%s" % [ controller, action ]
      return true
    end  
    if session[:user] and (session[:user].admin? or Permission.allowed_to_role( "%s/%s" % [ controller, action ], session[:user].role_for_project(@project.id)  )  )
			return true
		end		
		return false	  
	end
	def link_to_if_authorized(name, options = {}, html_options = nil, *parameters_for_method_reference)
		link_to(name, options, html_options, *parameters_for_method_reference) if authorize_for(options[:controller], options[:action])
	end
	def link_to_user(user)
		link_to user.display_name, :controller => 'account', :action => 'show', :id => user
	end
  def format_date(date)
    _('(date)', date) if date
  end
  def format_time(time)
    _('(time)', time) if time
  end
  def pagination_links_full(paginator, options={}, html_options={})
    html =''
    html << link_to(('&#171; ' + _('Previous') ), { :page => paginator.current.previous }) + ' ' if paginator.current.previous
    html << (pagination_links(paginator, options, html_options) || '')
    html << ' ' + link_to((_('Next') + ' &#187;'), { :page => paginator.current.next }) if paginator.current.next
    html  
  end
end
