require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'dalli'
require 'weather-underground'
require './temp.rb'
ENV["TZ"] = "America/Chicago"

set :cache, Dalli::Client.new

get '/' do
  @is_it_114 = settings.cache.get('is_it_114')
  @temp = settings.cache.get('current_temp')

  if @temp.nil?
    Temp.new.set_temp
    @is_it_114 = settings.cache.get('is_it_114')
    @temp = settings.cache.get('current_temp')
  end

  @time_set = settings.cache.get('record_set_at')

  haml :index
end