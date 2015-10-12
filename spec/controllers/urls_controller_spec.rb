require 'spec_helper'
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'UrlsController' do
  describe "GET #index" do
    it "should show the url index page" do
      get 'urls'
      expect(last_response.body).to include("Enter a Url that you would like shortened!")
    end
  end

  describe "Post #urls" do
    it "should create a new url with short code" do
      post '/urls', {url:{full_url: 'http://www.grapefruitricky.com'}}
      expect(Url.find_by(full_url: 'http://www.grapefruitricky.com')).to be_truthy
    end

    it "shouldn't create a new url if http isn't included" do
      post '/urls', {url:{full_url: 'www.grapefruitricky.com'}}
      expect(Url.find_by(full_url: 'www.grapefruitricky.com')).to be_falsey
    end
  end

  describe "get #view" do
    it "should show the view of a single url" do
      url = Url.create(full_url: 'http://grapefruitricky.com')
      get 'urls/2'
      expect(last_response.body).to include("<p>http://grapefruitricky.com</p>")
    end
  end

  describe 'delete url' do
    it "should delete a url" do
      url = Url.create(full_url: 'http://espn.com')
      delete 'urls/3'
      expect(Url.find_by(full_url: 'http://espn.com')).to be_falsey
    end
  end

  describe 'get #short_code' do
    it "should redirect to full url" do
      url = Url.create(full_url: 'http://nintendo.com')
      url.set_short_code
      url.save
      get '/e'
      expect(last_response).to be_redirect
      expect(last_response.location).to eq('http://nintendo.com')
    end
  end
end