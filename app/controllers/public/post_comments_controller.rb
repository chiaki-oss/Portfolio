class Public::PostCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@post_comment = PostComment.new(post_comment_params)
		@post_comment.user_id = current_user.id
		@post_comment.post_id = @post.id
		if @post_comment.save
			@post_comment.post.create_notification_post_comment!(current_user, @post_comment.id)
		else
			render :show
		end
	end

	def destroy
		post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
		@post = post_comment.post
		post_comment.destroy
	end

	def post_comment_params
		params.require(:post_comment).permit(:comment, :rate)
	end

end
