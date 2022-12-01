require 'rails_helper'

RSpec.describe "Cities Index", type: :feature do
  describe "When I visit cities" do
    it 'show each city in the system including their attributes' do
      seattle = City.create!(name: "Seattle", 
                             population: 733919, 
                             owner_occupied_housing_unit_rate: 44.9, 
                             form_of_gov: "Mayor-Council", 
                             size: 83.78, 
                             median_household_income: 97185, 
                             public_transit: true)
      spokane = City.create!(name: "Spokane", 
                             population: 229071, 
                             owner_occupied_housing_unit_rate: 56.0, 
                             form_of_gov: "Mayor-Council", 
                             size: 69.49, 
                             median_household_income: 52600, 
                             public_transit: true)

      visit "/cities"
      expect(page).to have_content(seattle.name)
      expect(page).to have_content(seattle.population)
      expect(page).to have_content(seattle.owner_occupied_housing_unit_rate)
      expect(page).to have_content(seattle.form_of_gov)
      expect(page).to have_content(seattle.median_household_income)
      expect(page).to have_content(seattle.public_transit)
      expect(page).to have_content(spokane.name)
      expect(page).to have_content(spokane.population)
      expect(page).to have_content(spokane.owner_occupied_housing_unit_rate)
      expect(page).to have_content(spokane.form_of_gov)
      expect(page).to have_content(spokane.median_household_income)
      expect(page).to have_content(spokane.public_transit)
    end
  end
end