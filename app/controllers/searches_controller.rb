class SearchesController < ApplicationController
  def show
    @posts =  params[:search] ? Post.search(params[:search]) : Post.all
  end
end
