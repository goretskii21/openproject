class MembersController < ApplicationController
	layout 'base'
	before_filter :find_project, :authorize
	def edit
		if request.post? and @member.update_attributes(params[:member])
			flash[:notice] = 'Member was successfully updated.'
			redirect_to :controller => 'projects', :action => 'settings', :id => @project
		end
	end
	def destroy
		@member.destroy
    flash[:notice] = 'Member was successfully removed.'
		redirect_to :controller => 'projects', :action => 'settings', :id => @project
	end
private
	def find_project
    @member = Member.find(params[:id]) 
		@project = @member.project
	end  
end
