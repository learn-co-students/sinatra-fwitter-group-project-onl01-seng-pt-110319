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
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)#{
    if @tweet.save
      redirect to '/tweets'
    else
      redirect to  '/tweets/new'
    end
  end

    get '/tweets/:id' do
      if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          erb :'tweets/show'
        else
          redirect to '/login'
        end
    end

    delete  '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if @tweet.user ==current_user
        @tweet = Tweet.delete(params[:id])
        redirect to '/tweets'
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          erb :'tweets/edit'
        else
          redirect to '/login'
        end
    end

    patch '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if params[:content] != ""
          @tweet.update(content: params[:content])
          redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect to '/login'
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
