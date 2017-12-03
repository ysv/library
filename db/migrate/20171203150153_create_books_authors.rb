class CreateBooksAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :books_authors do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps
    end
  end
end
