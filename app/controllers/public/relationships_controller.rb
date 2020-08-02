class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

	# Follow
	def create
    user = current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])

    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  # UnFollow
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォローしてるユーザー
  def follower
    user = User.find(params[:user_id])
    @users = user.following_user
  end

  # フォロワー
  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end


end
