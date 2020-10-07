class Project < ActiveRecord::Base
	has_many :versions, :dependent => true, :order => "versions.date DESC"
	has_many :members, :dependent => true
	has_many :issues, :dependent => true, :order => "issues.created_on DESC", :include => :status
	has_many :documents, :dependent => true
	has_many :news, :dependent => true, :order => "news.created_on DESC", :include => :author
	has_many :issue_categories, :dependent => true
	has_and_belongs_to_many :custom_fields
	validates_presence_of :name, :descr
	def self.latest
		find(:all, :limit => 5, :order => "created_on DESC")	
	end	
	def current_version
		versions.find(:first, :conditions => [ "date <= ?", Date.today ], :order => "date DESC, id DESC")
	end
	def custom_fields_for_issues
		(CustomField.for_all + custom_fields).uniq
	end
end
