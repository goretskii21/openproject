class Role < ActiveRecord::Base
  before_destroy :check_integrity  
	has_and_belongs_to_many :permissions
  has_many :workflows, :dependent => true
  has_many :members
	validates_presence_of :name
	validates_uniqueness_of :name
private
  def check_integrity
    raise "Can't delete role" if Member.find(:first, :conditions =>["role_id=?", self.id])
  end
end
