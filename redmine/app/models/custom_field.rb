class CustomField < ActiveRecord::Base
	has_and_belongs_to_many :projects	
	has_many :custom_values, :dependent => true
	has_many :issues, :through => :issue_custom_values
	validates_presence_of :name, :typ	
	validates_uniqueness_of :name
	TYPES = [
			[ "Integer", 0 ],
			[ "String", 1 ],
			[ "Date", 2 ],
			[ "Boolean", 3 ],
			[ "List", 4 ]
	].freeze
	def self.for_all
		find(:all, :conditions => ["is_for_all=?", true])
	end
end
