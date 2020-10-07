class IssueStatusesController < ApplicationController
	layout 'base'	
	before_filter :require_admin
  def index
    list
    render :action => 'list'
  end
  def list
    @issue_status_pages, @issue_statuses = paginate :issue_statuses, :per_page => 10
  end
  def new
    @issue_status = IssueStatus.new
  end
  def create
    @issue_status = IssueStatus.new(params[:issue_status])
    if @issue_status.save
      flash[:notice] = 'IssueStatus was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  def edit
    @issue_status = IssueStatus.find(params[:id])
  end
  def update
    @issue_status = IssueStatus.find(params[:id])
    if @issue_status.update_attributes(params[:issue_status])
      flash[:notice] = 'IssueStatus was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  def destroy
    IssueStatus.find(params[:id]).destroy
    redirect_to :action => 'list'
  rescue
    flash[:notice] = "Unable to delete issue status"
    redirect_to :action => 'list'
  end
end
