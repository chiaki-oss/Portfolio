class Public::HomesController < ApplicationController
	before_action :sidebar

	def top
		@new_posts = Post.includes(:user, :prefecture, :genre).limit(4)
		# いいね数が多い投稿
		@liked_posts = Post.includes(:user, :prefecture, :genre).find(Favorite.group(:post_id).limit(4).pluck(:post_id))

		if user_signed_in?
			@new_posts = Post.includes(:user, :prefecture, :genre).limit(6)
			# いいね数が多い投稿
			@liked_posts = Post.includes(:user, :genre, :prefecture).find(Favorite.group(:post_id).limit(6).pluck(:post_id))
			# 閲覧履歴
			@histories = current_user.browsing_histories.includes(:post, post: [:user, :prefecture, :genre]).limit(4)
			# タイムライン
		    @users = current_user.following_user
		    @following_posts = Post.includes(:user, :genre, :prefecture).where(user_id: @users).limit(8)
		end
	end

end
