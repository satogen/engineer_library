class User < ApplicationRecord
  has_many :likes,dependent: :destroy
  has_many :books,dependent: :destroy
  
  mount_uploader :img, ImgUploader
  validates :name,presence: true,length: {minimum: 2}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true,uniqueness: { case_sensitive: false },format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password_digest, presence: true,length: {minimum: 6}
  validates :text,length: {maximum: 170}
  
  def write_count
    return Book.where(user_id: self.id).count(id)
  end
end
