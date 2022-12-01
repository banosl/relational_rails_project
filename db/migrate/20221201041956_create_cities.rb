class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :string
      t.string :population
      t.string :integer
      t.string :owner_occupied_housing_unit_rate
      t.string :float
      t.string :form_of_gov
      t.string :string
      t.string :size
      t.string :float
      t.string :median_household_income
      t.string :integer
      t.string :public_transit
      t.string :boolean

      t.timestamps
    end
  end
end
