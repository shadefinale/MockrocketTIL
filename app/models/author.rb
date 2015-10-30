class Author < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true, format: /\A[a-zA-Z0-9_]*\Z/, length: {in: 6..24}
  validates :password, length: {in: 8..64}
  has_many :posts

  def self.by_posts
    Author.joins(:posts).group('authors.id').order('count(posts) DESC')
  end

end
