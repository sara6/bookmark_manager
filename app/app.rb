ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
# require_relative 'models/link.rb'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
# require 'data_mapper'
# require 'dm-postgres-adapter'

class Bookmark < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/link' do
    @link = Link.all
    erb :index
  end

  get '/link/add-new' do
    erb :add_new
  end

  post '/link' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    # the above gives the relationship between the new link and its tag.
    link.save
    redirect to ('/link')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @link = tag ? tag.link : []
    erb :'index'
  end

  get '/signup' do
    @user = User.new
    erb :signup
  end

  post '/signup' do
    @user = User.new(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
      if @user.save
        session[:user_id] = @user.id
        redirect to ('/link')
      else
        flash.now[:errors] = @user.errors.full_messages
        erb :signup
      end
  end

    get '/signin' do
      erb :signin
    end

    post '/signin' do
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect to('/link')
      else
        flash.now[:errors] = ['The email or password is incorrect']
        erb :'signin'
      end
    end

    delete '/signin' do
      session[:user_id] = nil
      flash.keep[:notice] = 'goodbye!'
      redirect to '/link'
    end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
