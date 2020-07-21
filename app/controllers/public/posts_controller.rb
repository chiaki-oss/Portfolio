class Public::PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.save
	end

	def index
	end

	def show
	end

	def edit
	end

	def update
	end

	private
	def post_params
		params.require(:post).permit(:title, :body)
	end

end
