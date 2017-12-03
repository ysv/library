class CreateLibraryRows < ActiveRecord::Migration[5.1]
  def change
    create_table :library_rows do |t|
      t.integer :book_id
      t.integer :catalog_id
      t.integer :shel_id

      t.timestamps
    end
  end
end
