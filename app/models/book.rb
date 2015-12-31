class Book < ActiveRecord::Base

  has_many :book_components, dependent: :destroy

  def to_param
    title.present? ? "#{id}-#{title.to_url}" : id
  end

  scope :published, -> { where('published_at IS NOT ?', nil) }
  scope :drafts, -> { where('published_at IS ?', nil) }

  scope :by_recent, -> { order('updated_at desc') }
  scope :alphabetically, -> { order('title') }

end
