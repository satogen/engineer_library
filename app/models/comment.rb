class Comment < ApplicationRecord
  validates :text,presence: true,length: {maximum: 150}
  belongs_to :books,optional: true

  def user
    return User.find_by(id: self.user_id)
  end
  def book
    return Book.find_by(user_id: self.user_id)
  end
end
