class Mailer < ActionMailer::Base
	def issue_change_status(issue)
		@recipients 	= issue.project.members.collect { |m| m.user.mail if m.user.mail_notification }
		@from       		= 'redmine@somenet.foo'
		@subject    	= "Issue ##{issue.id} has been updated"
		@body['issue'] = issue
	end
	def issue_add(issue)
		@recipients 	= issue.project.members.collect { |m| m.user.mail if m.user.mail_notification }
		@from       		= 'redmine@somenet.foo'
		@subject    	= "Issue ##{issue.id} has been reported"
		@body['issue'] = issue
	end
end
