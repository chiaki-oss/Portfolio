class Public::NotificationsController < ApplicationController

	def index
		@notifications = current_user.passive_notifications.all
		# 通知画面を開くとchecked:trueに更新する
		@notifications.where(checked: false).each do |notification|
			notification.update_attributes(checked: true)
		end
	end


end