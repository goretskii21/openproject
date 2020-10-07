class Issue < ActiveRecord::Base
	belongs_to :project
	belongs_to :tracker
	belongs_to :status, :class_name => 'IssueStatus', :foreign_key => 'status_id'
	belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
	belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'
	belongs_to :fixed_version, :class_name => 'Version', :foreign_key => 'fixed_version_id'
	belongs_to :priority, :class_name => 'Enumeration', :foreign_key => 'priority_id'
	belongs_to :category, :class_name => 'IssueCategory', :foreign_key => 'category_id'
	has_many :histories, :class_name => 'IssueHistory', :dependent => true, :order => "issue_histories.created_on DESC", :include => :status
	has_many :attachments, :as => :container, :dependent => true
	has_many :custom_values, :dependent => true 
	has_many :custom_fields, :through => :custom_values
	validates_presence_of :subject, :descr, :priority, :tracker, :author
	def before_create
		self.status = IssueStatus.default
		build_history
	end
	def long_id
		"%05d" % self.id
	end
private
	def build_history
		@history = self.histories.build
		@history.status = self.status
		@history.author = self.author
	end
end
