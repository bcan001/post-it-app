class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = 'You are registered'
			redirect_to root_path
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
      flash[:notice] = 'update successful'
      redirect_to root_path(@user)
    else
      flash[:notice] = 'failure to update'
      render :edit
    end
	end

	def show
		@user = User.find(params[:id])
	end


	private
	def user_params
    params.require(:user).permit(:username, :password, :phone, :time_zone)
  end
end