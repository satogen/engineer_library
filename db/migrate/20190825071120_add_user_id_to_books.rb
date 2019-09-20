class AddUserIdToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :user_id, :string
  end
end
