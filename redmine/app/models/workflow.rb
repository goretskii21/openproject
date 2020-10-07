class Workflow < ActiveRecord::Base
	belongs_to :role
	belongs_to :old_status, :class_name => 'IssueStatus', :foreign_key => 'old_status_id'
	belongs_to :new_status, :class_name => 'IssueStatus', :foreign_key => 'new_status_id'
	validates_presence_of :role, :old_status, :new_status
end
