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

        expect(page).to have_field(:name)
        expect(page).to have_field(:population)
        expect(page).to have_field(:owner_occupied_housing_unit_rate)
        expect(page).to have_field(:form_of_gov)
        expect(page).to have_field(:size)
        expect(page).to have_field(:median_household_income)
        expect(page).to have_field(:public_transit)
    end

    it "a city's info is updated and user is redirected to the city's show page" do
        visit "/cities/#{@seattle.id}/edit"
        fill_in :size, with: '1254.51'
        choose :public_transit, option: "false"
        click_button 'Edit City'
  
        expect(page).to have_content("#{@seattle.name}")
        expect(page).to have_content("Size: 1254.51")
        expect(page).to have_content("Has public transportation: false")
    end
end