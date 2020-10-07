class UsersController < ApplicationController
	layout 'base'	
	before_filter :require_admin
	helper :sort
	include SortHelper
	def index
		list
		render :action => 'list'
	end
	def list
		sort_init 'users.login', 'asc'
		sort_update
		@user_count = User.count		
		@user_pages = Paginator.new self, @user_count,
								15,
								@params['page']								
		@users =  User.find :all, :order => sort_clause,
						:limit  =>  @user_pages.items_per_page,
						:offset =>  @user_pages.current.offset		
	end
	def add
		if request.get?
			@user = User.new
		else
			@user = User.new(params[:user])
			@user.admin = params[:user][:admin]
			if @user.save
				flash[:notice] = 'User was successfully created.'
				redirect_to :action => 'list'
			end
		end
	end
	def edit
		@user = User.find(params[:id])
		if request.post?
			@user.admin = params[:user][:admin] if params[:user][:admin]
			if @user.update_attributes(params[:user])
				flash[:notice] = 'User was successfully updated.'
				redirect_to :action => 'list'
			end
		end
	end
	def destroy
		User.find(params[:id]).destroy
		redirect_to :action => 'list'
  rescue
    flash[:notice] = "Unable to delete user"
    redirect_to :action => 'list'
	end  
end
