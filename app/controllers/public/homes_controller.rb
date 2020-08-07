class Public::HomesController < ApplicationController
	before_action :sidebar

	def top
		@new_posts = Post.includes(:user, :prefecture, :genre).limit(4).order("created_at DESC")
		#いいね数が多い投稿
		@liked_posts = Post.includes(:user, :prefecture, :genre).find(Favorite.group(:post_id).order('count(post_id)desc').limit(4).pluck(:post_id))
	end

	def about
	end

end
