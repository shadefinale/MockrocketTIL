class Post < ActiveRecord::Base
  belongs_to :tag

  def publish_date
    self.created_at.strftime("%B %d, %Y")
  end

  def previous
    Post.where("id < ?", self.id).last
  end

  def next
    Post.where("id > ?", self.id).first
  end
end
