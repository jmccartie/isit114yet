require 'rubygems'
require 'bundler/setup'
require 'dalli'
require 'sinatra'
require 'weather-underground'
require './temp.rb'

class Temp

  def set_temp
    dalli = Dalli::Client.new
    dalli.delete('is_it_114')
    temp = WeatherUnderground::Base.new.CurrentObservations( 'Oklahoma City, OK' ).temp_f.to_f
    dalli.set('current_temp', temp)

    if temp >= 114
      dalli.set('is_it_114', true)
    end
  end

end