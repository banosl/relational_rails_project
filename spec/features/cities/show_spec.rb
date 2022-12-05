require 'rails_helper'

RSpec.describe "Cities Show", type: :feature do
  describe "When I visit cities/:id" do
    before :each do
      @washington = State.create!(name:"Washington", 
        population:7.739, 
        gdp:577.2, 
        size:71362, 
        coastal:true)
      @colorado = State.create!(name:"Colorado", 
        population:5.812, 
        gdp:373.76, 
        size:104185, 
        coastal:false)
      @california = State.create!(name:"California", 
        population:39.24, 
        gdp:3.37, 
        size:163696, 
        coastal:true)

      @seattle = @washington.cities.create!(
        name: "Seattle", 
        population: 733919, 
        owner_occupied_housing_unit_rate: 44.9, 
        form_of_gov: "Mayor-Council", 
        size: 83.78, 
        median_household_income: 97185, 
        public_transit: true)
      @spokane = @washington.cities.create!(
        name: "Spokane", 
        population: 229071, 
        owner_occupied_housing_unit_rate: 56.0, 
        form_of_gov: "Mayor-Council", 
        size: 69.49, 
        median_household_income: 52600, 
        public_transit: true)
      @denver = @colorado.cities.create!(
        name: "Denver", 
        population: 711463, 
        owner_occupied_housing_unit_rate: 50.4, 
        form_of_gov: "Consolidated City-County", 
        size: 154.7, 
        median_household_income: 72661, 
        public_transit: true)
    end
    it "I see the city with that id including its attributes" do
        visit "cities/#{@seattle.id}"

        expect(page).to have_content(@seattle.name)
        expect(page).to have_content("Population Estimates, July 1, 2021: #{@seattle.population}")
        expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@seattle.owner_occupied_housing_unit_rate}%")
        expect(page).to have_content("Form of Government: #{@seattle.form_of_gov}")
        expect(page).to have_content("Median Household Income (in 2020 Dollars), 2016-2020: $#{@seattle.median_household_income}")
        expect(page).to have_content("Has public transportation: #{@seattle.public_transit}")
        expect(page).to have_content("Size in: #{@seattle.size} mi^2")
        expect(page).to_not have_content(@spokane.name)
        expect(page).to_not have_content(@spokane.population)
    end
    it "see a link at the top of the page that goes to cities index" do
        visit "cities/#{@seattle.id}"
        expect(page).to have_link("All Cities", :href => "/cities")

        visit "cities/#{@spokane.id}"
        expect(page).to have_link("All Cities", :href => "/cities")
    end

    it "see a link at the top of the page that goes to states index" do
      visit "cities/#{@seattle.id}"
      expect(page).to have_link("All States", :href => "/states")
      
      visit "cities/#{@spokane.id}"
      expect(page).to have_link("All States", :href => "/states")
    end

    it "see a link to update the city, 'Update City'" do
      visit "cities/#{@seattle.id}"

      expect(page).to have_link("Update City", :href => "/cities/#{@seattle.id}/edit")
    end

    it "when 'Update City' is clicked the user is taken to a form to update the city's attributes" do
      visit "cities/#{@seattle.id}"
      click_link "Update City"

      expect(page.current_url).to eq("http://www.example.com/cities/#{@seattle.id}/edit")
      expect(page).to have_content("Update the Record for the City of #{@seattle.name}")
    end
  end
end