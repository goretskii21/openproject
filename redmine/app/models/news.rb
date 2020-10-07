class News < ActiveRecord::Base
	belongs_to :project
	belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
	validates_presence_of :title, :shortdescr, :descr
	def self.latest
		find(:all, :limit => 5, :include => [ :author, :project ], :order => "news.created_on DESC")	
	end	
end
