class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id(params[:id])
    respond_to do |format|
      format.html do
        @post ? (render show: @post) : redirect_to(posts_path)
      end

      format.text do
        text = @post ? @post.body : "Post not found."
        render plain: text
      end
    end
  end
end
