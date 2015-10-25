class AuthorsController < ApplicationController
  def show
    # Get the tag_id in the params, convert to a number or get nil
    author_id = params[:id] ? params[:id].to_i : nil

    # Get the posts that match the tag_id
    @posts = Post.includes(:tag, :author).where('author_id = ?', author_id)

    # If there weren't any matches, just return all the posts.
    @posts = @posts.empty? ? Post.includes(:tag, :author) : @posts

    render "posts/index"
  end
end
