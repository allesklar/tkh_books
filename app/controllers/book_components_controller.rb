class BookComponentsController < ApplicationController

  before_filter :authenticate,                              except: [ :show ]
  before_action -> { require_permission_to 'write_books'},  except: [ :show ]

  def show
    @book_component = BookComponent.find(params[:id])
    @book = @book_component.book
    render layout: 'book'
  end

  def new
    @book_component = BookComponent.new
    @book_component.book_id = params[:book_id] if params[:book_id].present?
    switch_to_admin_layout
  end

  def edit
    @book_component = BookComponent.find(params[:id])
    switch_to_admin_layout
  end

  def create
    @book_component = BookComponent.new( book_component_params )
    if @book_component.book.book_components.count > 1
      @book_component.position = @book_component.book.book_components.ordered.last.position + 1
    else
      @book_component.position = 1
    end
    if @book_component.save
      redirect_to admin_view_book_path(@book_component.book), notice: "The book component was successfully created."
    else
      flash[:warning] = "There was a problem saving this book component."
      render action: "new", layout: 'admin'
    end
  end

  def update
    @book_component = BookComponent.find(params[:id])
    if @book_component.update_attributes( book_component_params )
      redirect_to admin_view_book_path(@book_component.book), notice: "The book component was successfully saved."
    else
      flash[:warning] = "There was a problem saving this book component."
      render action: "edit", layout: 'admin'
    end
  end

  def destroy
    @book_component = BookComponent.find(params[:id])
    book = @book_component.book
    @book_component.destroy
    redirect_to admin_view_book_path(book), notice: "The book component has been deleted."
  end

  def publish
    book_component = BookComponent.find(params[:id])
    book_component.published_at = Time.now
    if book_component.save
      redirect_to admin_view_book_path(book_component.book), notice: "The book component has been published."
    else
      redirect_to :back, flash: { error: 'There was a problem while publishing this book component.' }
    end
  end

  def unpublish
    book_component = BookComponent.find(params[:id])
    book_component.published_at = nil
    if book_component.save
      redirect_to admin_view_book_path(book_component.book), notice: "The book component has been unpublished and is a draft again."
    else
      redirect_to :back, flash: { error: 'There was a problem while unpublishing this book component.' }
    end
  end

  def sort
    params[:book_component].each_with_index do |id, index|
      BookComponent.update(id, position: index+1)
    end
    render nothing: true
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_component_params
    params.require(:book_component).permit( :book_title, :name, :description, :body, :section_type )
  end

end
