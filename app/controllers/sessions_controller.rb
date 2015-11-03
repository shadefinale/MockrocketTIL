class SessionsController < ApplicationController
  before_action :store_referer

  def create
    @author = Author.find_by_username(params[:username])
    if @author && @author.authenticate(params[:password])
      sign_in(@author)
      flash[:success] = "You've successfully signed in!"
      redirect_to root_path
    else
      flash[:error] = "You couldn't be signed in. Please try again."
      redirect_to new_author_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've been signed out!"
    redirect_to root_path
  end
end
