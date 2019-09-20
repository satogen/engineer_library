class AddAuthorToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :author, :text
  end
end
