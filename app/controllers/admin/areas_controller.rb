class Admin::AreasController < ApplicationController

	def index
		@area = Area.new
		@areas = Area.all
		@prefectures = Prefecture.all
	end

	def create
		@area = Area.new(area_params)
		if @area.save
			redirect_to admin_areas_path
		else
			render admin_areas_path
		end
	end

	def show
		@area = Area.find(params[:id])
		@prefectures = @area.prefectures
	end

	def area_params
		params.require(:area).permit(:name)
	end

end
