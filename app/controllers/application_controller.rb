class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


	private

	def sidebar
		@s_areas = Area.includes(:prefectures)
		@s_genres = Genre.limit(8)
		# 投稿をもつタグのみ表示
		@s_tags = Tag.joins(:posts).where("posts.id is NOT NULL")
		#新着投稿
	end

	#sign up時の登録情報追加 # ログイン時にnameを使用
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    end

end
