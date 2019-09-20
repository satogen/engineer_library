class Book < ApplicationRecord
  
  belongs_to :user
  has_many :likes,dependent: :destroy
  has_many :comments,dependent: :destroy
  
  acts_as_taggable
  mount_uploader :img, ImgUploader
  
  validates :title,presence: true ,length: {maximum: 30}
  validates :text,presence: true 
  
  # def self.search(search)
  #   return Book.all unless search
  #   Book.where(['title LIKE ?',"%#{search}%"])
  # end
  
  scope :get_by_book_name,-> (search){
    where(['title LIKE ? OR author LIKE ?',"%#{search}%","%#{search}%"])
  }
  
  def user
    return User.find_by(id: self.user_id)
  end
  def likes_count
    return Like.where(book_id: self.id).count(id)
  end
  
  def comment
    return Comment.find_by(book_id: self.id)
  end  
  def comments
    return Comment.where(book_id: self.id)
  end
  def recommend_counter
   return Recommend.where(book_id: self.id).count()
  end
end
