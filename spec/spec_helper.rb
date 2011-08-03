# Load the Sinatra app
require File.dirname(__FILE__) + '/../main'

require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'

set :environment, :test

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.app = Sinatra::Application