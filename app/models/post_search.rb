class PostSearch
	attr_reader :keyword, :posts, :option, :area, :prefecture, :genre, :tag, :count, :params
	# ↑インスタンス変数の読み出し専用アクセサを定義

	# controllerでnewと同時に呼び出される
	def initialize(params)
		@params = params
	end

	def search
		# 検索窓
		if @params[:keyword]
			@keyword = @params[:keyword]
			posts = []
			# 入力された値を区切ってキーワード毎に検索
			@keyword.split(/[[:blank:]]+/).each do |keyword|
				# 全半角スペース、先頭の空白に対応
				next if @keyword == ""
				posts += Post.where('title LIKE(?) OR body LIKE(?)', "%#{keyword}%", "%#{keyword}%")
			end
			# 重複している結果を削除
			posts.uniq!
            # paginate_arrayメソッドで配列をページネーション
			@posts = Kaminari.paginate_array(posts).page(params[:page]).per(20)

		# ソート検索
		elsif @params[:option]
			@option = @params[:option]
			if @option == 'new'
				posts = Post.includes(:user, :genre, :prefecture).order("created_at DESC")
				@posts = posts.page(params[:page]).per(20)
			elsif @option == 'old'
				posts = Post.includes(:user, :genre, :prefecture)
				@posts = posts.page(params[:page]).per(20)
			elsif @option == 'likes'
				posts = Post.includes(:user, :prefecture, :genre).find(Favorite.group(:post_id).order('count(post_id)desc').pluck(:post_id))
				@posts = Kaminari.paginate_array(posts).page(params[:page]).per(20)
			end

		# トップサイドバーリンク
			# エリア毎 = エリアに結びつく都道府県にある投稿取得
		elsif @params[:area_id]
			@area = Area.find(@params[:area_id])
			posts = Post.includes(:user, :genre, :prefecture).where(prefecture_id: @area.prefectures.pluck(:id))
			@posts = posts.page(params[:page]).per(20)

		# 都道府県毎
		elsif @params[:prefecture_id]
			@prefecture = Prefecture.find(@params[:prefecture_id])
			posts = @prefecture.posts.includes(:user, :genre)
			@posts = posts.page(params[:page]).per(20)

		# ジャンル毎
		elsif @params[:genre_id]
			@genre = Genre.find(@params[:genre_id])
			posts = @genre.posts.includes(:user, :prefecture)
			@posts = posts.page(params[:page]).per(20)

		# タグ毎
		elsif @params[:tag_id]
			@tag = Tag.find(@params[:tag_id])
			posts = @tag.posts.includes(:user, :genre, :prefecture)
			@posts = posts.page(params[:page]).per(20)

		# 一覧　全件取得
		else
			posts = Post.includes(:user, :genre, :prefecture)
			@posts = posts.page(params[:page]).per(20)
		end

		@count = posts.count
	end
end