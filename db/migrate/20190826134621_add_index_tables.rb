class AddIndexTables < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, [:book_id, :user_id], unique: true
  end
end
