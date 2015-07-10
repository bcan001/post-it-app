class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  # so people not logged in can't access and edit posts and comments
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  # retrieve in CRUD
  def index
  	# @post = Post.all.sort_by{|x| x.total_votes}.reverse
    # @post = Post.all
    @post = Post.order("id DESC").paginate(:page => params[:page], :per_page => 5)
    @users = User.all

  end
  def show
  	# @post = Post.find(params[:id])
  	render :show
  end

  # create in CRUD
  def new
  	@post = Post.new
  end
  def create
    # initialize the article with its respective attributes
    @post = Post.new(post_params)
    @post.creator = current_user #change once we have authentication

    if @post.save
      flash[:notice] = 'Your post was created'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    #@post = Post.find(params[:id])
  end

  def update
    #@post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated successfully'
      redirect_to post_path(@post)
    else
      flash[:notice] = 'Failure to update your post'
      render :edit
    end
  end

  def destroy
  end

  def vote
    # a vote needs to get added to the votes db table
    # needs to specify vote(t or f) user_id, the voteable_type, the voteable_id
  
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
 
    # if the vote is valid, then the prompt will be HTML. If the vote is invalid, the prompt will be JS
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted.'
        else
          flash[:error] = 'Your vote was not counted, you can only vote once on each post'
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    #@post = Post.find(params[:id])
    @post = Post.find_by slug: params[:id]
  end

  def require_creator
    if current_user != @post.creator
      access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
    end
  end 
end
