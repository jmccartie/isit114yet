require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'haml'
require 'dalli'
require 'weather-underground'
require './temp.rb'
ENV["TZ"] = "America/Chicago"

set :cache, Dalli::Client.new

get '/' do
  haml :index
end

get '/temp.json' do
  updated_at = settings.cache.get("updated_at")

  Temp.new.set_temp if updated_at.nil? || updated_at < (Time.now - (60*15))

  data = {
    current_temp: settings.cache.get('current_temp'),
    is_it_114: settings.cache.get('is_it_114'),
    record_set_at: settings.cache.get('record_set_at'),
    updated_at: settings.cache.get('updated_at').strftime("%A at %l:%M%p")
  }

  content_type :json
  data.to_json
end

get "/application.js" do
  content_type :js
  coffee :application
end