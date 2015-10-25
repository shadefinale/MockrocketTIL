class PostsController < ApplicationController
  def index
    # Get the tag_id in the params, convert to a number or get nil
    tag_id = params[:tag_id] ? params[:tag_id].to_i : nil

    # Get the posts that match the tag_id
    @posts = Post.includes(:tag).where('tag_id = ?', tag_id)

    # If there weren't any matches, just return all the posts.
    @posts = @posts.empty? ? Post.includes(:tag) : @posts
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
