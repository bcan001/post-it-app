class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = 'You are registered for the site!'
			redirect_to root_path(@user)
		else
			render :new
		end
	end

	def edit
		@user = User.find_by slug: params[:id]
	end
	def update
		@user = User.find_by slug: params[:id]
		if @user.update(user_params)
      flash[:notice] = 'Update Successful!'
      redirect_to root_path(@user)
    else
      flash[:notice] = 'Failure to update, please enter correct paramaters'
      render :edit
    end
	end

	def show
		@user = User.find_by slug: params[:id]
	end


	private
	def user_params
    params.require(:user).permit(:username, :password, :phone, :time_zone)
  end
end