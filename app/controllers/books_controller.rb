class BooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :find_by?, only:[:show, :edit, :update, :destroy]
  before_action :new_kara, only:[:show, :index]
  before_action :correct_user?, only: [:edit, :update]

  def index
  end

  def show
  end

  def create
    @book_new = Book.new(book_params)
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end


private

  def find_by?
    @book = Book.find(params[:id])
  end

  def correct_user?
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id).merge(:user_id => current_user.id)
  end
end