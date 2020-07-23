class Public::HomesController < ApplicationController

	def top
		@areas = Area.all
		@genres = Genre.all
	end

	def about
	end



end
