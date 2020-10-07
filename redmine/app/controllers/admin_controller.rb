class AdminController < ApplicationController
	layout 'base'	
	before_filter :require_admin
	helper :sort
	include SortHelper	
	def index	
	end
  def projects
		sort_init 'projects.name', 'asc'
		sort_update		
    @project_pages, @projects = paginate :projects, :per_page => 15, :order => sort_clause
  end
  def mail_options
    @actions = Permission.find(:all, :conditions => ["mail_option=?", true])  || []
    if request.post?
      @actions.each { |a|
        a.mail_enabled = params[:action_ids].include? a.id.to_s 
        a.save
      }
      flash[:notice] = "Mail options were successfully updated."
    end
  end
  def info
    @adapter_name = ActiveRecord::Base.connection.adapter_name
  end
end
