ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
# require_relative 'models/link.rb'
require_relative 'data_mapper_setup'
# require 'data_mapper'
# require 'dm-postgres-adapter'

class Bookmark < Sinatra::Base

  get '/link' do
    @link = Link.all
    erb :index
  end

  get '/link/add-new' do
    erb :add_new
  end

  post '/link' do
    link = Link.new(url: params[:url],
                    title: params[:title])
    tag = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect to ('/link')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @link = tag ? tag.link : []
    erb :'index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
