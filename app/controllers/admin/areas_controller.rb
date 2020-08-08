class Admin::AreasController < ApplicationController
	before_action :authenticate_admin!

	def index
		@areas = Area.all
		@new_area = Area.new # 新規投稿フォーム
	end

	def create
		@area = Area.new(area_params)
		if @area.save
			redirect_to admin_areas_path
		else
			render admin_areas_path
		end
	end

	def edit
		@area = Area.find(params[:id])
	end

	def update
		@area = Area.find(params[:id])
		if @area.update(area_params)
			redirect_to admin_areas_path
		else
			render edit_admin_area_path(@area)
		end
	end

	def area_params
		params.require(:area).permit(:name)
	end

end
