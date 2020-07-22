class Public::UsersController < ApplicationController

	def show
		@user = current_user
		@posts = @user.posts
	end

	def edit
	end

	def update
	end

	def confirm
	end

	def withdraw
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :introduction, :recommend)
	end

end
