class CreateBookComponents < ActiveRecord::Migration
  def change
    create_table :book_components do |t|
      t.integer  :book_id
      t.string   :name
      t.text     :description
      t.text     :body
      t.integer  :section_type
      t.integer  :position, default: 0
      t.datetime :published_at
      t.timestamps
    end
    add_index :book_components, :book_id
  end
end
