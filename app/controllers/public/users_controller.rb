class Public::UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :confirm, :withdraw]

	def show
		@user = User.find(params[:id])
		@posts = @user.posts
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path
		else
			render edit_user_path
		end
	end

	def confirm
	end

	def withdraw
		@user = current_user
		@user.update(is_active: false)
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :image, :introduction, :recommend)
	end

end
