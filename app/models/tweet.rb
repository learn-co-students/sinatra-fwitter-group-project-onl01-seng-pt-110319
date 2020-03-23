class Tweet < ActiveRecord::Base
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods
  validates_presence_of :content
  
  belongs_to :user
end
