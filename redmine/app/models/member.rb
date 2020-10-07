class Member < ActiveRecord::Base
	belongs_to :user
	belongs_to :role
	belongs_to :project
	validates_presence_of :role, :user, :project
  validates_uniqueness_of :user_id, :scope => :project_id
	def name
		self.user.display_name
	end
end
