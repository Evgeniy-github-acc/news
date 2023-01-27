class Admin::PostsController < ApplicationController
  before_action :load_post, only: %i[destroy update show]
  
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
  end

  def update
    if @post.update(post_params)
      redirect_to [:admin, @post]
    else
      render :new
    end
  end
  
  def destroy
    @post.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to admin_posts_path }
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :publish_date, :image)
  end
end
