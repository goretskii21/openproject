class Version < ActiveRecord::Base
  before_destroy :check_integrity  
	belongs_to :project
	has_many :fixed_issues, :class_name => 'Issue', :foreign_key => 'fixed_version_id'
  has_many :attachments, :as => :container, :dependent => true
	validates_presence_of :name, :descr
private
  def check_integrity
    raise "Can't delete version" if self.fixed_issues.find(:first)
  end
end
