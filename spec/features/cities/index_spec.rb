require 'rails_helper'

RSpec.describe "Cities Index", type: :feature do
  describe "When I visit cities" do
    before :each do
      @washington = State.create!(name:"Washington", 
        population:7.739, 
        gdp:577.2, 
        size:71362, 
        coastal:true)
      @seattle = @washington.cities.create!(name: "Seattle", 
        population: 733919, 
        owner_occupied_housing_unit_rate: 44.9, 
        form_of_gov: "Mayor-Council", 
        size: 83.78, 
        median_household_income: 97185, 
        public_transit: true)
      @spokane = @washington.cities.create!(name: "Spokane", 
        population: 229071, 
        owner_occupied_housing_unit_rate: 56.0, 
        form_of_gov: "Mayor-Council", 
        size: 69.49, 
        median_household_income: 52600, 
        public_transit: true)
      @republic = @washington.cities.create!(name: "Republic",
        population: 1144, 
        owner_occupied_housing_unit_rate: 47.0, 
        form_of_gov: "Mayor-Council", 
        size: 69.49, 
        median_household_income: 32639, 
        public_transit: false)
    end
    it 'show each city in the system including their attributes' do
      visit "/cities"

      expect(page).to have_content(@seattle.name)
      expect(page).to have_content("Population Estimates, July 1, 2021: #{@seattle.population}")
      expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@seattle.owner_occupied_housing_unit_rate}%")
      expect(page).to have_content("Form of Government: #{@seattle.form_of_gov}")
      expect(page).to have_content("Median Household Income (in 2020 Dollars), 2016-2020: $#{@seattle.median_household_income}")
      expect(page).to have_content("Has public transportation: #{@seattle.public_transit}")
      expect(page).to have_content("Size: #{@seattle.size}")
      expect(page).to have_content(@spokane.name)
      expect(page).to have_content("Population Estimates, July 1, 2021: #{@spokane.population}")
      expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@spokane.owner_occupied_housing_unit_rate}%")
      expect(page).to have_content("Form of Government: #{@spokane.form_of_gov}")
      expect(page).to have_content("Median Household Income (in 2020 Dollars), 2016-2020: $#{@spokane.median_household_income}")
      expect(page).to have_content("Has public transportation: #{@spokane.public_transit}")
      expect(page).to have_content("Size: #{@spokane.size}")
    end

    it "see a link at the top of the page that goes to states index" do
      visit "/cities"
      expect(page).to have_link("All States", :href => "/states")
    end

    it "has a link 'cities with public transit'" do
      visit "/cities"
      expect(page).to have_link("Cities with Public Transit", :href => "/cities?public_transit=true")   
    end

    it "When 'cities with public transit' link is clicked the user only see records for cities that do have public transit" do
      visit "/cities"
      click_link "Cities with Public Transit"

      expect(page).to have_content(@seattle.name)
      expect(page).to_not have_content(@republic.name)
    end

    it "There is a link to edit the city's info next to each city" do
      visit "/cities"

      expect(page).to have_link("Edit", :href => "/cities/#{@seattle.id}/edit")
      expect(page).to have_link("Edit", :href => "/cities/#{@spokane.id}/edit")
      expect(page).to have_link("Edit", :href => "/cities/#{@republic.id}/edit")
    end

    it "When a city's edit link is clicked user is take to that city's edit page" do
      visit "/cities"
      click_link "Edit", :href => "/cities/#{@seattle.id}/edit"

      expect(current_path).to eq("/cities/#{@seattle.id}/edit")

      visit "/cities"
      click_link "Edit", :href => "/cities/#{@republic.id}/edit"

      expect(current_path).to eq("/cities/#{@republic.id}/edit")
    end

    it "each city has a link to delete it" do
      visit "/cities"

      expect(page).to have_link("Delete #{@seattle.name}")
    end
  end
end