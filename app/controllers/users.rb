require 'pry'
enable :sessions
get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(params[:user]) if params[:password] == params[:confirm_password]
  user.password = params[:password]
  if user && user.save
    session[:user_id] = user.id
    redirect to('/urls')
  else
    flash[:notice] = "that username is taken."
    erb :'users/new'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/view'
end

delete '/users/:id' do
  user = User.find(params[:id])
  session[:user_id] = nil
  user.destroy
  redirect to('/urls')
end