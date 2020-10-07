class ReportsController < ApplicationController
 	layout 'base'
	before_filter :find_project, :authorize
  def issue_report
    @statuses = IssueStatus.find_all
    @trackers = Tracker.find_all
    @issues_by_tracker = 
      ActiveRecord::Base.connection.select_all("select    s.id as status_id, 
                                                  s.is_closed as closed, 
                                                  t.id as tracker_id,
                                                  count(i.id) as total 
                                                from 
                                                  issues i, issue_statuses s, trackers t
                                                where 
                                                  i.status_id=s.id 
                                                  and i.tracker_id=t.id
                                                  and i.project_id=#{@project.id}
                                                group by s.id, t.id")
    @priorities = Enumeration::get_values('IPRI')
    @issues_by_priority = 
      ActiveRecord::Base.connection.select_all("select    s.id as status_id, 
                                                  s.is_closed as closed, 
                                                  p.id as priority_id,
                                                  count(i.id) as total 
                                                from 
                                                  issues i, issue_statuses s, enumerations p
                                                where 
                                                  i.status_id=s.id 
                                                  and i.priority_id=p.id
                                                  and i.project_id=#{@project.id}
                                                group by s.id, p.id")
    @categories = @project.issue_categories
    @issues_by_category = 
      ActiveRecord::Base.connection.select_all("select    s.id as status_id, 
                                                  s.is_closed as closed, 
                                                  c.id as category_id,
                                                  count(i.id) as total 
                                                from 
                                                  issues i, issue_statuses s, issue_categories c
                                                where 
                                                  i.status_id=s.id 
                                                  and i.category_id=c.id
                                                  and i.project_id=#{@project.id}
                                                group by s.id, c.id")
  end
private
	def find_project
		@project = Project.find(params[:id])		
	end
end
