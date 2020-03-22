require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  get '/login' do
    erb :login
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      redirect to '/tweets'
    else
      erb :signup
    end
  end


end
