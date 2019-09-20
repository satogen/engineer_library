class BooksController < ApplicationController
  before_action :new_book
  before_action :book_user_id,only: [:show,:destroy,:edit,:update]
  before_action :book_order,only: [:index,:book_page]
  before_action :current_user,only: [:index,:book_page,:search]
  before_action :no_login_user,only: [:create,:new,:edit,:update,:destroy]
    PER = 25
    
  def book_order
    current_user
    @books = Book.page(params[:page]).per(PER)
  end
  def index
  end
  
  def new
    @method_name = "post"
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = session[:user_id]
    if @book.save
      flash[:notice] = "作成が完了しました！"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "作成が完了できませんでした!"
      render 'new'
    end
  end
  def edit
    @method_name = "patch"
  end
  
  def update
    if @book.update(book_params)
      flash[:notice] = "保存が成功しました"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "保存が失敗しました"
      render 'edit'
    end
  end
  
  def show
    @comment = Comment.new
    @comments = Comment.where(book_id: params[:id]).order(created_at: :desc)
  end
  
  def destroy
    @book.destroy
    flash[:notice] = "削除が完了しました!"
    redirect_to books_path
  end
  
  def search
    @books = Book.all
    if params[:search].present?
      @books = @books.get_by_book_name(params[:search]).page(params[:page]).per(PER)
      # @search_books = Book.search(params[:search])
      # @books = @search_books.page(params[:page]).per(PER)
    end
    if params[:tag_search].present?
      @books = @books.tagged_with("#{params[:tag_search]}").page(params[:page]).per(PER)
    end
    
  end
  
  def book_params
    params.require(:book).permit(:title,:name,:text,:img,:remove_img,:tag_list,:author)
  end
  
  def book_user_id
    @book = Book.find_by(id: params[:id]) 
  end
  
end
