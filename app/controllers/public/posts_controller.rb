class Public::PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :history]
	before_action :sidebar

	def new
		@post = Post.new
	end

	def index
		# post_serch.rbでサイドバー の検索機能一式を定義
		@post_search = PostSearch.new(params)
		@post_search.search
	end

	def show
		@post = Post.find(params[:id])
		@post_comment = PostComment.new
		@post_comments = @post.post_comments.includes(:user)

		if @post.image.present?
			@label = Vision.get_image_data(@post).join(',')
		end

		# 閲覧履歴
		if user_signed_in?
			new_history = @post.browsing_histories.new
			new_history.user_id = current_user.id

			# 閲覧履歴が既にあるか確認、ある場合は古い記録を削除して新しく保存
			if current_user.browsing_histories.exists?(post_id: "#{params[:id]}")
				old_history = current_user.browsing_histories.find_by(post_id: "#{params[:id]}")
				old_history.destroy
			end
			new_history.save

			# 閲覧履歴の上限設定。超えたら古い記録を削除
			histories_limit = 10
			histories = current_user.browsing_histories.all
			if histories.count > histories_limit
				histories[0].destroy
			end
		end
	end

	def history
		@histories = current_user.browsing_histories.includes(:post, post: [:user, :prefecture, :genre]).order("created_at DESC")
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

		if @post.image.present?
			@label = Vision.get_image_data(@post)
		end
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
