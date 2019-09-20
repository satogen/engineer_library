class UsersController < ApplicationController
  protect_from_forgery except: :search # searchアクションを除外
  protect_from_forgery except: :login # searchアクションを除外

  before_action :new_book
  before_action :params_user_id,only: [:show,:detail_update,:detail_edit]
  before_action :books_nation,only: [:show]
  before_action :no_login_user,except: [:new,:create,:login,:login_form,:show]

  def index
    @users = User.all.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(safe_user)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ログインできました"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "ログインできませんでした"
      render 'new'
    end
    
  end

  def show
    current_user
    @likes = Like.where(user_id: @user.id).order('created_at desc').page(params[:page]).per(25)
    @comments = Comment.where(user_id: @user.id)
    @recommends = Recommend.where(user_id: @user.id)
  end
  
  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      flash[:notice] = "ログインできました"
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:notice] = "ログインできません"
      redirect_to users_login_form_path
    end
  end
  
  def login_form
    @user = User.new
    if session[:user_id]
      flash[:notice] = "ログイン済みです"
      current_user
      redirect_to user_path(@current_user.id)
    end
  end
  
  def destroy
    log_out
    redirect_to root_path
  end
  
  def book_page
    
  end
  def detail_edit
    
  end
  def detail_update
    if @user.update(user_detail)
      flash[:notice] = "更新しました"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "未入力、文字数を超えているものがあります"
      render "detail_edit"
    end
  end
  
  def safe_user
    params.require(:user).permit(:name,:email,:password)
  end
  
  def safe_edit
    params.require(:user).permit(:name,:email,:img,:remove_img)
  end
  def user_detail
    params.require(:user).permit(:text,:name,:img)
  end
  def params_user_id
    @user = User.find_by(id: params[:id])
  end
    PER = 25
  def books_nation
    @books = Book.where(user_id: @user.id).order('created_at desc').page(params[:page]).per(PER)
  end
end
