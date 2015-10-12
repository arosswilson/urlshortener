require 'spec_helper'
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'User' do
  it "should be valid with a unique username" do
    expect(User.create(username: 'userone', password: 'test')).to be_valid
  end

  it "should be invalid with username that isn't unique" do
    User.create(username: 'userone', password: 'test')
    expect(User.create(username: 'userone', password: 'test')).to be_invalid
  end
end