class Public::FavoritesController < ApplicationController
	before_action :authenticate_user!
	before_action :sidebar, only: [:index]

	def create
		@post = Post.find(params[:post_id])
	    favorite = @post.favorites.new(user_id: current_user.id)
	    favorite.save
	    @post.create_notification_like!(current_user)
	end

	def destroy
		@post = Post.find(params[:post_id])
	    favorite = current_user.favorites.find_by(post_id: @post.id)
	    favorite.destroy
	end

	def index
		@favorite_posts = current_user.favorite_posts.includes(:user, :genre, :prefecture)
	end

end
