class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :population
      t.float :owner_occupied_housing_unit_rate
      t.string :form_of_gov
      t.float :size
      t.integer :median_household_income
      t.boolean :public_transit

      t.timestamps
    end
  end
end
