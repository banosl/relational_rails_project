require 'rails_helper'

RSpec.describe "States Show", type: :feature do
  describe "When I visit '/states/:id'" do
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
    it "see the state with that id including the parent's attributes" do
        visit "/states/#{@washington.id}"
        # save_and_open_page

        expect(page).to have_content(@washington.name)
        expect(page).to have_content(@washington.population)
        expect(page).to have_content(@washington.gdp)
        expect(page).to have_content(@washington.size)
        expect(page).to have_content(@washington.coastal)
        expect(page).to_not have_content(@california.name)
        expect(page).to_not have_content(@colorado.population)
    end

    it 'see a count of the number of cities for the state' do
      visit "/states/#{@washington.id}"
      save_and_open_page
      expect(page).to have_content("Total number of cities: #{@washington.count}")
    end

  end
end