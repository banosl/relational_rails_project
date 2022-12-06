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
          @republic = @washington.cities.create!(name: "Republic",
            population: 1144, 
            owner_occupied_housing_unit_rate: 47.0, 
            form_of_gov: "Mayor-Council", 
            size: 1.421, 
            median_household_income: 32639, 
            public_transit: false)
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
      expect(page).to have_link("All Cities", :href => "/cities")
     end

     it "see a link at the top of the page that goes to states index" do
      visit "/states/#{@washington.id}/cities"
      expect(page).to have_link("All States", :href => "/states")
     end

     it "see a link to add a new city for the state called 'Add City'" do
      visit "/states/#{@washington.id}/cities"

      expect(page).to have_link("Add City", :href => "/states/#{@washington.id}/cities/new")
     end

     it "when Add City link is clicked, user is taken to a new page to fill in fields for the new city" do
      visit "/states/#{@washington.id}/cities"
      click_link "Add City"

      expect(page.current_path).to eq("/states/#{@washington.id}/cities/new")
      expect(page).to have_content("Add a New City Record for #{@washington.name} State")
     end

     it "has a link 'Sort Cities by Alphabetical Order'" do
      visit "/states/#{@washington.id}/cities"
      
      expect(page).to have_link("Sort Cities by Alphabetical Order", :href => "/states/#{@washington.id}/cities?sort=alphabetical")   
    end

    describe "Alphabetical Order" do
      let(:seattle) {"Seattle"}
      let(:spokane) {"Spokane"}
      let(:republic) {"Republic"}

      it "When 'Sort Cities by Alphabetical Order' link is clicked the user sees cities in that order" do
        visit "/states/#{@washington.id}/cities"
        click_link "Sort Cities by Alphabetical Order"
        
        expect(republic).to appear_before(seattle)
        expect(seattle).to appear_before(spokane)
        expect(spokane).to_not appear_before(republic)
      end
    end

    it "There is a link to edit the city's info next to each city" do
      visit "/states/#{@washington.id}/cities"

      expect(page).to have_link("Edit", :href => "/cities/#{@seattle.id}/edit")
      expect(page).to have_link("Edit", :href => "/cities/#{@spokane.id}/edit")
      expect(page).to have_link("Edit", :href => "/cities/#{@republic.id}/edit")
    end

    it "When a city's edit link is clicked user is take to that city's edit page" do
      visit "/states/#{@washington.id}/cities"
      click_link "Edit", :href => "/cities/#{@seattle.id}/edit"

      expect(current_path).to eq("/cities/#{@seattle.id}/edit")

      visit "/states/#{@washington.id}/cities"
      click_link "Edit", :href => "/cities/#{@republic.id}/edit"

      expect(current_path).to eq("/cities/#{@republic.id}/edit")
    end

    it "has a form that allows user to enter a value for city size" do
      visit "/states/#{@washington.id}/cities"

      expect(page).to have_field(:miles_squared)
      expect(page).to have_button("Cities Bigger than This")
    end

    xit "when a value is entered and the submit button is clicked the user is brought back to the current page with just the cities over that size" do
      visit "/states/#{@washington.id}/cities"
      fill_in :miles_squared, with: 70.0
# binding.pry
      expect(page).to_not have_content(@spokane.name)
      expect(page).to_not have_content(@republic.name)
    end

    it "each city has a link to delete it" do
      visit "/states/#{@washington.id}/cities"

      expect(page).to have_link("Delete #{@seattle.name}")
    end    

    it "when delete city is clicked the page refreshes and the chosen city is gone" do
      visit "/states/#{@washington.id}/cities"
      
      expect(page).to have_content("Seattle")

      click_link "Delete #{@seattle.name}"

      expect(current_path).to eq("/states/#{@washington.id}/cities")
      expect(page).to_not have_content("Seattle")
    end
  end
end