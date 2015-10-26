class Tag < ActiveRecord::Base
  has_many :posts

  def self.by_posts
    Tag.joins(:posts).group('tags.id').order('count(posts) DESC')
  end
end
