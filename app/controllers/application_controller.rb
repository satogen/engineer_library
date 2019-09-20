class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include UsersHelper
  include LikesHelper
  def new_book
    @book = Book.new
  end

end
