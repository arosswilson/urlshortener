enable :sessions
get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  user = User.find_by(username: params[:username])
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect to('/urls')
  else
    flash[:notice] = "there was an error with your login. please try again"
    erb :'sessions/new'
  end
end

delete '/sessions' do
  session[:user_id] = nil
  redirect to("/urls")
end