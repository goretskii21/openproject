class HelpController < ApplicationController
  skip_before_filter :check_if_login_required
	before_filter :load_help_config
	def index	
		if @params[:ctrl] and @help_config[@params[:ctrl]]
			if @params[:page] and @help_config[@params[:ctrl]][@params[:page]]
				template = @help_config[@params[:ctrl]][@params[:page]]
			else
				template = @help_config[@params[:ctrl]]['index']
			end
		end
    if template
      redirect_to "/manual/#{template}"
    else
      redirect_to "/manual/"
    end
	end
private
	def load_help_config
		@help_config = YAML::load(File.open("#{RAILS_ROOT}/config/help.yml"))
	end	
end
