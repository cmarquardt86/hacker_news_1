helpers do

  def current_user
    if logged_in?
      User.find(session[:user_id])
    end
  end

  def logged_in?
    session[:user_id] != nil
  end

end