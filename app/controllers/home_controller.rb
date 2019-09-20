class HomeController < ApplicationController
  PER = 10
  before_action :new_book

  def index
    current_user
    @books = Book.page(params[:page]).per(PER)
  end
end
