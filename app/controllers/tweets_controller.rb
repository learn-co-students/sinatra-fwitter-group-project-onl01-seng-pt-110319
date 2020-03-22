class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :index
    else
      redirect to "/login"
    end
  end

end
