class AuthorsController < ApplicationController
  def show
    @posts = Post.includes(:tag, :author).where('author_id = ?', params[:id])
    render "posts/index"
  end
end
