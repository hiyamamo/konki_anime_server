ENV['RACK_ENV'] = 'test'
#require 'minitest/autorun'
require 'test/unit'
require 'rack/test'

require './app'

class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_without_authentication
    get '/'
    assert_equal 401, last_response.status
  end

  def test_with_bad_confidentials
    authorize 'bad', 'boy'
    get '/'
    assert_equal 401, last_response.status
  end

  def test_with_proper_credentials
    authorize 'hiroki', 'nuresen599'
    get '/'
    assert_equal 200, last_response.status
  end

  def test_without_authentication_at_json_programs
    get '/json/programs'
    assert_equal 200, last_response.status
  end

  def test_without_authentication_at_json_tv_station_list
    get '/json/tv_station_list'
    assert_equal 200, last_response.status
  end

end
