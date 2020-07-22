class Admin::AreasController < ApplicationController

	def index
		@areas = Area.all
	end

	def edit
	end

	def update
	end

	def area_params
		params.require(:area).permit(:name)
	end

end
