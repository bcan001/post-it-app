class CommentsController < ApplicationController

	before_action :require_user

	def create
		@post = Post.find_by slug: params[:post_id]
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user

		if @comment.save
			flash[:notice] = 'Your comment has been created'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	 def vote
    # a vote needs to get added to the votes db table
    # needs to specify vote(t or f) user_id, the voteable_type, the voteable_id
  	@comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
 
 		# if the vote is valid, then the prompt will be HTML. If the vote is invalid, the prompt will be JS
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted'
        else
          flash[:error] = 'Your vote was not counted, you can only vote once on each post'
        end
        redirect_to :back
      end
      format.js
    end
  end
 end