require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/duopaste.sqlite3")

class Paste
  include DataMapper::Resource
  
  property :id,   Serial
  property :body, Text, :required => true
end

DataMapper.auto_upgrade!

get '/' do
  erb :new
end

post '/' do
  @paste = Paste.new(:body => params[:paste])
  if @paste.save
    redirect "#{@paste.id}"
  else
    redirect '/'
  end
end

get '/:id' do
  @paste = Paste.get(params[:id])
  if @snippet
    erb :show
  else
    redirect '/'
  end
end