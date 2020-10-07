class EnumerationsController < ApplicationController
  layout 'base'
  before_filter :require_admin
  def index
    list
    render :action => 'list'
  end
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  def list
  end
  def new
    @enumeration = Enumeration.new(:opt => params[:opt])
  end
  def create
    @enumeration = Enumeration.new(params[:enumeration])
    if @enumeration.save
      flash[:notice] = 'Enumeration was successfully created.'
      redirect_to :action => 'list', :opt => @enumeration.opt
    else
      render :action => 'new'
    end
  end
  def edit
    @enumeration = Enumeration.find(params[:id])
  end
  def update
    @enumeration = Enumeration.find(params[:id])
    if @enumeration.update_attributes(params[:enumeration])
      flash[:notice] = 'Enumeration was successfully updated.'
      redirect_to :action => 'list', :opt => @enumeration.opt
    else
      render :action => 'edit'
    end
  end
  def destroy
    Enumeration.find(params[:id]).destroy
    redirect_to :action => 'list'
  rescue
    flash[:notice] = "Unable to delete enumeration"
    redirect_to :action => 'list'
  end
end
