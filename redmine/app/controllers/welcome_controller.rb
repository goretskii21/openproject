class WelcomeController < ApplicationController
	layout 'base'
	def index
    @news = News.latest
    @projects = Project.latest
	end
end
