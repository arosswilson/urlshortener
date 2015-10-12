helpers do
  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
  end

  def current_users_url(url)
    return true if current_user && current_user.id == url.user_id
  end

end