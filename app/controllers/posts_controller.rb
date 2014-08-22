class PostsController < ApplicationController
  # retrieve in CRUD
  def index
  	@post = Post.all
  end
  def show
  	# render so the view template has access to the instance variable
  	# once you establis params id you can then use .title, .desc, etc... in views (@posts.title)
  	@post = Post.find(params[:id])
  	render :show
  end

  # create in CRUD
  def new
  	@post = Post.new
  end
  def create
    # initialize the article with its respective attributes
    @post = Post.new(post_params)
    @post.creator = User.first #change once we have authentication
    if @post.save
      flash[:notice] = 'your post was created'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  # update in CRUD
  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'update successful'
      redirect_to @post
    else
      flash[:notice] = 'failure to update'
      render 'edit'
    end
  end

  # delete in CRUD
  def destroy
  end

  # security so hackers can't change info passed to system (see above for method use)
  # what schemas you are allowing the post to update in the database (do not want to update the foreign key, for instance)
  private
    def post_params
      params.require(:post).permit(:title, :url, :description)
    end
end
