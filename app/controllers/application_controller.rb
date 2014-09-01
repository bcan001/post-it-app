class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
  	# if there's authenticated user, return the user obj
  	# else return nil
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # see helper method above as well as navbar view for login use
  def logged_in?
  	# !! (bangbang) method turns everything into a boolean
  	# !!anything = true, !!nil = false
  	# !!current_user means 'true', so yes, we are logged in
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:error] = 'You must be logged in to do that!'
  		redirect_to login_path
  	end
  end
end
