class CommentsController < ApplicationController
  def create
    @comment = Comment.new(safe_comment)
    @comment.user_id = session[:user_id]
    @comment.book_id = params[:book_id]
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to(book_path(@comment.book_id))
    else
      @book = Book.find(params[:book_id])
      flash[:notice] = "未入力または、文字数がオーバーしています"
      render('books/show',locals: {book: @book})
    end
  end
  
  def safe_comment
    params.require(:comment).permit(:text)
  end
end
