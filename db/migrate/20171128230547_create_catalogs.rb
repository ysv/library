class CreateCatalogs < ActiveRecord::Migration[5.1]
  def change
    create_table :catalogs do |t|
      t.integer :folder
      t.string :type
      t.string :name
      t.string :characteristic

      t.timestamps
    end
  end
end
