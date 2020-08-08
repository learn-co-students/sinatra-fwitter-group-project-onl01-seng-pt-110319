class UsersController < ApplicationController
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end
  
    get '/signup' do
      if !logged_in?
        erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/tweets'
      end
    end
  
    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @users = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @users.save
        session[:user_id] = @users.id
        redirect to '/tweets'
      end
    end
  
    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/tweets'
      end
    end
  
    post '/login' do
      tweeter = User.find_by(:username => params[:username])
      if tweeter && tweeter.authenticate(params[:password])
        session[:user_id] = tweeter.id
        redirect to "/tweets"
      else
        redirect to '/signup'
      end
    end
  
    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      else
        redirect to '/'
      end
    end
  end