class CreateShels < ActiveRecord::Migration[5.1]
  def change
    create_table :shels do |t|
      t.string :name
      t.integer :row

      t.timestamps
    end
  end
end
