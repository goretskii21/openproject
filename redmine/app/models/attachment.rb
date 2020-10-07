require "digest/md5"
class Attachment < ActiveRecord::Base
  belongs_to :container, :polymorphic => true
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
	validates_presence_of :filename
	def file=(incomming_file)
		unless incomming_file.nil?
			@temp_file = incomming_file
			if @temp_file.size > 0
				self.filename = sanitize_filename(@temp_file.original_filename)
				self.disk_filename = DateTime.now.strftime("%y%m%d%H%M%S") + "_" + self.filename
				self.content_type = @temp_file.content_type
				self.size = @temp_file.size
			end
		end
	end
	def before_save
		if @temp_file && (@temp_file.size > 0)
			logger.debug("saving '#{self.diskfile}'")
			File.open(diskfile, "wb") do |f| 
				f.write(@temp_file.read)
			end
			self.digest = Digest::MD5.hexdigest(File.read(diskfile))
		end
	end
	def after_destroy
		if self.filename?
			File.delete(diskfile) if File.exist?(diskfile)
		end
	end
	def diskfile
		"#{RDM_STORAGE_PATH}/#{self.disk_filename}"
	end
  def increment_download
    increment!(:downloads)
  end
	def self.most_downloaded
		find(:all, :limit => 5, :order => "downloads DESC")	
	end
private
  def sanitize_filename(value)
      just_filename = value.gsub(/^.*(\\|\/)/, '')
      @filename = just_filename.gsub(/[^\w\.\-]/,'_') 
  end
end
