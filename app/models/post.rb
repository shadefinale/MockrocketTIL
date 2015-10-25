class Post < ActiveRecord::Base
  self.per_page = 30
  belongs_to :tag
  belongs_to :author

  def publish_date
    self.created_at.strftime("%B %d, %Y")
  end

  def previous
    Post.where("id < ?", self.id).last
  end

  def next
    Post.where("id > ?", self.id).first
  end

  def increment_likes
    self.likes += 1
    self.save
  end

  def decrement_likes
    self.likes -= 1
    self.likes = 0 if self.likes < 0
    self.save
  end
end
