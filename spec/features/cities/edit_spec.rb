require 'rails_helper'

RSpec.describe "Cities Edit", type: :feature do
    before :each do
        @washington = State.create!(name: "Washington", 
          population: 7.739, 
          gdp: 492.63, 
          size: 71362, 
          coastal: true)
          @seattle = @washington.cities.create!(
            name: "Seattle", 
            population: 733919, 
            owner_occupied_housing_unit_rate: 44.9, 
            form_of_gov: "Mayor-Council", 
            size: 83.78, 
            median_household_income: 97185, 
            public_transit: true)
    end

    it "has fields for updating the city " do
        visit "/cities/#{@seattle.id}/edit"

        expect(page).to have_field("City[name]")
        expect(page).to have_field("City[population]")
        expect(page).to have_field("City[owner_occupied_housing_unit_rate]")
        expect(page).to have_field("City[form_of_gov]")
        expect(page).to have_field("City[size]")
        expect(page).to have_field("City[median_household_income]")
        expect(page).to have_field("City[public_transit]")
    end
end