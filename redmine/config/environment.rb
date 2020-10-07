require File.join(File.dirname(__FILE__), 'boot')
Rails::Initializer.run do |config|
	config.action_mailer.server_settings = {
		:address => "127.0.0.1",
		:port => 25,
		:domain => "somenet.foo",
		:authentication => :login,
		:user_name => "redmine",
		:password => "redmine",
	}
	config.action_mailer.perform_deliveries = true
	config.action_mailer.delivery_method = :smtp  
end
RDM_APP_NAME = "redMine" 
RDM_APP_VERSION = "0.1.0" 
RDM_HOST_NAME = "somenet.foo"
RDM_STORAGE_PATH = "#{RAILS_ROOT}/files"
RDM_LOGIN_REQUIRED = false
RDM_DEFAULT_LANG = 'en'
