class AddPasswordDigestColToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :password_digest, :string
  end
end
