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

  def self.most_liked
    Post.order(likes: :desc).limit(10)
  end

  def self.by_day(days=28)
    Post.select("date(created_at)").order("date(created_at)").group("date(created_at)").count
  end

  def self.search(query)
    Post.where('body ILIKE ? OR title ILIKE ?', "%#{query}%", "%#{query}%")
  end
end
