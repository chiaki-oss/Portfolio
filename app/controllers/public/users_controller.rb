class Public::UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :confirm, :withdraw]
	before_action :sidebar
	before_action :set_user, only: [:show, :edit, :update]

	def show
		@posts = @user.posts
	end

	def update
		if @user.update(user_params)
			redirect_to user_path, notice:'会員情報を更新しました'
		else
			render edit_user_path
		end
	end

	# 退会機能
	def withdraw
		@user = current_user
		@user.update(is_active: 0)
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :image, :introduction, :recommend)
	end

	def set_user
		@user = User.find(params[:id])
	end

end
