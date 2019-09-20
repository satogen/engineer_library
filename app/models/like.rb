class Like < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def book
    return Book.find_by(id: self.book_id)
  end
  
  
  def likes_count
    return Like.where(book_id: self.id).count(book_id)
  end
end
