class ApplicationController < ActionController::Base
  before_filter :check_if_login_required, :set_localization
  def check_if_login_required
    require_login if RDM_LOGIN_REQUIRED
  end 
  def set_localization
    Localization.lang = session[:user].nil? ? RDM_DEFAULT_LANG : (session[:user].language || RDM_DEFAULT_LANG)
  end
	def require_login
		unless session[:user]
			store_location
			redirect_to(:controller => "account", :action => "login")
		end
	end
	def require_admin
		if session[:user].nil?
			store_location
			redirect_to(:controller => "account", :action => "login")
		else
			unless session[:user].admin?
				flash[:notice] = "Acces not allowed"
				redirect_to(:controller => "projects", :action => "list")
			end
		end
	end
	def authorize
    if @project.public? and Permission.allowed_to_public "%s/%s" % [ @params[:controller], @params[:action] ]
      return true
    end  
		unless session[:user]
			store_location
			redirect_to(:controller => "account", :action => "login")
			return false
		end
    if session[:user].admin? or Permission.allowed_to_role( "%s/%s" % [ @params[:controller], @params[:action] ], session[:user].role_for_project(@project.id)  )    
      return true		
		end		
    flash[:notice] = "Acces denied"
    redirect_to(:controller => "")
    return false
	end
	def store_location
		session[:return_to] = @request.request_uri
	end
	def redirect_back_or_default(default)
		if session[:return_to].nil?
			redirect_to default
		else
			redirect_to_url session[:return_to]
			session[:return_to] = nil
		end
	end
end
