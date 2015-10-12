require 'rubygems'
require 'rack/test'
require 'sinatra'
require 'rspec'
require 'shoulda-matchers'
require 'database_cleaner'

def app
  Sinatra::Application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  conf.before(:each) { DatabaseCleaner.start }
  conf.after(:each)  { DatabaseCleaner.clean }
end

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
