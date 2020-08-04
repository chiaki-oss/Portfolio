class Public::HomesController < ApplicationController

	def top
		@areas = Area.all
		@genres = Genre.limit(8)
		# 投稿をもつタグのみ表示
		@tags = Tag.joins(:posts).where("posts.id is NOT NULL")
		#新着投稿
		@new_posts = Post.limit(4).order("created_at DESC")
		#いいね数が多い投稿
		@liked_posts = Post.find(Favorite.group(:post_id).order('count(post_id)desc').limit(4).pluck(:post_id))
	end

	def about
	end



end
