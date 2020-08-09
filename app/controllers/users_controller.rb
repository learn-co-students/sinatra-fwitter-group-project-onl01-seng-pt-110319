class UsersController < ApplicationController
    get '/users/:slug' do
        @tweeter = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
    get '/signup' do
        if !logged_in?
          erb :'users/new'
        else
          redirect '/tweets'
        end
    end
    post '/signup' do
        if user_params?
            @user = User.new(params)
            if @user.save
                session[:user_id] = @user.id
                redirect to "/tweets"
            else
                redirect '/tweets'
            end
        else
            redirect '/signup'
        end
    end
    get '/login' do
        if !logged_in?
            erb :'users/login' 
        else
            redirect "/tweets"
        end
    end
    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
    get '/logout' do
        if !logged_in?
            redirect to '/'
        else
          session.destroy
          redirect to '/login'
        end
    end
end
