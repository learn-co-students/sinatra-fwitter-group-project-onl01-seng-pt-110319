class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_digest
  has_secure_password
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :tweets
end
