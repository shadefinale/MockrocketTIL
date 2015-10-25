class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :username, null: false, unique: true

      t.timestamps null: false
    end
  end
end
