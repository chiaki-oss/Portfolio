class Admin::PrefecturesController < ApplicationController
	before_action :authenticate_admin!

	def edit
		@prefecture = Prefecture.find(params[:id])
	end

	def update
		prefecture = Prefecture.find(params[:id])
		prefecture.update(prefecture_params)
		redirect_to admin_areas_path, notice:'エリア設定を変更しました'
	end

	private
	def prefecture_params
		params.require(:prefecture).permit(:area_id, :name)
	end

end
