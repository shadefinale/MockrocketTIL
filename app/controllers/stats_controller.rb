class StatsController < ApplicationController
  def index
    @authors_by_posts = Author.by_posts
    @tags_by_posts = Tag.by_posts
    @most_liked_posts = Post.most_liked
    @posts_by_day = Post.by_day
  end
end
