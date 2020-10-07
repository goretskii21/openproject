class IssuesController < ApplicationController
	layout 'base'
	before_filter :find_project, :authorize
	helper :custom_fields
	include CustomFieldsHelper
	def show
    @status_options = @issue.status.workflows.find(:all, :conditions => ["role_id=? and tracker_id=?", session[:user].role_for_project(@project.id), @issue.tracker.id]).collect{ |w| w.new_status } if session[:user]
	end
	def edit
		@trackers = Tracker.find(:all)
		@priorities = Enumeration::get_values('IPRI')
		if request.get?
			@custom_values = @project.custom_fields_for_issues.collect { |x| @issue.custom_values.find_by_custom_field_id(x.id) || CustomValue.new(:custom_field => x) }
		else
			@custom_values = @project.custom_fields_for_issues.collect { |x| CustomValue.new(:custom_field => x, :value => params["custom_fields"][x.id.to_s]) }
			@issue.custom_values = @custom_values
			if @issue.update_attributes(params[:issue])
				flash[:notice] = 'Issue was successfully updated.'
				redirect_to :action => 'show', :id => @issue
			end
		end		
	end
	def change_status
		@history = @issue.histories.build(params[:history])	
    @status_options = @issue.status.workflows.find(:all, :conditions => ["role_id=? and tracker_id=?", session[:user].role_for_project(@project.id), @issue.tracker.id]).collect{ |w| w.new_status } if session[:user]
		if params[:confirm]
			unless session[:user].nil?
				@history.author = session[:user]
			end			
			if @history.save			
				@issue.status = @history.status
				@issue.fixed_version_id = (params[:issue][:fixed_version_id])
				@issue.assigned_to_id = (params[:issue][:assigned_to_id])	
				if @issue.save
					flash[:notice] = 'Issue was successfully updated.'
					Mailer.deliver_issue_change_status(@issue) if Permission.find_by_controller_and_action(@params[:controller], @params[:action]).mail_enabled?
					redirect_to :action => 'show', :id => @issue
				end
			end
		end    
    @assignable_to = @project.members.find(:all, :include => :user).collect{ |m| m.user }
	end
	def destroy
		@issue.destroy
		redirect_to :controller => 'projects', :action => 'list_issues', :id => @project
	end
  def add_attachment
    if params[:attachment][:file].size > 0
      @attachment = @issue.attachments.build(params[:attachment])      
      @attachment.author_id = session[:user].id unless session[:user].nil?
      @attachment.save
    end
    redirect_to :action => 'show', :id => @issue
  end
  def destroy_attachment
    @issue.attachments.find(params[:attachment_id]).destroy
    redirect_to :action => 'show', :id => @issue
  end
	def download
		@attachment = @issue.attachments.find(params[:attachment_id])
		send_file @attachment.diskfile, :filename => @attachment.filename
	end
private
	def find_project
    @issue = Issue.find(params[:id])
		@project = @issue.project
	end  
end
