class TrackersController < ApplicationController
	layout 'base'
	before_filter :require_admin
  def index
    list
    render :action => 'list'
  end
  verify :method => :post, :only => [ :destroy ], :redirect_to => { :action => :list }
  def list
    @tracker_pages, @trackers = paginate :trackers, :per_page => 10
  end
  def new
    @tracker = Tracker.new(params[:tracker])
    if request.post? and @tracker.save
      flash[:notice] = 'Tracker was successfully created.'
      redirect_to :action => 'list'
    end
  end
  def edit
    @tracker = Tracker.find(params[:id])
    if request.post? and @tracker.update_attributes(params[:tracker])
      flash[:notice] = 'Tracker was successfully updated.'
      redirect_to :action => 'list'
    end
  end
  def destroy
    @tracker = Tracker.find(params[:id])
    unless @tracker.issues.empty?
      flash[:notice] = "This tracker contains issues and can\'t be deleted."
    else
      @tracker.destroy
    end
    redirect_to :action => 'list'
  end
end
