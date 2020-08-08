class Public::PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :sidebar

	def new
		@post = Post.new
	end

	def index
		# 検索窓
		if params[:keyword]
			@keyword = params[:keyword]
			@posts = []

			# 入力された値を区切ってキーワード毎に検索
			@keyword.split(/[[:blank:]]+/).each do |keyword|
				# 全半角スペース、先頭の空白に対応
				next if @keyword == ""
				@posts += Post.where('title LIKE(?) OR body LIKE(?)', "%#{keyword}%", "%#{keyword}%")
			end
			# 重複している結果を削除
			@posts.uniq!

		# ソート検索
		elsif params[:option]
			@option = params[:option]
			if @option == '1'
				@posts = Post.all.order("created_at DESC")
			elsif @option == '2'
				@posts = Post.all
			end

		# トップサイドバーリンク
		elsif
			# エリア毎 = エリアに結びつく都道府県にある投稿取得
			if params[:area_id]
				@areas = Area.all
				@area = @areas.find(params[:area_id])
				# 投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
				@posts = Post.includes(:user, :genre, :prefecture).where(prefecture_id: @area.prefectures.pluck(:id))

			# 都道府県毎
			elsif params[:prefecture_id]
				@prefectures = Prefecture.all
				@prefecture = @prefectures.find(params[:prefecture_id])
				@posts = @prefecture.posts.includes(:user, :genre)

			# ジャンル毎　＝ジャンルに結びつく投稿取得
			elsif params[:genre_id]
				@genres = Genre.all
				@genre = @genres.find(params[:genre_id])
				# 投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
				@posts = @genre.posts.includes(:user, :prefecture)

			# タグ毎
			elsif params[:tag_id]
				@tags = Tag.all
				@tag = @tags.find(params[:tag_id])
				# 投稿テーブルにある該当の(指定されたエリアに紐づく)都道府県情報を取得
				@posts = @tag.posts.includes(:user, :genre, :prefecture)

			# 全件取得
			else
				@posts = Post.includes(:user, :genre, :prefecture)
			end

		end

	end

	def show
		@post = Post.find(params[:id])
		@post_comment = PostComment.new
		@post_comments = @post.post_comments.includes(:user)
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
        # 投稿に紐づくタグの変数生成
		tag_list = params[:post][:tag_ids].split(",")
		if @post.save
			# タグを保存: save_tagsメソッド(Model定義)
			@post.save_tags(tag_list)
			redirect_to @post, notice:'投稿しました'
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
		# 既存タグの取得（name配列）
		@tag_list = @post.tags.pluck(:name).join(",")
	end

	def update
		@post = Post.find(params[:id])
		# 既存タグの取得（name配列）
		tag_list = params[:post][:tag_ids].split(",")
		# update_attributes：バリデーション チェックされない
		if @post.update_attributes(post_params)
			@post.save_tags(tag_list)
			redirect_to post_path(@post), notice:'投稿を更新しました'
		else
			render 'edit'
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
