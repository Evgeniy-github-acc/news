class PostsController < ApplicationController
  
  def index
    @pagy, @posts = pagy(Post.index_page, items: 5)
  end

  def main_page
    @posts = Post.for_main_page
  end
end
