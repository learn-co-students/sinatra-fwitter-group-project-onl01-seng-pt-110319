class UsersController < ApplicationController
enable :sessions
set :session_secret, "secret"

get '/signup' do
  if logged_in?
    redirect to '/tweets'
  else
    erb :signup
  end
end

get '/login' do
  if logged_in?
    redirect to '/tweets'
  else
    erb :login
  end
end

post '/signup' do
#  binding.pry
  @user = User.new(params)
  if @user.save
    session[:user_id] = @user.id
    redirect to '/tweets'
  else
    redirect to  '/signup'
  end
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to "/tweets"
  else
    redirect to "/login"
  end
end

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
