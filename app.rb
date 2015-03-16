require 'sinatra'
require './models/broadcastings.rb'

if(ENV["RACK_ENV"] == "development") then
  require 'sinatra/reloader'
end
enable :method_override
get '/' do
  @broadcastings = Broadcasting.all
  erb :add_page
end

get '/broadcastings' do
  content_type :json, :charset => 'utf-8'
  b = Broadcasting.all
  b.to_json(:root => true)
end

post '/new' do
  params.each do |array, val|
    broadcasting = Broadcasting.new
    broadcasting.title = val[:title]
    broadcasting.started_day = val[:started_day]
    broadcasting.ended_day = val[:ended_day]
    broadcasting.started_time = val[:started_time]
    broadcasting.day_of_week = val[:day_of_week]
    broadcasting.tv_station = val[:tv_station]
    broadcasting.save
  end
  redirect '/'
end

delete '/del' do
  broadcasting = Broadcasting.find(params[:id])
  broadcasting.destroy
  redirect '/'

end

