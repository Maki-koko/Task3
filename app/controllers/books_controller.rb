class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Your post has been successfully registered."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @bookn = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Post updated successfully."
    redirect_to book_path(@book.id) 
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
    flash[:notice] = "The post was successfully deleted."
    redirect_to books_path
    else
      render :show
    end
  end
  
  

private

    def book_params
      params.require(:book).permit(:title,:body)
    end
    
    def is_matching_login_user
      book = Book.find(params[:id])
      unless book.user_id == current_user.id
        redirect_to books_path
      end
    end
  
  
end


