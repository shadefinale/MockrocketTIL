class Author < ActiveRecord::Base
  has_many :posts

  def self.by_posts
    Author.joins(:posts).group('authors.id').order('count(posts) DESC')
  end

end
