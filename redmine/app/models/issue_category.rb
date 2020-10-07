class IssueCategory < ActiveRecord::Base
  before_destroy :check_integrity  
	belongs_to :project
  validates_presence_of :name
private
  def check_integrity
    raise "Can't delete category" if Issue.find(:first, :conditions => ["category_id=?", self.id])
  end
end
