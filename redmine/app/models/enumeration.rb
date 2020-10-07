class Enumeration < ActiveRecord::Base
  before_destroy :check_integrity
	validates_presence_of :opt, :name
	OPTIONS = [
		["Issue priorities", "IPRI"],
		["Document categories", "DCAT"]
	].freeze
	def self.get_values(option)
		find(:all, :conditions => ['opt=?', option])
	end
  def name
    _ self.attributes['name']
  end
private
  def check_integrity
    case self.opt
    when "IPRI"
      raise "Can't delete enumeration" if Issue.find(:first, :conditions => ["priority_id=?", self.id])
    when "DCAT"
      raise "Can't delete enumeration" if Document.find(:first, :conditions => ["category_id=?", self.id])
    end
  end
end
