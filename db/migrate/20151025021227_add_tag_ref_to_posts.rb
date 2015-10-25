class AddTagRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :tag, index: true, foreign_key: true
  end
end
