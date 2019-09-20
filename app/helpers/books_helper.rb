module BooksHelper
  
  def create_book_count(user)
    return Book.where(user_id: user).count
  end
  def user_like_count(user)
    return Like.where(user_id: user).count
  end  
  def book_like_count(book)
    return Like.where(book_id: book).count
  end
  
  def user_return_comment(user)
    @usersbook = Book.where(user_id: user)
    return @usersbook.joins(:comments).count
  end
  
  def user_history_comment(user)
    return Comment.where(user_id: user).count
  end
  
  def user_recommend_count(user)
    return Recommend.where(user_id: user).count
  end  
  def book_recommend_count(book)
    return Recommend.where(book_id: book).count
  end
  
end
