class Post < ActiveRecord::Base
  validates :title,
            presence: true,
            length: {in: 3..64,
                    message: " should be between 3 and 64 characters"}

  validates :body,
            presence: true,
            length: {in: 1..200,
                     message: " should be between 1 and 200 words",
                     tokenizer: ->(str) { str.scan(/\w+/) }
                    }

  self.per_page = 30
  # We autosave the tag so we can find_or_create by and not have duplicates.
  belongs_to :tag, autosave: true

  belongs_to :author

  accepts_nested_attributes_for :tag

  # If two users try to make a post with tag 'Ruby', we'll ensure
  # that each post is tagged to the same tag, and not two different
  # tags named 'Ruby'.
  def autosave_associated_records_for_tag
    self.tag = Tag.find_or_create_by(name: tag.name)
    self.tag.save!
  end

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
