class SessionsController < ApplicationController
	def new

	end

	def create
		# ex. user.authenticate('password')
		# 1. get the user obj
		# 2. see if password matches
		# 3. if so, log in
		# 4. if not, error message
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			# if the login is correct, will create a session hash

			session[:user_id] = user.id
			flash[:notice] = 'You\'ve logged in!'
			redirect_to root_path
		else
			flash[:error] = 'There\'s something wrong with your password'
			redirect_to register_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = 'You\'ve logged out!'
		redirect_to root_path
	end
end