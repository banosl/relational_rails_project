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
    end
    it 'show each city in the system including their attributes' do
      visit "/cities"
      save_and_open_page
      expect(page).to have_content(@seattle.name)
      expect(page).to have_content("Population Estimates, July 1, 2021: #{@seattle.population}")
      expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@seattle.owner_occupied_housing_unit_rate}%")
      expect(page).to have_content("Form of Government: #{@seattle.form_of_gov}")
      expect(page).to have_content("Median Household Income (in 2020 Dollars), 2016-2020: $#{@seattle.median_household_income}")
      expect(page).to have_content("Has public transportation: #{@seattle.public_transit}")
      expect(page).to have_content("Size in mi^2: #{@seattle.size}")
      expect(page).to have_content(@spokane.name)
      expect(page).to have_content("Population Estimates, July 1, 2021: #{@spokane.population}")
      expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@spokane.owner_occupied_housing_unit_rate}%")
      expect(page).to have_content("Form of Government: #{@spokane.form_of_gov}")
      expect(page).to have_content("Median Household Income (in 2020 Dollars), 2016-2020: $#{@spokane.median_household_income}")
      expect(page).to have_content("Has public transportation: #{@spokane.public_transit}")
      expect(page).to have_content("Size in mi^2: #{@spokane.size}")
    end

    it "see a link at the top of the page that goes to states index" do
      visit "/cities"
      expect(page).to have_link("All States", :href => "/states")
    end
  end
end