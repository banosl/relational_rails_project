require 'rails_helper'

RSpec.describe "State's City Index", type: :feature do
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
          @colorado = State.create!(name:"Colorado", 
            population:5.812, 
            gdp:373.76, 
            size:104185, 
            coastal:false)
          @denver = @colorado.cities.create!(name: "Denver", 
              population: 711463, 
              owner_occupied_housing_unit_rate: 50.4, 
              form_of_gov: "Consolidated City-County", 
              size: 154.7, 
              median_household_income: 72661, 
              public_transit: true)
    end
  
    describe "When I visit states/:state_id/city" do
      it "See each city that is associated with the state" do
        visit "/states/#{@washington.id}/cities"
        # save_and_open_page

        expect(page).to have_content(@seattle.name)
        expect(page).to have_content(@spokane.name)
        expect(page).to_not have_content(@denver.name)
      end

     it "See each city's attributes" do
       visit "/states/#{@washington.id}/cities"
       
       expect(page).to have_content("Population Estimates, July 1, 2021: #{@seattle.population}")
       expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@seattle.owner_occupied_housing_unit_rate}%")
       expect(page).to have_content("Population Estimates, July 1, 2021: #{@spokane.population}")
       expect(page).to have_content("Owner Occupied Housing Unit Rate, 2016-2020: #{@spokane.owner_occupied_housing_unit_rate}%")
       expect(page).to have_content("Form of Government: #{@spokane.form_of_gov}")
       expect(page).to_not have_content(@denver.population)
     end

     it "see a link at the top of the page that goes to cities index" do
      visit "/states/#{@washington.id}/cities"
      save_and_open_page
      expect(page).to have_link("All Cities", :href => "/cities")
    end
    end
end