require 'spec_helper'
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'UsersController' do
  describe "GET #new" do
    it "should load the page" do
      get '/users/new'
      expect(last_response).to be_ok
    end

    it "should have the login form" do
      get '/users/new'
      expect(last_response.body).to include("<form action=\"/users\" method=\"post\">")
    end
  end

  describe "POST #users" do
    it "should create a new user" do
      post '/users', {user: {username:'barry'}, password: 'test', confirm_password:'test'}
      expect(User.find_by(username: 'barry')).to be_truthy
      expect(last_response).to be_redirect
    end

    it "should not create a new user if the username exists" do
      User.create(username:'barry', password: 'test')
      post '/users', {user: {username:'barry'}, password: 'test', confirm_password:'test'}
      expect(last_response.body).to include("<form action=\"/users\" method=\"post\">")
    end
  end

  describe "GET '/users/:id'" do
    it "should load the user's page" do
      user = User.create(username:'barry', password: 'test')
      get '/users/3'
      expect(last_response.body).to include('Greetings barry!')
    end
  end

  describe 'delete user' do
    it "should delete a user" do
      user = User.create(username: 'larry', password: 'test')
      delete 'users/4'
      expect(User.find_by(username: 'larry')).to be_falsey
    end
  end
end