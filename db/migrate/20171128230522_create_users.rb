class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :day
      t.string :name
      t.string :favourite

      t.timestamps
    end
  end
end
