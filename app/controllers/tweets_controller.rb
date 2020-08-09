class TweetsController < ApplicationController
    get '/tweets' do
        if !logged_in?
            redirect to '/login'
        else
            @tweets = Tweet.all
            erb :'tweets/index'
        end
    end
    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'/tweets/new'
        end
    end

    post '/tweets' do
      if !logged_in?
        redirect '/login'
      else
        if empty_tweet?
            redirect to '/tweets/new'
        else
            @tweet = current_user.tweets.build(content: params[:content])
            if @tweet.save
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to '/tweets/new'
            end
        end
      end
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show'
        end
    end
    get '/tweets/:id/edit' do
      if !logged_in?
        redirect '/login'
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'tweets/edit'
        else
          redirect to '/tweets'
        end
      end
    end
  
    patch '/tweets/:id' do
      if !logged_in?
        redirect '/login'
      else
        if empty_tweet?
          redirect to "/tweets/#{params[:id]}/edit"
        else
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            if @tweet.update(content: params[:content])
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect "/tweets/#{@tweet.id}/edit"
            end
          else
            redirect'/tweets'
          end
        end
      end
    end
  
    delete '/tweets/:id/delete' do
      if !logged_in?
        redirect '/login'
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.delete
        else
        redirect to '/tweets'
        end
      end
    end
end
