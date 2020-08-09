require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end
  get '/' do
    erb :welcome
  end

  helpers do

    def logged_in?
      !!current_user
    end
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    def user_params?
      !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    end
    def empty_tweet?
      params[:content] == ""
    end

  end

end
