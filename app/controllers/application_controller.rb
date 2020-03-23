require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions
  set :session_secret, "secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end


end
