class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :name
      t.float :population
      t.float :gdp
      t.float :size
      t.boolean :coast

      t.timestamps
    end
  end
end
