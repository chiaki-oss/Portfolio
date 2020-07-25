class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


	private

	#sign up時の登録情報追加 # ログイン時にnameを使用
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    end

end
