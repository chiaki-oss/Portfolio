class Public::PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		tag_list = params[:post][:tag_ids].split(",")
		if @post.save
			@post.save_tags(tag_list)
			redirect_to @post, notice:'投稿しました'
		else
			render 'new'
		end
	end

	def index
		#エリア毎 = エリアに結びつく都道府県にある投稿取得
		if params[:area_id]
			@areas = Area.all
			@area = @areas.find(params[:area_id])
			#投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
			all_posts = Post.where(prefecture_id: @area.prefectures.pluck(:id))

		# ジャンル毎　＝ジャンルに結びつく投稿取得
		elsif params[:genre_id]
			@genres = Genre.all
			@genre = @genres.find(params[:genre_id])
			#投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
			all_posts = @genre.posts

		# タグ毎
		elsif params[:tag_id]
			@tags = Tag.all
			@tag = @tags.find(params[:tag_id])
			#投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
			all_posts = @tag.posts

		#全件取得
		else
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
