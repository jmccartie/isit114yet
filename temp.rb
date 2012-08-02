require 'rubygems'
require 'bundler/setup'
require 'dalli'
require 'sinatra'
require 'weather-underground'
require './temp.rb'

class Temp

  def set_temp
    dalli = Dalli::Client.new
    dalli.set('is_it_114', false)
    dalli.set('record_set_at', false)

    temp = WeatherUnderground::Base.new.CurrentObservations( 'Oklahoma City, OK' ).temp_f.to_f
    dalli.set('current_temp', temp)
    dalli.set('updated_at', Time.now)

    if temp >= 114
      dalli.set('is_it_114', true)
    end
  end

end