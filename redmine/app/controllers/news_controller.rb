class NewsController < ApplicationController
	layout 'base'
	before_filter :find_project, :authorize
  def show
  end
  def edit
    if request.post? and @news.update_attributes(params[:news])
      flash[:notice] = 'News was successfully updated.'
      redirect_to :action => 'show', :id => @news
    end
  end
	def destroy
		@news.destroy
		redirect_to :controller => 'projects', :action => 'list_news', :id => @project
	end
private
	def find_project
    @news = News.find(params[:id])
		@project = @news.project
	end  
end
