class BooksController < ApplicationController

  def index
    @books = Book.all.includes(:author, :genre)
    @q = @books.ransack(params[:q])
    @search = @q.result.includes(:genre, :author).order(:new).page(params[:page]).per(20)

    @genres = Genre.all
  end

  def show
    @book = Book.find(params[:id])

    add_breadcrumb @book.genre.name, @book.genre
    add_breadcrumb @book.title, :book_path
  end

  def get_genre_path
    Book.find(params[:id]).genre
  end
end
