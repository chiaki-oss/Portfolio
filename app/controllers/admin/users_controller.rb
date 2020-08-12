class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!

	def index
		# 検索窓
		if params[:keyword]
			@keyword = params[:keyword]
			@users = []

			# 入力された値を区切ってキーワード毎に検索
			@keyword.split(/[[:blank:]]+/).each do |keyword|
				# 全半角スペース、先頭の空白に対応
				next if @keyword == ""
				@users += User.where('name LIKE(?)', "%#{keyword}%")
			end
			# 重複している結果を削除
			@users.uniq!

		elsif
			@users = User.all
		end
	end

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
			redirect_to admin_user_path(@user), notice:'会員情報を更新しました'
		else
			render 'edit'
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :is_active)
	end

end
