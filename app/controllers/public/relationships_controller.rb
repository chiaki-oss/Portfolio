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
    @following_posts = Post.includes(:user, :genre, :prefecture).where(user_id: @users).order("created_at DESC")
  end

  # フォロワー
  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

  def timeline
    user = User.find(params[:user_id])
    @users = user.following_user
    @following_posts = Post.includes(:user, :genre, :prefecture).where(user_id: @users).order("created_at DESC")
  end


end
