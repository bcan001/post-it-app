class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = User.first


		if @comment.save
			flash[:notice] = 'comment has been created'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end
end