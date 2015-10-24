class Post < ActiveRecord::Base
  def publish_date
    self.created_at.strftime("%B %d, %Y")
  end
end
