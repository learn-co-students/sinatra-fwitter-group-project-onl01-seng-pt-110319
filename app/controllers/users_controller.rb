class UsersController < ApplicationController
enable :sessions
set :session_secret, "secret"

  get '/users/:slug' do
    #  if logged_in?
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    #  else
    #    redirect to '/login'
    #  end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
