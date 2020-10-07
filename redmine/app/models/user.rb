require "digest/sha1"
class User < ActiveRecord::Base
	has_many :memberships, :class_name => 'Member', :include => [ :project, :role ], :dependent => true
	attr_accessor :password
	attr_accessor :last_before_login_on
	attr_protected :admin
	validates_presence_of :login, :firstname, :lastname, :mail
	validates_uniqueness_of :login, :mail
	validates_format_of :login, :with => /^[a-z0-9_]+$/i
	validates_format_of :mail, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
	def before_create
		self.hashed_password = User.hash_password(self.password)
	end
	def after_create
		@password = nil
	end
	def try_to_login
		@user = User.login(self.login, self.password)
		unless @user.nil? 
			@user.last_before_login_on = @user.last_login_on
			@user.update_attribute(:last_login_on, DateTime.now)
		end
		@user
	end
	def display_name
		firstname + " " + lastname #+ (self.admin ? " (Admin)" : "" )
	end
	def self.login(login, password)
		hashed_password = hash_password(password || "")
		find(:first,
			:conditions => ["login = ? and hashed_password = ? and locked = ?", login, hashed_password, false])
	end
	def check_password?(clear_password)
		User.hash_password(clear_password) == self.hashed_password
	end
	def change_password(current_password, new_password)
		self.hashed_password = User.hash_password(new_password)
		save
	end
  def role_for_project(project_id)
    @role_for_projects ||=
      begin
        roles = {}
        self.memberships.each { |m| roles.store m.project_id, m.role_id }
        roles
      end
    @role_for_projects[project_id]
  end
private
	def self.hash_password(clear_password)
		Digest::SHA1.hexdigest(clear_password)
	end
end
