class Public::PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post, notice:'投稿しました'
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
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to post_path(@post), notice:'投稿を更新しました'
		else
			render edit_post_path
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path, notice:'投稿を削除しました'
	end

	private
	def post_params
		params.require(:post).permit(:user_id, :genre_id, :prefecture_id, :title, :body, :image)
	end

end
