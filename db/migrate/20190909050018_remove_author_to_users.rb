class RemoveAuthorToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :author, :text
  end
end
