class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug
    username.downcase.gsub(" ","-")
  end

end
