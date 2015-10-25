class PostsController < ApplicationController
  def index
    params[:tag_id] ? posts_by_tag : posts_by_page
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

  private
    def posts_by_page
      page = params[:page] || 1
      @posts = Post.page(page)
    end

    def posts_by_tag
      # Get the tag_id in the params, convert to a number or get nil
      tag_id = params[:tag_id] ? params[:tag_id].to_i : nil

      # Get the posts that match the tag_id
      @posts = Post.includes(:tag, :author).where('tag_id = ?', tag_id)

      # If there weren't any matches, just return all the posts.
      @posts = @posts.empty? ? Post.includes(:tag, :author) : @posts
    end

end
