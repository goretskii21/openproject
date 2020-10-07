class IssueStatus < ActiveRecord::Base
  before_destroy :check_integrity  
	has_many :workflows, :foreign_key => "old_status_id"
	validates_presence_of :name
	validates_uniqueness_of :name
	def self.default
		find(:first, :conditions =>["is_default=?", true])
	end
	def new_statuses_allowed_to(role, tracker)
		statuses = []
		for workflow in self.workflows.find(:all, :include => :new_status)
			statuses << workflow.new_status if workflow.role_id == role.id and workflow.tracker_id == tracker.id
		end unless role.nil?
		statuses
	end
  def name
    _ self.attributes['name']
  end
private
  def check_integrity
    raise "Can't delete status" if Issue.find(:first, :conditions => ["status_id=?", self.id]) or IssueHistory.find(:first, :conditions => ["status_id=?", self.id])
  end
end
