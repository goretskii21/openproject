class RolesController < ApplicationController
	layout 'base'	
	before_filter :require_admin
  def index
    list
    render :action => 'list'
  end
  def list
    @role_pages, @roles = paginate :roles, :per_page => 10
  end
  def new
    @role = Role.new(params[:role])
    if request.post?
      @role.permissions = Permission.find(@params[:permission_ids]) if @params[:permission_ids]
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        redirect_to :action => 'list'
      end
    end
    @permissions = Permission.find(:all, :order => 'sort ASC')
  end
  def edit
    @role = Role.find(params[:id])
    if request.post? and @role.update_attributes(params[:role])
      @role.permissions = Permission.find(@params[:permission_ids] || [])
      Permission.allowed_to_role_expired
      flash[:notice] = 'Role was successfully updated.'
      redirect_to :action => 'list'
    end
    @permissions = Permission.find(:all, :order => 'sort ASC')
  end
  def destroy
    @role = Role.find(params[:id])
    unless @role.members.empty?
      flash[:notice] = 'Some members have this role. Can\'t delete it.'
    else
      @role.destroy
    end
    redirect_to :action => 'list'
  end
  def workflow
    @roles = Role.find_all
    @trackers = Tracker.find_all
    @statuses = IssueStatus.find_all
    @role = Role.find_by_id(params[:role_id])
    @tracker = Tracker.find_by_id(params[:tracker_id])    
    if request.post?
      Workflow.destroy_all( ["role_id=? and tracker_id=?", @role.id, @tracker.id])
      (params[:issue_status] || []).each { |old, news| 
        news.each { |new| 
          @role.workflows.build(:tracker_id => @tracker.id, :old_status_id => old, :new_status_id => new) 
        }
      }
      if @role.save
        flash[:notice] = 'Workflow was successfully updated.'
      end
    end
  end
end
