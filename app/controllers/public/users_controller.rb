class Public::UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :confirm, :withdraw]
	before_action :sidebar

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
			redirect_to user_path, notice:'会員情報を更新しました'
		else
			render edit_user_path
		end
	end

	# 退会機能
	def confirm
	end

	def withdraw
		@user = current_user
		@user.update(is_active: 0)
		redirect_to root_path
	end

	# フォロー機能
	def follow
	end

	def followers
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :image, :introduction, :recommend)
	end

end
