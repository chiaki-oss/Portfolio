class Public::PostCommentsController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		post_comment = current_user.post_comments.new(post_comment_params)
		post_comment.post_id = post.id
		if post_comment.save
			redirect_to post_path(post)
		else
			render :show
		end
	end

	def destroy
		post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
		post_comment.destroy
		redirect_to post_path(params[:post_id])
	end

	def post_comment_params
		params.require(:post_comment).permit(:comment)
	end


end