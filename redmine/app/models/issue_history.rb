class IssueHistory < ActiveRecord::Base
	belongs_to :status, :class_name => 'IssueStatus', :foreign_key => 'status_id'
	belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
	validates_presence_of :status
end
