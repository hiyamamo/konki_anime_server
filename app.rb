require 'sinatra'
require './models/programs.rb'
require './models/tv_stations.rb'
require 'csv'

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authoriezed\n"
  end

  HTTPASSWD_PATH = '.htpasswd'
  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    passwd = File.open(HTTPASSWD_PATH).read.split("\n").map{|credential| credential.split(":")}
    if @auth.provided? and @auth.basic? and @auth.credentials
      user, pass = @auth.credentials
      auth = passwd.assoc(user)
      return false unless auth
      [user, pass.crypt(auth[1][0..2])] == auth
    end
  end
end

if settings.development?
  require 'sinatra/reloader'
end

enable :method_override

before %r{^(?!/json/.*)} do
  protected!
end

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

get '/json/tv_station_list' do
  content_type :json, :charset => 'utf-8'
  tv_stations = TvStation.all
  tv_stations.to_json
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

before %r{/programs/|/tv_station_list/json} do
  cache_control :public, :max_age => 86400
end

get '/json/programs' do
  content_type :json, :charset => 'utf-8'
  p = Rack::Utils.parse_query(@env['rack.request.query_string'])
  unless p['tv_station'].nil? then
    programs = Program.where(:tv_station => p['tv_station'])
  else
    programs = Program.all
  end
  programs.to_json(:root => true)
end


put '/upload' do
  if params[:file]
    f = params[:file][:tempfile]
    i = 0
    CSV.foreach(f) do |row|
      if i != 0
        program = Program.new
        program.title = row[0]
        program.started_day = row[1]
        program.started_time = row[2]
        program.url = row[3]
        program.day_of_week = row[4]
        program.tv_station = row[5]
        program.save
      end
      i = i + 1
    end
  end
  redirect '/'
end


