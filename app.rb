require 'sinatra'
require './models/programs.rb'
require './models/tv_stations.rb'

if settings.development?
  require 'sinatra/reloader'
end
enable :method_override
get '/' do
  @programs = Program.all
  @tv_stations = TvStation.all
  erb :add_page
end

post '/new' do
  params.each do |array, val|
    program = Program.new
    program.title = val[:title]
    program.started_day = val[:started_day]
    program.started_time = val[:started_time]
    program.url = val[:url]
    program.day_of_week = val[:day_of_week]
    program.tv_station = val[:tv_station]
    program.save
  end
  status 202
end
post "/update" do
  program = Program.find(params[:id]);
  program.title = params[:title]
  program.started_day = params[:started_day]
  program.started_time = params[:started_time]
  program.url = params[:url]
  program.day_of_week = params[:day_of_week]
  program.tv_station = params[:tv_station]
  program.save

  status 202
end

delete '/del' do
  program = Program.find(params[:id])
  program.destroy
  redirect '/'
end

delete '/del_all' do
  Program.delete_all
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

get '/programs' do
  content_type :json, :charset => 'utf-8'
  p = Rack::Utils.parse_query(@env['rack.request.query_string'])
  unless p['tv_station'].nil? then
    programs = Program.where(:tv_station => p['tv_station'])
  else
    programs = Program.all
  end
  programs.to_json(:root => true)
end
