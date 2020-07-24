class Public::HomesController < ApplicationController

	def top
		@areas = Area.all
		@genres = Genre.all
		@tags = Tag.all
		@posts = Post.limit(3).order("created_at DESC")
	end

	def about
	end



end
