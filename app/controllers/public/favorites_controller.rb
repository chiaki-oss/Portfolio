class Public::FavoritesController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
	    favorite = @post.favorites.new(user_id: current_user.id)
	    favorite.save
	    redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
	    favorite = current_user.favorites.find_by(post_id: @post.id)
	    favorite.destroy
	    redirect_to post_path(@post)
	end

	def index
		@favorite_posts = current_user.favorite_posts
	end

end
