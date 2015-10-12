require 'pry'
require 'sinatra/flash'
enable :sessions
get '/urls' do
  @urls = Url.order("access_count DESC")
  erb :"urls/index"
end

post '/urls' do
  @url = Url.new(params[:url])
  @url.user_id = current_user.id if current_user
  handle_post_request(@url)
end

get '/urls/:id' do
  @url = Url.find(params[:id])
  erb :"urls/view"
end

delete '/urls/:id' do
  @url = Url.find(params[:id])
  @url.destroy
  redirect back
end

get '/:short_code' do
  url = Url.find_by(short_code: params[:short_code])
  if url
    url.increment_count
    redirect url.full_url
  else
    status 404
    "404 - Not found"
  end
end
