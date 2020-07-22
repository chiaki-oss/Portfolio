class Admin::PrefecturesController < ApplicationController

	def index
		@prefectures = Prefecture.all
		@areas = Area.all
	end

	def edit
		@prefecture = Prefecture.find(params[:id])
	end

	def update
		@prefecture = Prefecture.find(params[:id])
		if @prefecture.update(prefecture_params)
			redirect_to admin_prefectures_path
		else
			render edit_admin_prefecture_path(@prefecture)
		end
	end

	private
	def prefecture_params
		params.require(:prefecture).permit(:area_id, :name)
	end

end
