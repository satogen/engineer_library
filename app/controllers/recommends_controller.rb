class RecommendsController < ApplicationController
  def add_recommend
    @recommend = Recommend.new(book_id: params[:id],user_id: session[:user_id])
    if @recommend.save
      flash[:notice] = "おすすめしました"
      redirect_to books_path
    else
      flash[:notice] = "失敗しました"
      redirect_to books_path
    end
  end  
  def remove_recommend
    @recommend = Recommend.find_by(book_id: params[:id],user_id: session[:user_id])
    @recommend.destroy
    redirect_to books_path
  end
end
