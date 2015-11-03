class AddAuthTokenColToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :auth_token, :string
    add_index :authors, :auth_token, unique: true
  end
end
