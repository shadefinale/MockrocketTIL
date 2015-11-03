class PostsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]
  before_action :get_post_and_author, only: [:edit, :update, :destroy]
  before_action :require_owner, only: [:edit, :update, :destroy]
  def index
    params[:tag_id] ? posts_by_tag : posts_by_page
    @posts = @posts.order(created_at: :desc) unless @posts.empty?
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(whitelist_post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to posts_path if @post.nil?
  end

  def update
    if @post.update(whitelist_post_params)
      redirect_to @post
    else
      render :edit
    end
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

  def destroy
    @post.destroy
    respond_to do |format|
      format.js { on_show_path ? (render js: "window.location = '/'") : (render :destroy) }
      format.html { redirect_to posts_path }
    end
  end

  private
    def on_show_path
      request && request.referer && URI(request.referer).path == post_path
    end

    def whitelist_post_params
      params.require(:post).permit(:title, :body, { :tag_attributes => [:name] })
    end

    def get_post_and_author
      @post = Post.find_by_id(params[:id])
      @author = @post.author if @post

      redirect_to(root_path) unless @post && @author
    end

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
