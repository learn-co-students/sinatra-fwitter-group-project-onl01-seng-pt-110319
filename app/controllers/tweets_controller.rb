class TweetsController < ApplicationController

enable :sessions
set :session_secret, "secret"


  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect to "/login"
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if @tweet.save
      redirect to '/tweets'
    else
      redirect to  '/tweets/new'
    end

    get '/tweets/:id' do
          @tweet =   Tweet.find(params[:id])
          erb :'tweets/show'
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
