require 'spec_helper'
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'SessionsController' do
  before(:each) do
    @user = User.create(username: "bob", password:"test")
  end

  describe "GET #new" do
    it "should load the page" do
      get '/sessions/new'
      expect(last_response).to be_ok
    end

    it "should have the login form" do
      get '/sessions/new'
      expect(last_response.body).to include("<form action=\"/sessions\" method=\"post\">")
    end
  end

  describe "POST #sessions" do
    it "should login a user with correct credentials" do
      post '/sessions', {username: @user.username, password: "test"}
      expect(last_response).to be_redirect
    end

    it "should not login a user with incorrect credentials" do
      post '/sessions', {username: @user.username, password: "wrong password"}
      expect(last_response.body).to include("<form action=\"/sessions\" method=\"post\">")
    end
  end

  describe "DELETE sessions#destroy" do
    it "should log a user out" do
      post '/sessions', {username: @user.username, password: "test"}
      delete '/sessions'
      expect(last_response).to be_redirect
    end
  end
end