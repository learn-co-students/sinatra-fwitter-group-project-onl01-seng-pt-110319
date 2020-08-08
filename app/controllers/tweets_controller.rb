class TweetsController < ApplicationController
    get '/tweets' do
      if logged_in?
        @words = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
    end

    delete '/tweets/:id/delete' do
        if logged_in?

          @words = Tweet.find_by_id(params[:id])
          if @words && @words.user == current_user
            @words.delete
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end


      end
  
    get '/tweets/new' do
      if logged_in?
        erb :'tweets/create_tweet'
      else
        redirect to '/login'
      end


    end
  
    post '/tweets' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/new"
        else

          @words = current_user.tweets.build(content: params[:content])
          if @words.save
            redirect to "/tweets/#{@words.id}"
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
        @words = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to '/login'
      end
    end



  
    get '/tweets/:id/edit' do
      if logged_in?
        @words = Tweet.find_by_id(params[:id])
        if @words && @words.user == current_user
          erb :'tweets/edit_tweet'
        else
          redirect to '/tweets'
        end

      else
        redirect to '/login'
      end

    end
  
    patch '/tweets/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/#{params[:id]}/edit"
        else
          @words = Tweet.find_by_id(params[:id])



          if @words && @words.user == current_user
            if @words.update(content: params[:content])
              redirect to "/tweets/#{@words.id}"
            else
              redirect to "/tweets/#{@words.id}/edit"
            end
          else
            redirect to '/tweets'
          end
        end
      else
        redirect to '/login'
      end
    end
  
  end
