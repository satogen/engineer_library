class Recommend < ApplicationRecord
  def book
    return Book.find_by(id: self.book_id)
  end
end
