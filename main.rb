require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'dalli'
require 'weather-underground'
ENV["TZ"] = "America/Chicago"

set :cache, Dalli::Client.new

get '/' do
  @is_it_114 = settings.cache.get('is_it_114')
  @temp = WeatherUnderground::Base.new.CurrentObservations( 'Oklahoma City, OK' ).temp_f.to_f

  if @is_it_114.nil?
    if @temp >= 114.0
      @is_it_114 = true
      @time_set = Time.now
      settings.cache.set('is_it_114', true)
      settings.cache.set('record_set_at', @time_set)
    else
      @is_it_114 = false
    end
  else
    @time_set = settings.cache.get('record_set_at')
  end

  haml :index
end