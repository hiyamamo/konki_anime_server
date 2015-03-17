require 'sinatra'
require './models/broadcastings.rb'
require './models/tv_stations.rb'

if settings.development?
  require 'sinatra/reloader'
end
enable :method_override
get '/' do
  @broadcastings = Broadcasting.all
  @tv_stations = TvStation.all
  erb :add_page
end

post '/new' do
  params.each do |array, val|
    broadcasting = Broadcasting.new
    broadcasting.title = val[:title]
    broadcasting.started_day = val[:started_day]
    broadcasting.started_time = val[:started_time]
    broadcasting.url = val[:url]
    broadcasting.day_of_week = val[:day_of_week]
    broadcasting.tv_station = val[:tv_station]
    broadcasting.save
  end
  status 202
end

delete '/del' do
  broadcasting = Broadcasting.find(params[:id])
  broadcasting.destroy
  redirect '/'
end

delete '/del_all' do
  Broadcasting.delete_all
  redirect '/'
end

get '/tv_station_list' do
  @tv_stations = TvStation.all
  erb :tv_station_list
end

post '/tv_station_list/new' do
  tv_station = TvStation.new
  tv_station.name = params[:name]
  tv_station.save
  status 202
  redirect '/tv_station_list'
end
delete '/tv_station_list/del' do
  tv_station = TvStation.find(params[:id])
  tv_station.destroy
  redirect '/tv_station_list'
end

get '/broadcastings/' do
  content_type :json, :charset => 'utf-8'
  p = Rack::Utils.parse_query(@env['rack.request.query_string'])
  b = Broadcasting.where(:tv_station => p['tv_station'])
  b.to_json(:root => true)
end
