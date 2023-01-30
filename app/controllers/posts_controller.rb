class PostsController < ApplicationController
  
  def index
    @pagy, @posts = pagy(Post.where(published: true), items: 5)
  end
end
