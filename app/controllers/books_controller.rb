class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookfind = Book.find(params[:id])
    @book = Book.new
    @user = current_user
    @comment = BookComment.new
  
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path, alert: "不正なアクセスです。"
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "You have delete book successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end

