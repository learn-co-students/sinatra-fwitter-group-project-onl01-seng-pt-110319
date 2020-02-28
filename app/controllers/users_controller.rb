class UsersController < ApplicationController

    get '/signup' do
        if Helpers.is_logged_in?(session) 
          redirect to '/tweets'
        end
        erb :'/users/signup'
    end
    
    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          redirect to '/signup'
        end
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to '/tweets'
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        end
        erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

end
