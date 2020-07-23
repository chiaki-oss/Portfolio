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
		@areas = Area.all
		@genres = Genre.all
		#エリア毎 = エリアに結びつく都道府県にある投稿取得
		if params[:area_id]
			@area = @areas.find(params[:area_id])
			#投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
			all_posts = Post.where(prefecture_id: @area.prefectures.pluck(:id))

		# ジャンル毎　＝ジャンルに結びつく投稿取得
		elsif params[:genre_id]
			@genre = @genres.find(params[:genre_id])
			#投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
			all_posts = @genre.posts
		else
			#全件取得
			all_posts = Post.all
		end
		@posts = all_posts.all              #該当する投稿
		@all_posts_count = all_posts.count  #検出件数
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
