class Public::PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post
		else
			@posts = Post.all
			render 'index'
		end
	end

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
	end

	def update
	end

	private
	def post_params
		params.require(:post).permit(:user_id, :genre_id, :prefecture_id, :title, :body, :image)
	end

end
