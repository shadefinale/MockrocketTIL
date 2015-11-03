class AuthorsController < ApplicationController
  def show
    # Get the tag_id in the params, convert to a number or get nil
    @author_id = params[:id] ? params[:id].to_i : nil

    # Get the posts that match the tag_id
    @posts = Post.includes(:tag, :author).where('author_id = ?', @author_id)

    # If there weren't any matches, just return all the posts.
    @posts = Author.find_by_id(@author_id) ? @posts : Post.includes(:tag, :author)
    @posts = @posts.order(created_at: :desc)

    render "posts/index"
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(whitelist_author_params)

    if @author.save
      sign_in(@author)
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def whitelist_author_params
      params.require(:author).permit(:username, :password, :password_confirmation)
    end
end
