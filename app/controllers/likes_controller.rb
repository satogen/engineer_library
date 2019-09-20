class LikesController < ApplicationController
  
  def index
   @books = Book.joins(:likes).group(:book_id).order('count(user_id) desc')
  end
  
  def add_like
    @like = Like.new(user_id: session[:user_id],book_id: params[:id])
    @like.save
    redirect_to books_path
  end
  
  def not_like
    @like = Like.find_by(user_id: session[:user_id],book_id: params[:id])
    @like.destroy
    redirect_to books_path
  end
  
end
