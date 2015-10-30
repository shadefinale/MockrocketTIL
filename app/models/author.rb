class Author < ActiveRecord::Base
  before_create :generate_auth_token
  has_secure_password
  validates :username, presence: true, uniqueness: true, format: /\A[a-zA-Z0-9_]*\Z/, length: {in: 6..24}
  validates :password,
            length: {in: 8..64},
            allow_nil: true

  has_many :posts

  def self.by_posts
    Author.joins(:posts).group('authors.id').order('count(posts) DESC')
  end

  def generate_auth_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while Author.exists?(auth_token: self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_auth_token
    save!
  end

end
