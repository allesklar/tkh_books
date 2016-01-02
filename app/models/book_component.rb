class BookComponent < ActiveRecord::Base

  enum section_type: [ :preface, :acknowledgements, :introduction, :section, :chapter ]

  belongs_to :book, touch: true

  def to_param
    name.present? ? "#{id}-#{name.to_url}" : id
  end

  scope :published, -> { where('published_at IS NOT ?', nil) }
  scope :drafts, -> { where('published_at IS ?', nil) }
  scope :ordered, -> { order('position') }

  ### autocomplete related instance methods
  def book_title
      book.try(:title)
    end
  def book_title=(title)
    if title.present? && Book.where(title: title)
      self.book_id = Book.where(title: title).first.id
    else
      self.book_id = nil
    end
  end

end
