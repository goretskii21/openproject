class IssueCategoriesController < ApplicationController
	layout 'base'
	before_filter :find_project, :authorize
  def edit
    if request.post? and @category.update_attributes(params[:category])
      flash[:notice] = 'Issue category was successfully updated.'
      redirect_to :controller => 'projects', :action => 'settings', :id => @project
    end
  end
  def destroy
    @category.destroy
    redirect_to :controller => 'projects', :action => 'settings', :id => @project
  rescue
    flash[:notice] = "Categorie can't be deleted"
    redirect_to :controller => 'projects', :action => 'settings', :id => @project
  end
private
	def find_project
    @category = IssueCategory.find(params[:id])
		@project = @category.project
	end    
end
