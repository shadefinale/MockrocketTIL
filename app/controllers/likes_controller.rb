class LikesController < ApplicationController
  before_action :find_post
  before_action :init_liked_posts

  def update
    user_likes(@post) ? unlike_post(@post) : like_post(@post)
    @js_string = like_string(@post) + (user_likes(@post) ? " (Unlike)" : " (Like)")
    respond_to do |format|
      format.html { redirect_back }
      format.js { }
    end
  end

  private
    def init_liked_posts
      session[:liked] = session[:liked] || session["liked"] || {}
    end

    def user_likes(post)
      session[:liked][post.id.to_s]
    end

    def like_post(post)
      session[:liked][post.id.to_s]= true
      @post.increment_likes
    end

    def unlike_post(post)
      session[:liked][post.id.to_s] = false
      @post.decrement_likes
    end

    def find_post
      redirect_to(root_path) unless params[:id]
      @post = Post.find_by_id(params[:id].to_i)
      redirect_to(root_path) unless @post
    end

    def like_string(post)
      post.likes.to_s + " " + "like".pluralize(post.likes)
    end
end
