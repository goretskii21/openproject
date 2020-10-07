class AccountController < ApplicationController
	layout 'base'	
  skip_before_filter :check_if_login_required, :only => :login
	before_filter :require_login, :except => [:show, :login]
	def show
		@user = User.find(params[:id])
	end
	def login
		if request.get?
			session[:user] = nil
			@user = User.new
		else
			@user = User.new(params[:user])
			logged_in_user = @user.try_to_login
			if logged_in_user
				session[:user] = logged_in_user
				redirect_back_or_default :controller => 'account', :action => 'my_page'
			else
				flash[:notice] = _('Invalid user/password')
			end
		end
	end
	def logout
		session[:user] = nil
		redirect_to(:controller => '')
	end
	def my_page
		@user = session[:user]		
		@reported_issues = Issue.find(:all, :conditions => ["author_id=?", @user.id], :limit => 10, :include => [ :status, :project, :tracker ], :order => 'issues.updated_on DESC')
		@assigned_issues = Issue.find(:all, :conditions => ["assigned_to_id=?", @user.id], :limit => 10, :include => [ :status, :project, :tracker ], :order => 'issues.updated_on DESC')
	end
	def my_account
		@user = User.find(session[:user].id)
		if request.post? and @user.update_attributes(@params[:user])
			flash[:notice] = 'Account was successfully updated.'
      session[:user] = @user
      set_localization
		end
	end
	def change_password
		@user = User.find(session[:user].id)		
		if @user.check_password?(@params[:old_password])		
			if @params[:new_password] == @params[:new_password_confirmation]
				if @user.change_password(@params[:old_password], @params[:new_password])
					flash[:notice] = 'Password was successfully updated.'
				end
			else
				flash[:notice] = 'Password confirmation doesn\'t match!'
			end
		else
			flash[:notice] = 'Wrong password'
		end
		render :action => 'my_account'
	end
end
