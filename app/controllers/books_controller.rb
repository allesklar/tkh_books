class BooksController < ApplicationController

  before_filter :authenticate,                              except: [ :show ]
  before_action -> { require_permission_to 'write_books'},  except: [ :show ]

  def index
    @books = Book.by_recent.paginate( :page => params[:page], :per_page => 35 )
    switch_to_admin_layout
  end

  def admin_view
    @book = Book.find(params[:id])
    switch_to_admin_layout
  end

  def show
    @book = Book.find(params[:id])
    render layout: 'book'
  end

  def new
    @book = Book.new
    switch_to_admin_layout
  end

  def edit
    @book = Book.find(params[:id])
    switch_to_admin_layout
  end

  def create
    @book = Book.new( book_params )
    if @book.save
      redirect_to books_path, notice: "The book was successfully created."
    else
      flash[:warning] = "There was a problem saving this book."
      render action: "new", layout: 'admin'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes( book_params )
      redirect_to books_path, notice: "The book was successfully saved."
    else
      flash[:warning] = "There was a problem saving this book."
      render action: "edit", layout: 'admin'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "The book has been deleted."
  end

  def publish
    book = Book.find(params[:id])
    book.published_at = Time.now
    if book.save
      redirect_to books_path, notice: "The book has been published."
    else
      redirect_to :back, flash: { error: 'There was a problem while publishing this book.' }
    end
  end

  def unpublish
    book = Book.find(params[:id])
    book.published_at = nil
    if book.save
      redirect_to books_path, notice: "The book has been unpublished and is a draft again."
    else
      redirect_to :back, flash: { error: 'There was a problem while unpublishing this book.' }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit( :title, :subtitle, :author_name, :description, :author_notes )
  end

end
