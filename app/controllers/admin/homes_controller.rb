class Admin::HomesController < ApplicationController
	before_action :authenticate_admin!
	
	def top
		@new_contatcts = Contact.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
		@new_users = User.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
		@new_posts = Post.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
	end

end
