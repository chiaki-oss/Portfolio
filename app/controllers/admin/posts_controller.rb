class Admin::PostsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@posts = Post.includes(:user, :prefecture, :genre).where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).page(params[:page]).per(15)
	end

end
