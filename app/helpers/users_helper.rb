module UsersHelper
  
  def login_user(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash[:notice] = "ログアウトしました"
  end
  
  def no_login_user
    unless logged_in?
      flash[:notice] = "ログインしてください"
      redirect_to root_path
    end
  end
  
end
