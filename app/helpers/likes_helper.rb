module LikesHelper
  
  # def book
  #   return Book.find_by(id: self.book_id)
  # end
  def like_count
    return Like.where(book_id: self.id).count
  end
end
