require 'spec_helper'
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'Url' do
  it "should be valid with a full_url that starts with http" do
    expect(Url.create(full_url: 'http://ign.com')).to be_valid
  end

  it "should be invalid with a url that doesn't start with http://" do
    expect(Url.create(full_url: 'www.github.com')).to be_invalid
  end

  it "should generate the short_code based on id" do
    url = Url.create(full_url: 'http://target.com')
    url.id = 100000101
    url.set_short_code
    expect(url.short_code).to eq('1KKVg')
  end

  it "should increment the access count" do
    url = Url.create(full_url: "http://amazon.com")
    url.increment_count
    expect(url.access_count).to eq(1)
  end
end