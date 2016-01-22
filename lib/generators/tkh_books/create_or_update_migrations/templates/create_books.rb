class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string    :title
      t.string    :subtitle
      t.string    :author_name
      t.text      :description
      t.text      :author_notes
      t.datetime  :published_at
      t.boolean   :completed, default: false
      t.timestamps
    end
  end
end
