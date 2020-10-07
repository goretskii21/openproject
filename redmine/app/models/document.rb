class Document < ActiveRecord::Base
  belongs_to :project
  belongs_to :category, :class_name => "Enumeration", :foreign_key => "category_id"
  has_many :attachments, :as => :container, :dependent => true
  validates_presence_of :title
end
