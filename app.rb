require 'sinatra'
require 'sinatra/reloader'
require './models/broadcastings.rb'

enable :method_override
get '/' do
  @broadcastings = Broadcasting.all
  erb :add_page
end

get '/broadcasting' do
  content_type :json, :charset => 'utf-8'
end

post '/new' do
  broadcasting = Broadcasting.new
  broadcasting.title = params[:title]
  broadcasting.started_day = params[:started_day]
  broadcasting.ended_day = params[:ended_day]
  broadcasting.started_time = params[:started_time]
  broadcasting.day_of_week = params[:day_of_week]
  broadcasting.tv_station = params[:tv_station]
  broadcasting.save
  redirect '/admin/add'
end

delete '/del' do
  broadcasting = Broadcasting.find(params[:id])
  broadcasting.destroy
  redirect '/admin/add'

end

