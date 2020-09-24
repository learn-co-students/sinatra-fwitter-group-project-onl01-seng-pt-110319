class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
          @tweets = Tweet.all
          erb :'tweets/tweets'
        else
          redirect to '/login'
        end
      end

    get '/tweets/new' do 
        if logged_in? 
            erb :'/tweets/new_tweet'
        else 
            redirect to '/login'
        end 
    end 

    post '/tweets' do
        if logged_in?
            if params[:content].empty?
            redirect to "/tweets/new"
          else
            @tweet = current_user.tweets.build(content: params[:content])
            if @tweet.save
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/new"
            end
          end
        else
          redirect to '/login'
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

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/edit'
          else
            redirect to '/login'
        end
    end

    patch "/tweets/:id" do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          if !params[:content].empty?
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect "/login"
        end
    end

      delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user
          @tweet = Tweet.delete(params[:id])
          redirect to '/tweets'
        else
          redirect to "/tweets/#{@tweet.id}"
        end
      end
end