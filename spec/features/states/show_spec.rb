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
      expect(page).to have_content("Total number of cities: #{@washington.count}")
    end

    it "see a link at the top of the page that goes to cities index" do
      visit "/states/#{@washington.id}"
      expect(page).to have_link("All Cities", :href => "/cities")
    end

    it "see a link at the top of the page that goes to states index" do
      visit "/states/#{@washington.id}"
      expect(page).to have_link("All States", :href => "/states")
    end

    it "see link to each of the state's cities" do
      visit "/states/#{@washington.id}"

      expect(page).to have_link("#{@seattle.name}", :href => "/cities/#{@seattle.id}")
      expect(page).to have_link("#{@spokane.name}", :href => "/cities/#{@spokane.id}")
    end

    it "see link to update the state, 'Update State" do
      visit "/states/#{@washington.id}"

      expect(page).to have_link("Update State", :href => "/states/#{@washington.id}/edit")
    end

    it "click the link 'Update State' and fill out the form and is redirected to /states/:id" do
      visit "/states/#{@washington.id}"
      click_link "Update State"

      expect(page.current_path).to eq("/states/#{@washington.id}/edit")
      expect(page).to have_content("Update the #{@washington.name} State Record")
    end

    it "see a link to add a new city for the state called 'Add City'" do
      visit "/states/#{@washington.id}"

      expect(page).to have_link("Add City", :href => "/states/#{@washington.id}/cities/new")
     end

     it "when Add City link is clicked, user is taken to a new page to fill in fields for the new city" do
      visit "/states/#{@washington.id}"
      click_link "Add City"

      expect(page.current_path).to eq("/states/#{@washington.id}/cities/new")
      expect(page).to have_content("Add a New City Record for #{@washington.name} State")
     end

     it "See a link to delete the state" do
      visit "/states/#{@california.id}"

      expect(page).to have_link("Delete State", :href => "/states/#{@california.id}/delete")
     end
  end
end