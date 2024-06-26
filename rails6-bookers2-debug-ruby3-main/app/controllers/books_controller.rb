class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book2 = Book.new
    @books = Book.all
    @user =  @book.user
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    #@user = current_user
    
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      flash[:alert] = "error"
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
